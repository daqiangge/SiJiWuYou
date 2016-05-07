//
//  WalletCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/10.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "WalletCell.h"
// Models
#import "WalletM.h"

@implementation WalletCell

#pragma mark - Static Private
+ (NSArray *)loadNib {
    return [self loadNibNamed:@"WalletCell"];
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
@interface WalletFirstCell ()
/**
 *  可使用
 */
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
/**
 *  已使用
 */
@property (weak, nonatomic) IBOutlet UILabel *usedLabel;
/**
 *  已过期
 */
@property (weak, nonatomic) IBOutlet UILabel *expiredLabel;

@property (weak, nonatomic) IBOutlet UIButton *mallButton;

@end

@implementation WalletFirstCell

- (void)awakeFromNib {
    // Initialization code
    [self configureButton];
}

#pragma mark - Override
+ (instancetype)createCell {
    return [self loadNib][0];
}

- (void)configureCell:(WalletPointsM *)model {
    if (model) {
        _currentLabel.text = [NSString stringWithFormat:@"%@分",
                              STRING_NOT_EMPTY(model.currentPoint) ? model.currentPoint : @"0"];
        _usedLabel.text = [NSString stringWithFormat:@"%@分",
                           STRING_NOT_EMPTY(model.usedPoint) ? model.usedPoint : @"0"];
        _expiredLabel.text = [NSString stringWithFormat:@"%@分",
                              STRING_NOT_EMPTY(model.expiredPoint) ? model.expiredPoint : @"0"];
    }
}

#pragma mark - private
- (void)configureButton {
    [self configureBorder:_mallButton];
}

#pragma mark - Event Response
- (IBAction)enterMall:(id)sender {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(enterMall)]) {
            [self.delegate enterMall];
        }
    }
}

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface WalletSecondCell ()

@property (nonatomic, weak) IBOutlet UIImageView *statusImageView;
@property (nonatomic, weak) IBOutlet UILabel *statusLabel;
@property (nonatomic, weak) IBOutlet UILabel *amountLabel;
@property (nonatomic, weak) IBOutlet UILabel *userdAmountLabel;
@property (nonatomic, weak) IBOutlet UILabel *toDateLabel;

@end

@implementation WalletSecondCell

#pragma mark - Override
+ (instancetype)createCell {
    return [self loadNib][1];
}

- (void)configureCell:(WalletTicketM *)model {
    switch ([model.status integerValue]) {
        case 0:{
            _statusLabel.text = @"未使用";
            _statusImageView.image = GETIMAGE(@"me_money_use");
        }
            break;
            
        case 1:{
            _statusLabel.text = @"已使用";
            _statusImageView.image = GETIMAGE(@"me_money_expire");
        }
            break;
            
        case 2:{
            _statusLabel.text = @"已过期";
            _statusImageView.image = GETIMAGE(@"me_money_expire");
        }
            break;
            
        default:
            break;
    }
    _amountLabel.text = [NSString stringWithFormat:@"￥%@", model.amount];
    _userdAmountLabel.text = [NSString stringWithFormat:@"单笔满%@享用", model.usedAmount];
    _toDateLabel.text = [NSString stringWithFormat:@"有效期至:%@", model.endDate];
}

@end

/*****************************************************************************************
 * 三
 *****************************************************************************************/
@interface WalletThirdCell ()

@property (weak, nonatomic) IBOutlet UIButton *exchangeButton;

@end

@implementation WalletThirdCell

- (void)awakeFromNib {
    // Initialization code
    [self configureButton];
}

#pragma mark - Override
+ (instancetype)createCell {
    return [self loadNib][2];
}

#pragma mark - private
- (void)configureButton {
    [self configureBorder:_exchangeButton];
}

@end

/*****************************************************************************************
 * 四
 *****************************************************************************************/
@interface WalletFourthCell ()

@property (nullable, nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nullable, nonatomic, weak) IBOutlet UIImageView *statusBgImageView;
@property (nullable, nonatomic, weak) IBOutlet UIImageView *statusImageView;
@property (nullable, nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nullable, nonatomic, weak) IBOutlet UILabel *amountLabel;
@property (nullable, nonatomic, weak) IBOutlet UILabel *userdAmountLabel;
@property (nullable, nonatomic, weak) IBOutlet UILabel *toDateLabel;

@end

@implementation WalletFourthCell

#pragma mark - Override
+ (instancetype)createCell {
    return [self loadNib][3];
}

- (void)configureCell:(WalletTicketM *)model {
    switch ([model.status integerValue]) {
        case 0:{
            _statusBgImageView.image = GETIMAGE(@"me_discount_use");
            _statusImageView.hidden = YES;
        }
            break;
            
        case 1:{
            _statusBgImageView.image = GETIMAGE(@"me_discount_expire");
            _statusImageView.hidden = NO;
            _statusImageView.image = GETIMAGE(@"me_money_logo_use");
        }
            break;
            
        case 2:{
            _statusBgImageView.image = GETIMAGE(@"me_discount_expire");
            _statusImageView.hidden = NO;
            _statusImageView.image = GETIMAGE(@"me_money_logo_expire");
        }
            break;
            
        default:
            _statusImageView.hidden = YES;
            break;
    }
    [_logoImageView yy_setImageWithURL:[NSURL URLWithString:model.belong.appPhoto]
                            placeholder:GETIMAGE(@"me_discount_logo")];
    _titleLabel.text = [NSString stringWithFormat:@"%@店铺优惠券", model.belong.name];
    _amountLabel.text = [NSString stringWithFormat:@"￥%@", model.amount];
    _userdAmountLabel.text = [NSString stringWithFormat:@"单笔满%@享用", model.usedAmount];
    _toDateLabel.text = [NSString stringWithFormat:@"有效期至:%@", model.endDate];
}

@end
