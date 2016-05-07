//
//  ReceiptAddressCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/10.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "ReceiptAddressCell.h"
// ViewModels
#import "ReceiptAddressVM.h"
// Models
#import "ReceiptAddressM.h"

@implementation ReceiptAddressCell

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface ReceiptAddressFirstCell ()

@property (nullable, nonatomic, weak) IBOutlet NSLayoutConstraint *leftLayoutConstraint;
@property (nullable, nonatomic, weak) IBOutlet NSLayoutConstraint *rightLayoutConstraint;

@property (nullable, nonatomic, weak) IBOutlet UIImageView *defalutImageView;
@property (nullable, nonatomic, weak) IBOutlet UIImageView *selectImageView;

@property (nullable, nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nullable, nonatomic, weak) IBOutlet UILabel *subtitleLabel;

@property (nullable, nonatomic, strong) ReceiptAddressItemM *model;

@end

@implementation ReceiptAddressFirstCell

- (void)configureCell:(ReceiptAddressItemM *)model {
    _model = model;
    
    _defalutImageView.hidden = ![model.isDefault boolValue];
    _titleLabel.text = [NSString stringWithFormat:@"%@    %@",
                        model.name,
                        model.mobile];
    _subtitleLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",
                           model.province,
                           model.city,
                           model.county,
                           model.detail];
    if ([model.isSelectNumber boolValue]) {
        _selectImageView.image = GETIMAGE(@"me_option_red");
    }
    else {
        _selectImageView.image = GETIMAGE(@"me_option_grey");
    }
}

- (void)bindViewModel:(ReceiptAddressVM *)viewModel {
    @weakify(self)
    [RACObserve(viewModel, isEditNumber)
     subscribeNext:^(NSNumber *isEditNumber) {
         @strongify(self)
         BOOL isEdit = [isEditNumber boolValue];
         if (isEdit) {
             self.leftLayoutConstraint.constant = 0;
             self.rightLayoutConstraint.constant = 0;
         }
         else {
             self.leftLayoutConstraint.constant = -30;
             self.rightLayoutConstraint.constant = 30;
         }
     }];
    
    [RACObserve(_model, isSelectNumber)
     subscribeNext:^(NSNumber *isSelectNumber) {
         @strongify(self)
         BOOL isSelect = [isSelectNumber boolValue];
         if (isSelect) {
             self.selectImageView.image = GETIMAGE(@"me_option_red");
         }
         else {
             self.selectImageView.image = GETIMAGE(@"me_option_grey");
         }
     }];
}

- (void)selectCell {
    _model.isSelectNumber = @(![_model.isSelectNumber boolValue]);
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(refreshSelectAllStatus)]) {
            [self.delegate refreshSelectAllStatus];
        }
    }
}

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface ReceiptAddressSecondCell ()

@property (weak, nonatomic) IBOutlet UIView *addView;

@end

@implementation ReceiptAddressSecondCell

- (void)awakeFromNib {
    // Initialization code
    _addView.layer.borderWidth = 1;
    _addView.layer.cornerRadius = 6;
    _addView.layer.borderColor = RGB(154, 154, 154).CGColor;
}

@end

