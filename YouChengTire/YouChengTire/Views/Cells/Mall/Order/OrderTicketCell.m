//
//  OrderTicketCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderTicketCell.h"
// Models
#import "WalletM.h"

@implementation OrderTicketCell

@end

/*****************************************************************************************
 * 现金券
 *****************************************************************************************/
@interface OrderCurrencyTicketCell ()

@property (nonatomic, weak) IBOutlet UIImageView *statusImageView;
@property (nonatomic, weak) IBOutlet UILabel *statusLabel;
@property (nonatomic, weak) IBOutlet UILabel *amountLabel;
@property (nonatomic, weak) IBOutlet UILabel *userdAmountLabel;
@property (nonatomic, weak) IBOutlet UILabel *toDateLabel;

@end

@implementation OrderCurrencyTicketCell

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
 * 优惠券
 *****************************************************************************************/
@interface OrderDiscountTicketCell ()

@property (nullable, nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nullable, nonatomic, weak) IBOutlet UIImageView *statusBgImageView;
@property (nullable, nonatomic, weak) IBOutlet UIImageView *statusImageView;
@property (nullable, nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nullable, nonatomic, weak) IBOutlet UILabel *amountLabel;
@property (nullable, nonatomic, weak) IBOutlet UILabel *userdAmountLabel;
@property (nullable, nonatomic, weak) IBOutlet UILabel *toDateLabel;

@end

@implementation OrderDiscountTicketCell

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
