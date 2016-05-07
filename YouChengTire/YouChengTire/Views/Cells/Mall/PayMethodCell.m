//
//  PayMethodCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "PayMethodCell.h"
// ViewMoels
#import "PayMethodVM.h"

@implementation PayMethodCell

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface PayMethodFirstCell ()

@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;

@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@property (strong, nonatomic) PayMethodVM *payMethodVM;

@end

@implementation PayMethodFirstCell

- (void)awakeFromNib {
    // Initialization code
    [self configureBorder:_firstView];
    [self configureBorder:_secondView];
}

- (void)bindViewModel:(id)viewModel {
    _payMethodVM = viewModel;
    [self updateReceiptStatus:[_payMethodVM.payMethodTypeNumber integerValue]];
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
            
            _firstLabel.textAlignment = NSTextAlignmentRight;
            _secondLabel.textAlignment = NSTextAlignmentCenter;
            
            _firstLabel.textColor = RGB(235, 77, 66);
            _secondLabel.textColor = RGB(120, 120, 120);
            
            _firstImageView.hidden = NO;
            _secondImageView.hidden = YES;
            
            if (![_payMethodVM.payMethodTypeNumber isEqual:@0]) {
                _payMethodVM.payMethodTypeNumber = @0;
            }
        }
            break;
            
        case 1: {
            [self configureBorder:_firstView];
            [self configureBorderCheck:_secondView];
            
            _firstLabel.textAlignment = NSTextAlignmentCenter;
            _secondLabel.textAlignment = NSTextAlignmentRight;
            
            _firstLabel.textColor = RGB(120, 120, 120);
            _secondLabel.textColor = RGB(235, 77, 66);
            
            _firstImageView.hidden = YES;
            _secondImageView.hidden = NO;
            
            if (![_payMethodVM.payMethodTypeNumber isEqual:@1]) {
                _payMethodVM.payMethodTypeNumber = @1;
            }
        }
            break;
            
        default:
            break;
    }
}

@end
