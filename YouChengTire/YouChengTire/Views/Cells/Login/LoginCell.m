//
//  LoginCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/3.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LoginCell.h"
// ViewModels
#import "LoginVM.h"

@implementation LoginCell

#pragma mark - Static Private
+ (NSArray *)loadNib {
    return [self loadNibNamed:@"LoginCell"];
}

- (void)configureBorder:(UIView *)view {
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 6;
    view.layer.borderColor = [UIColor clearColor].CGColor;
}

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface LoginFirstCell () <
UITextFieldDelegate
>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIView *usernameView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@end

@implementation LoginFirstCell

- (void)awakeFromNib {
    // Initialization code
    [self configureTextField];
    [self configureButton];
}

#pragma mark - Override
+ (instancetype)createCell {
    return [self loadNib][0];
}

- (void)bindViewModel:(LoginVM *)viewModel {
    RAC(viewModel, loginName) = _usernameTextField.rac_textSignal;
    RAC(viewModel, password) = _passwordTextField.rac_textSignal;
}

- (CGFloat)height { return 220.f; }

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:_usernameTextField]) {
        [_passwordTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return NO;
}

#pragma mark - private
- (void)configureTextField {
    [self configureBorder:_usernameView];
    [self configureBorder:_passwordView];
}

- (void)configureButton {
    [self configureBorder:_loginButton];
}

#pragma mark - Event Response
- (IBAction)login:(id)sender {
    if (_usernameTextField.text.length == 0) {
        kMRCInfo(@"请输入用户名");
        return;
    }
    
    if (_passwordTextField.text.length == 0) {
        kMRCInfo(@"请输入密码");
        return;
    }
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(login)]) {
            [self.delegate login];
        }
    }
}

- (IBAction)uRegister:(id)sender {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(uRegister)]) {
            [self.delegate uRegister];
        }
    }
}

- (IBAction)forgetPwd:(id)sender {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(forgetPwd)]) {
            [self.delegate forgetPwd];
        }
    }
}

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface LoginSecondCell () <
UITextFieldDelegate
>

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;

@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *verificationCodeView;
@property (weak, nonatomic) IBOutlet UIView *authView;

@property (weak, nonatomic) IBOutlet UIButton *authButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (strong, nonatomic) LoginVM *viewModel;

@end

@implementation LoginSecondCell

- (void)awakeFromNib {
    // Initialization code
    [self configureTextField];
    [self configureButton];
}

#pragma mark - Override
+ (instancetype)createCell {
    return [self loadNib][1];
}

- (void)bindViewModel:(LoginVM *)viewModel {
    _viewModel = viewModel;
    
    RAC(viewModel, mobile) = _phoneTextField.rac_textSignal;
    RAC(viewModel, verificationCode) = _verificationCodeTextField.rac_textSignal;
}

- (CGFloat)height { return 182.f; }

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:_phoneTextField]) {
        [_verificationCodeTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return NO;
}

#pragma mark - private
- (void)configureTextField {
    [self configureBorder:_phoneView];
    [self configureBorder:_verificationCodeView];
    
    _authView.layer.borderWidth = 1;
    _authView.layer.cornerRadius = 6;
    _authView.layer.borderColor = RGB(238, 72, 72).CGColor;
}

- (void)configureButton {
    [self configureBorder:_loginButton];
}

- (void)requestAuthCode {
    [MBProgressHUD showHUDAddedTo:_viewModel.loadingSuperV
                         animated:NO];
    @weakify(self)
    [_viewModel requestAuthCode:^(id object) {
        @strongify(self)
        [self startWithTime:60];
        kMRCSuccess(@"验证码已发送");
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:_viewModel.loadingSuperV
                             animated:YES];
    }];
}

/**
 *  验证码倒计时
 *
 *  @param timeLine timeLine description
 */
- (void)startWithTime:(NSInteger)timeLine {
    __weak typeof(self) weakSelf = self;
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.authButton setTitle:@"获取验证码"
                                     forState:UIControlStateNormal];
                weakSelf.authButton.userInteractionEnabled = YES;
            });
        } else {
            int allTime = (int)timeLine + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.authButton setTitle:[NSString stringWithFormat:@"%@ 秒", timeStr]
                                     forState:UIControlStateNormal];
                weakSelf.authButton.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - Event Response
- (IBAction)loginByMobile:(id)sender {
    if (_phoneTextField.text.length == 0) {
        kMRCInfo(@"请输入手机号码");
        return;
    }
    
    NSString *regex = @"^1[3|4|5|7|8][0-9]\\d{4,8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:_phoneTextField.text];
    if (!isValid) {
        kMRCInfo(@"请输入正确的手机号码");
        return;
    }
    
    if (_verificationCodeTextField.text.length == 0) {
        kMRCInfo(@"请输入验证码");
        return;
    }
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(loginByMobile)]) {
            [self.delegate loginByMobile];
        }
    }
}

- (IBAction)authCode:(id)sender {
    if (_phoneTextField.text.length == 0) {
        kMRCInfo(@"请输入手机号码");
        return;
    }
    
    [self requestAuthCode];
}

@end