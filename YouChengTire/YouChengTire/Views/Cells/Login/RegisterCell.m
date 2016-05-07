//
//  RegisterCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/3.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "RegisterCell.h"
// ViewModels
#import "RegisterVM.h"

@interface RegisterCell () <
UITextFieldDelegate
>

@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *inviteCodeTextField;

@property (weak, nonatomic) IBOutlet UIView *mobileView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIView *confirmPwView;
@property (weak, nonatomic) IBOutlet UIView *verificationCodeView;
@property (weak, nonatomic) IBOutlet UIView *inviteCodeView;
@property (weak, nonatomic) IBOutlet UIView *authView;

@property (weak, nonatomic) IBOutlet UIButton *authButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (strong, nonatomic) RegisterVM *viewModel;

@end

@implementation RegisterCell

- (void)awakeFromNib {
    // Initialization code
    [self configureTextField];
    [self configureButton];
}

#pragma mark - Override
- (void)bindViewModel:(RegisterVM *)viewModel {
    _viewModel = viewModel;
    
    RAC(viewModel, mobile) = _mobileTextField.rac_textSignal;
    RAC(viewModel, password) = _passwordTextField.rac_textSignal;
    RAC(viewModel, verificationCode) = _verificationCodeTextField.rac_textSignal;
    RAC(viewModel, inviteCode) = _inviteCodeTextField.rac_textSignal;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:_mobileTextField]) {
        [_passwordTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_passwordTextField]) {
        [_confirmPwdTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_confirmPwdTextField]) {
        [_verificationCodeTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_verificationCodeTextField]) {
        [_inviteCodeTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return NO;
}

#pragma mark - private
- (void)configureTextField {
    [self configureBorder:_mobileView];
    [self configureBorder:_passwordView];
    [self configureBorder:_confirmPwView];
    [self configureBorder:_verificationCodeView];
    [self configureBorder:_inviteCodeView];
    
    _authView.layer.borderWidth = 1;
    _authView.layer.cornerRadius = 6;
    _authView.layer.borderColor = RGB(238, 72, 72).CGColor;
}

- (void)configureButton {
    [self configureBorder:_registerButton];
}

- (void)configureBorder:(UIView *)view {
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 6;
    view.layer.borderColor = [UIColor clearColor].CGColor;
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
- (IBAction)uRegister:(id)sender {
    if (_mobileTextField.text.length == 0) {
        kMRCInfo(@"请输入手机号码");
        return;
    }
    
    NSString *regex = @"^1[3|4|5|7|8][0-9]\\d{4,8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:_mobileTextField.text];
    if (!isValid) {
        kMRCInfo(@"请输入正确的手机号码");
        return;
    }
    
    if (_passwordTextField.text.length == 0) {
        kMRCInfo(@"请输入密码");
        return;
    }
    
    if (_confirmPwdTextField.text.length == 0) {
        kMRCInfo(@"请输入密码确认");
        return;
    }
    
    if (![_passwordTextField.text isEqualToString:_confirmPwdTextField.text]) {
        kMRCInfo(@"密码和密码确认不一致");
        return;
    }
    
    if (_verificationCodeTextField.text.length == 0) {
        kMRCInfo(@"请输入验证码");
        return;
    }
    
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(uRegister)]) {
            [_delegate uRegister];
        }
    }
}

- (IBAction)authCode:(id)sender {
    if (_mobileTextField.text.length == 0) {
        kMRCInfo(@"请输入手机号码");
        return;
    }
    
    [self requestAuthCode];
}

@end
