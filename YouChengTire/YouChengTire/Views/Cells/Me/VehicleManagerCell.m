//
//  VehicleManagerCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/10.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "VehicleManagerCell.h"
// ViewModels
#import "VehicleManagerVM.h"
// Models
#import "VehicleManagerM.h"

@implementation VehicleManagerCell

#pragma mark - Static Private
+ (NSArray *)loadNib {
    return [self loadNibNamed:@"VehicleManagerCell"];
}

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface VehicleManagerFirstCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLayoutConstraint;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *defalutImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;

@property (strong, nonatomic) NSDictionary *model;

@property (nonatomic, strong) VehicleTruckM *vehicleTruckM;
@property (nonatomic, strong) VehicleTireM *vehicleTireM;

@end

@implementation VehicleManagerFirstCell

#pragma mark - Override
+ (id)createCell {
    return [self loadNib][0];
}

- (void)configureCell:(id)model {
    if ([model isMemberOfClass:VehicleTruckM.class]) {
        // 车辆
        _vehicleTruckM = (VehicleTruckM *)model;
        
        _titleLabel.text = _vehicleTruckM.model;
        _subtitleLabel.text = [NSString stringWithFormat:@"%@ %@",
                               _vehicleTruckM.brand,
                               _vehicleTruckM.number];
        _defalutImageView.hidden = ![_vehicleTruckM.isDefault boolValue];
        
        if ([_vehicleTruckM.isSelectNumber boolValue]) {
            _selectImageView.image = GETIMAGE(@"me_option_red");
        }
        else {
            _selectImageView.image = GETIMAGE(@"me_option_grey");
        }
        
        @weakify(self)
        [RACObserve(_vehicleTruckM, isSelectNumber)
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
    
    if ([model isMemberOfClass:VehicleTireM.class]) {
        // 轮胎
        _vehicleTireM = (VehicleTireM *)model;
        
        _titleLabel.text = [NSString stringWithFormat:@"%@ %@",
                            _vehicleTireM.series,
                            _vehicleTireM.standard];
        _subtitleLabel.text = [NSString stringWithFormat:@"%@ %@",
                               _vehicleTireM.brand,
                               _vehicleTireM.pattern];
        _defalutImageView.hidden = ![_vehicleTireM.isDefault boolValue];
        
        if ([_vehicleTireM.isSelectNumber boolValue]) {
            _selectImageView.image = GETIMAGE(@"me_option_red");
        }
        else {
            _selectImageView.image = GETIMAGE(@"me_option_grey");
        }
        
        @weakify(self)
        [RACObserve(_vehicleTireM, isSelectNumber)
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
}

- (void)bindViewModel:(VehicleManagerVM *)viewModel {
    @weakify(self)
    [RACObserve(viewModel, isEditNumber)
     subscribeNext:^(NSNumber *isEditNumber) {
         @strongify(self)
         BOOL isEdit = [isEditNumber boolValue];
         if (isEdit) {
             self.leftLayoutConstraint.constant = 0;
         }
         else {
             self.leftLayoutConstraint.constant = -30;
         }
     }];
}

- (void)selectCell {
    BOOL isSelect = NO;
    if ([_vehicleTruckM isMemberOfClass:VehicleTruckM.class]) {
        _vehicleTruckM.isSelectNumber = @(![_vehicleTruckM.isSelectNumber boolValue]);
        isSelect = [_vehicleTruckM.isSelectNumber boolValue];
    }
    
    if ([_vehicleTireM isMemberOfClass:VehicleTireM.class]) {
        _vehicleTireM.isSelectNumber = @(![_vehicleTireM.isSelectNumber boolValue]);
        isSelect = [_vehicleTireM.isSelectNumber boolValue];
    }
    
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
@interface VehicleManagerSecondCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *addView;

@end

@implementation VehicleManagerSecondCell

- (void)awakeFromNib {
    // Initialization code
    _addView.layer.borderWidth = 1;
    _addView.layer.cornerRadius = 6;
    _addView.layer.borderColor = RGB(154, 154, 154).CGColor;
}

#pragma mark - Override
+ (id)createCell {
    return [self loadNib][1];
}

- (void)configureCell:(NSDictionary *)model {
    _titleLabel.text = model[@"kTitle"];
}

@end
