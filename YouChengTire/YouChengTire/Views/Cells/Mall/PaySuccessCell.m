//
//  PaySuccessCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/22.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "PaySuccessCell.h"
// Models
#import "OrderPayM.h"

@interface PaySuccessCell ()

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactsLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
/**
 *  查看订单
 */
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
/**
 *  继续购物
 */
@property (weak, nonatomic) IBOutlet UIButton *secondButton;

@end

@implementation PaySuccessCell

- (void)awakeFromNib {
    // Initialization code
    [self configureButton];
}

- (void)configureCell:(OrderPayM *)model {
    _numberLabel.text = model.number;
    _contactsLabel.text = model.contacts;
    _mobileLabel.text = model.mobile;
    _addressLabel.text = model.address;
    _paymentLabel.text = model.payment;
    _priceLabel.text = [NSString stringWithFormat:@"￥ %.2f", [model.price floatValue]];
}

- (void)configureButton {
    [self configureBorder:_firstButton];
    [self configureBorder:_secondButton];
}

- (void)configureBorder:(UIView *)view {
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 6;
    view.layer.borderColor = [UIColor clearColor].CGColor;
}

@end


