//
//  ReceiptCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/23.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "ReceiptCell.h"
// ViewModels
#import "ReceiptVM.h"

@implementation ReceiptCell

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface ReceiptFirstCell ()

@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;

@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;

@property (strong, nonatomic) ReceiptVM *receiptVM;

@end

@implementation ReceiptFirstCell

- (void)awakeFromNib {
    // Initialization code
    [self configureBorder:_firstView];
    [self configureBorder:_secondView];
    [self configureBorder:_thirdView];
}

- (void)bindViewModel:(id)viewModel {
    _receiptVM = viewModel;
    [self updateReceiptStatus:[_receiptVM.receiptTypeNumber integerValue]];
}

- (void)configureBorder:(UIView *)view {
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 6;
    view.layer.borderColor = RGB(120, 120, 120).CGColor;
}

- (void)configureBorderCheck:(UIView *)view {
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 6;
    view.layer.borderColor = RGB(235, 77, 66).CGColor;
}

- (IBAction)checkMethod:(id)sender {
    UIButton *button = (UIButton *)sender;
    [self updateReceiptStatus:button.tag];
}

- (CGFloat)height { return 78.f; }

- (void)updateReceiptStatus:(NSInteger)tag {
    switch (tag) {
        case 0: {
            [self configureBorderCheck:_firstView];
            [self configureBorder:_secondView];
            [self configureBorder:_thirdView];
            
            _firstLabel.textAlignment = NSTextAlignmentRight;
            _secondLabel.textAlignment = NSTextAlignmentCenter;
            _thirdLabel.textAlignment = NSTextAlignmentCenter;
            
            _firstLabel.textColor = RGB(235, 77, 66);
            _secondLabel.textColor = RGB(120, 120, 120);
            _thirdLabel.textColor = RGB(120, 120, 120);
            
            _firstImageView.hidden = NO;
            _secondImageView.hidden = YES;
            _thirdImageView.hidden = YES;
            
            if (![_receiptVM.receiptTypeNumber isEqual:@0]) {
                _receiptVM.receiptTypeNumber = @0;
            }
        }
            break;
            
        case 1: {
            [self configureBorder:_firstView];
            [self configureBorderCheck:_secondView];
            [self configureBorder:_thirdView];
            
            _firstLabel.textAlignment = NSTextAlignmentCenter;
            _secondLabel.textAlignment = NSTextAlignmentRight;
            _thirdLabel.textAlignment = NSTextAlignmentCenter;
            
            _firstLabel.textColor = RGB(120, 120, 120);
            _secondLabel.textColor = RGB(235, 77, 66);
            _thirdLabel.textColor = RGB(120, 120, 120);
            
            _firstImageView.hidden = YES;
            _secondImageView.hidden = NO;
            _thirdImageView.hidden = YES;
            
            if (![_receiptVM.receiptTypeNumber isEqual:@1]) {
                _receiptVM.receiptTypeNumber = @1;
            }
        }
            break;
            
        case 2: {
            [self configureBorder:_firstView];
            [self configureBorder:_secondView];
            [self configureBorderCheck:_thirdView];
            
            _firstLabel.textAlignment = NSTextAlignmentCenter;
            _secondLabel.textAlignment = NSTextAlignmentCenter;
            _thirdLabel.textAlignment = NSTextAlignmentRight;
            
            _firstLabel.textColor = RGB(120, 120, 120);
            _secondLabel.textColor = RGB(120, 120, 120);
            _thirdLabel.textColor = RGB(235, 77, 66);
            
            _firstImageView.hidden = YES;
            _secondImageView.hidden = YES;
            _thirdImageView.hidden = NO;
            
            if (![_receiptVM.receiptTypeNumber isEqual:@2]) {
                _receiptVM.receiptTypeNumber = @2;
            }
        }
            break;
            
        default:
            break;
    }
}

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface ReceiptSecondCell ()

@property (strong, nonatomic) ReceiptVM *viewModel;

@property (weak, nonatomic) IBOutlet UIView *nameView;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation ReceiptSecondCell

- (void)awakeFromNib {
    // Initialization code
    [self configureBorder:_nameView];
}

- (void)configureBorder:(UIView *)view {
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 4;
    view.layer.borderColor = RGB(153, 153, 153).CGColor;
}

#pragma mark - Override
- (void)bindViewModel:(ReceiptVM *)viewModel {
    _viewModel = viewModel;
    
    @weakify(self);
    [[_nameTextField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(id x) {
         @strongify(self);
         self.viewModel.name = x;
     }];
}

- (void)configureCell:(NSDictionary *)model {
    if ([_viewModel.receiptTypeNumber integerValue] == 1) {
        if (model[@"receipt0"]) {
            NSDictionary *receipt0 = model[@"receipt0"];
            _nameTextField.text = receipt0[@"name"];
            _viewModel.name = receipt0[@"name"];
        }
    }
    else {
        if (model[@"receipt1"]) {
            NSDictionary *receipt1 = model[@"receipt1"];
            _nameTextField.text = receipt1[@"name"];
            _viewModel.name = receipt1[@"name"];
        }
    }
}

- (CGFloat)height { return 93.f; }

@end

/*****************************************************************************************
 * 三
 *****************************************************************************************/
@interface ReceiptThirdCell ()

@property (strong, nonatomic) ReceiptVM *viewModel;

@property (weak, nonatomic) IBOutlet UIView *identifyView;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *bankView;
@property (weak, nonatomic) IBOutlet UIView *accountView;

@property (weak, nonatomic) IBOutlet UITextField *identifyTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *bankTextField;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;

@end

@implementation ReceiptThirdCell

- (void)awakeFromNib {
    // Initialization code
    [self configureBorder:_identifyView];
    [self configureBorder:_addressView];
    [self configureBorder:_phoneView];
    [self configureBorder:_bankView];
    [self configureBorder:_accountView];
}

- (void)configureBorder:(UIView *)view {
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 4;
    view.layer.borderColor = RGB(153, 153, 153).CGColor;
}

#pragma mark - Override
- (void)bindViewModel:(ReceiptVM *)viewModel {
    _viewModel = viewModel;
    
    @weakify(self);
    [[_identifyTextField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(id x) {
         @strongify(self);
         self.viewModel.number = x;
     }];
    [[_addressTextField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(id x) {
         @strongify(self);
         self.viewModel.address = x;
     }];
    [[_phoneTextField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(id x) {
         @strongify(self);
         self.viewModel.phone = x;
     }];
    [[_bankTextField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(id x) {
         @strongify(self);
         self.viewModel.blank = x;
     }];
    [[_accountTextField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(id x) {
         @strongify(self);
         self.viewModel.blankNumber = x;
     }];
}

- (void)configureCell:(NSDictionary *)model {
    if (model[@"receipt1"]) {
        NSDictionary *receipt1 = model[@"receipt1"];
        _identifyTextField.text = receipt1[@"number"];
        _viewModel.number = receipt1[@"number"];
        _addressTextField.text = receipt1[@"address"];
        _viewModel.address = receipt1[@"address"];
        _phoneTextField.text = receipt1[@"phone"];
        _viewModel.phone = receipt1[@"phone"];
        _bankTextField.text = receipt1[@"blank"];
        _viewModel.blank = receipt1[@"blank"];
        _accountTextField.text = receipt1[@"blankNumber"];
        _viewModel.blankNumber = receipt1[@"blankNumber"];
    }
}

- (CGFloat)height { return 245.f; }

@end