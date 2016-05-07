//
//  FeedbackCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/4.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "FeedbackCell.h"
// ViewModels
#import "FeedbackVM.h"

@interface FeedbackCell ()

@property (weak, nonatomic) IBOutlet UITextView *opinionTextView;
@property (weak, nonatomic) IBOutlet UITextField *opinionTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactTextField;

@property (weak, nonatomic) IBOutlet UIView *opinionView;
@property (weak, nonatomic) IBOutlet UIView *contactView;

@property (weak, nonatomic) IBOutlet UIButton *feedbackButton;

@end

@implementation FeedbackCell

- (void)awakeFromNib {
    // Initialization code
    [self configureTextField];
    [self configureButton];
}

#pragma mark - Override
- (void)bindViewModel:(FeedbackVM *)viewModel {
    RAC(viewModel, content) = _opinionTextView.rac_textSignal;
    RAC(viewModel, mobile) = _contactTextField.rac_textSignal;
    RAC(_opinionTextField, hidden) = viewModel.validPlaceholderSignal;
}

#pragma mark - private
- (void)configureTextField {
    [self configureBorder:_opinionView];
    [self configureBorder:_contactView];
}

- (void)configureButton {
    _feedbackButton.layer.borderWidth = 1;
    _feedbackButton.layer.cornerRadius = 6;
    _feedbackButton.layer.borderColor = [UIColor clearColor].CGColor;
}

- (void)configureBorder:(UIView *)view {
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 6;
    view.layer.borderColor = RGB(153, 153, 153).CGColor;
}

#pragma mark - Event Response
- (IBAction)feedback:(id)sender {
    if (_opinionTextView.text.length == 0) {
        kMRCInfo(@"请输入意见反馈");
        return;
    }
    
    if (_contactTextField.text.length == 0) {
        kMRCInfo(@"请输入联系方式");
        return;
    }
    
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(feedback)]) {
            [_delegate feedback];
        }
    }
}

@end
