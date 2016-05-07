//
//  ChangePwdCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/4.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "ChangePwdCell.h"
// ViewModels
#import "ChangePwdVM.h"

@interface ChangePwdCell () <
UITextFieldDelegate
>

@property (nonatomic, weak) IBOutlet UITextField *originalPasswordTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UITextField *confirmPasswordTextField;

@end

@implementation ChangePwdCell

#pragma mark - Override
- (void)bindViewModel:(ChangePwdVM *)viewModel {
    RAC(viewModel, originalPassword) = _originalPasswordTextField.rac_textSignal;
    RAC(viewModel, password) = _passwordTextField.rac_textSignal;
    RAC(viewModel, confirmPassword) = _confirmPasswordTextField.rac_textSignal;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:_originalPasswordTextField]) {
        [_passwordTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_passwordTextField]) {
        [_confirmPasswordTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return NO;
}

@end
