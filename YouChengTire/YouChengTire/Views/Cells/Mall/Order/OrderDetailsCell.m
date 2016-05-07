//
//  OrderDetailsCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderDetailsCell.h"
// Models
#import "ReceiptAddressM.h"
#import "OrderDetailsM.h"

@implementation OrderDetailsCell

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface OrderDetailsFirstCell ()

@property (nonatomic, weak) IBOutlet UILabel *addressLabel;

@end

@implementation OrderDetailsFirstCell

- (void)configureCell:(NSDictionary *)model {
    if (model[@"kModel"]) {
        ReceiptAddressItemM *receiptAddressItemM = model[@"kModel"];
        _addressLabel.text = [NSString stringWithFormat:@"%@ %@\n\n%@ %@ %@ %@",
                              receiptAddressItemM.name,
                              receiptAddressItemM.mobile,
                              receiptAddressItemM.province,
                              receiptAddressItemM.city,
                              receiptAddressItemM.county,
                              receiptAddressItemM.detail];
    }
    else {
        _addressLabel.text = @"未设置默认收货地址";
    }
}

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface OrderDetailsSecondCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end

@implementation OrderDetailsSecondCell

- (void)configureCell:(NSDictionary *)model {
    _titleLabel.text = model[@"kTitle"];
}

@end

/*****************************************************************************************
 * 三
 *****************************************************************************************/
@interface OrderDetailsThirdCell ()

@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UILabel *countLabel;

@end


@implementation OrderDetailsThirdCell

- (void)configureCell:(NSDictionary *)model {
    NSDictionary *dict = model[@"kModel"];
    _countLabel.text = [NSString stringWithFormat:@"x %@", dict[@"count"]];
    
    OrderDetailsProductM *orderDetailsProductM = [OrderDetailsProductM yy_modelWithDictionary:dict[@"product"]];
    [_logoImageView yy_setImageWithURL:[NSURL URLWithString:orderDetailsProductM.photo]
                           placeholder:nil];
    _titleLabel.text = orderDetailsProductM.name;
    _priceLabel.text = [NSString stringWithFormat:@"￥ %@", orderDetailsProductM.price];
}

@end

/*****************************************************************************************
 * 四
 *****************************************************************************************/
@interface OrderDetailsFourthCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

@implementation OrderDetailsFourthCell

- (void)configureCell:(NSDictionary *)model {
    _titleLabel.text = model[@"kTitle"];
    _subtitleLabel.text = model[@"kSubtitle"];
}

@end

/*****************************************************************************************
 * 五
 *****************************************************************************************/
@interface OrderDetailsFifthCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

@implementation OrderDetailsFifthCell

- (void)configureCell:(NSDictionary *)model {
    _titleLabel.text = model[@"kTitle"];
    _subtitleLabel.text = model[@"kSubtitle"];
    if (model[@"kSubtitleColor"]) {
        _subtitleLabel.textColor = model[@"kSubtitleColor"];
    }
}

@end

/*****************************************************************************************
 * 六
 *****************************************************************************************/
@interface OrderDetailsSixthCell ()

@property (nonatomic, weak) IBOutlet UILabel *productPriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *setupPriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *freightPriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *privilegePriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *cashPriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *onlinePriceLabel;

@property (nonatomic, weak) IBOutlet UILabel *createDateLabel;

@end

@implementation OrderDetailsSixthCell : OrderDetailsCell

- (void)configureCell:(NSDictionary *)model {
    OrderDetailsM *orderDetailsM = model[@"kModel"];
    
    _productPriceLabel.text = [NSString stringWithFormat:@"￥ %.2f", [orderDetailsM.productPrice floatValue]];
    if (orderDetailsM.setupPrice) {
        _setupPriceLabel.text = [NSString stringWithFormat:@"+ ￥ %.2f", [orderDetailsM.setupPrice floatValue]];
    }
    else {
        _setupPriceLabel.text = @"请联系商家";
    }
    if (orderDetailsM.freightPrice) {
        _freightPriceLabel.text = [NSString stringWithFormat:@"+ ￥ %.2f", [orderDetailsM.freightPrice floatValue]];
    }
    else {
        _freightPriceLabel.text = @"请联系商家";
    }
    _privilegePriceLabel.text = [NSString stringWithFormat:@"- ￥ %.2f",
                                 orderDetailsM.privilegePrice ? [orderDetailsM.privilegePrice floatValue] : 0.00];
    _cashPriceLabel.text = [NSString stringWithFormat:@"- ￥ %.2f",
                            orderDetailsM.cashPrice ? [orderDetailsM.cashPrice floatValue] : 0.00];
    _onlinePriceLabel.text = [NSString stringWithFormat:@"实付款: ￥ %.2f", [orderDetailsM.onlinePrice floatValue]];
    _createDateLabel.text = [NSString stringWithFormat:@"下单时间: %@", orderDetailsM.createDate];
}

@end
