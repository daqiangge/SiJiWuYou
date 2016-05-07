//
//  InstallMethodCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/21.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "InstallMethodCell.h"
// ViewModels
#import "InstallMethodVM.h"

@implementation InstallMethodCell

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface InstallMethodFirstCell ()

@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;

@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;

@property (strong, nonatomic) InstallMethodVM *installMethodVM;

@end

@implementation InstallMethodFirstCell

- (void)awakeFromNib {
    // Initialization code
    [self configureBorder:_firstView];
    [self configureBorder:_secondView];
    [self configureBorder:_thirdView];
}

- (void)bindViewModel:(InstallMethodVM *)viewModel {
    _installMethodVM = viewModel;
    [self updatePickedUpTypeStatus:[_installMethodVM.pickedUpTypeNumber integerValue]];
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
    [self updatePickedUpTypeStatus:button.tag];
}

- (CGFloat)height { return 78.f; }

- (void)updatePickedUpTypeStatus:(NSInteger)tag {
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
            
            if (![_installMethodVM.pickedUpTypeNumber isEqual:@0]) {
                _installMethodVM.pickedUpTypeNumber = @0;
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
            
            if (![_installMethodVM.pickedUpTypeNumber isEqual:@1]) {
                _installMethodVM.pickedUpTypeNumber = @1;
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
            
            if (![_installMethodVM.pickedUpTypeNumber isEqual:@2]) {
                _installMethodVM.pickedUpTypeNumber = @2;
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
@interface InstallMethodSecondCell ()

@property (nonatomic, weak) IBOutlet UILabel *addressLabel;

@end

@implementation InstallMethodSecondCell

- (void)bindViewModel:(InstallMethodVM *)viewModel {
    _addressLabel.text = viewModel.belongAddress;
}

@end
