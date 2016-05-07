//
//  OrderCheckCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderCheckCell.h"
// Models
#import "ReceiptAddressM.h"
#import "OrderCheckM.h"
// ViewModels
#import "OrderCheckVM.h"

@implementation OrderCheckCell

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface OrderCheckFirstCell ()

@property (nullable, nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nullable, nonatomic, weak) IBOutlet UIImageView *allowImageView;

@end

@implementation OrderCheckFirstCell

- (void)configureCell:(NSDictionary *)model {
    ReceiptAddressItemM *receiptAddressItemM = model[kModel];
    if (STRING_NOT_EMPTY(receiptAddressItemM.name)) {
        _addressLabel.text = [NSString stringWithFormat:@"%@ %@\n\n%@ %@ %@ %@",
                              receiptAddressItemM.name,
                              receiptAddressItemM.mobile,
                              receiptAddressItemM.province,
                              receiptAddressItemM.city,
                              receiptAddressItemM.county,
                              receiptAddressItemM.detail];
    }
    else {
        _addressLabel.text = @"请设置您的收货地址";
    }
}

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface OrderCheckSecondCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end

@implementation OrderCheckSecondCell

- (void)configureCell:(NSDictionary *)model {
    NSString *belongName = model[kTitle];
    _titleLabel.text = belongName;
}

@end

/*****************************************************************************************
 * 三
 *****************************************************************************************/
@interface OrderCheckThirdCell ()

@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UILabel *countLabel;

@end

@implementation OrderCheckThirdCell

- (void)configureCell:(NSDictionary *)model {
    NSDictionary *dict = model[kModel];
    NSString *count = dict[@"count"];
    
    NSDictionary *productDict = dict[@"product"];
    //    NSString *sId = productDict[@"id"];
    NSString *name = productDict[@"name"];
    NSString *photo = productDict[@"photo"];
    NSString *price = productDict[@"price"];
    
    [_logoImageView yy_setImageWithURL:[NSURL URLWithString:photo]
                           placeholder:nil];
    _titleLabel.text = name;
    _priceLabel.text = [NSString stringWithFormat:@"￥ %.2f", [price floatValue]];
    _countLabel.text = [NSString stringWithFormat:@"x %@", count];
}

@end

/*****************************************************************************************
 * 四
 *****************************************************************************************/
@interface OrderCheckFourthCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;

@end

@implementation OrderCheckFourthCell

- (void)configureCell:(NSDictionary *)model {
    _title.text = model[kTitle];
    _subtitle.text = model[@"kSubtitle"];
    if (model[@"kSubtitleColor"]) {
        _subtitle.textColor = model[@"kSubtitleColor"];
    }
}

@end

/*****************************************************************************************
 * 五
 *****************************************************************************************/
@interface OrderCheckFifthCell ()

@property (nonatomic, weak) IBOutlet UITextField *messageTextField;

@end

@implementation OrderCheckFifthCell

- (void)bindViewModel:(OrderCheckVM *)viewModel {
    [[_messageTextField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(id x) {
         viewModel.message = x;
     }];
}

@end

/*****************************************************************************************
 * 六
 *****************************************************************************************/
@interface OrderCheckSixthCell ()

@end

@implementation OrderCheckSixthCell

- (IBAction)merchantTelephone:(id)sender {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(merchantTelephone)]) {
            [self.delegate merchantTelephone];
        }
    }
}

- (IBAction)refreshPrice:(id)sender {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(refreshPrice)]) {
            [self.delegate refreshPrice];
        }
    }
}

@end

/*****************************************************************************************
 * 七
 *****************************************************************************************/
@interface OrderCheckSeventhCell ()

@property (nonatomic, weak) IBOutlet UILabel *productPriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *setupPriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *freightPriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *privilegePriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *cashPriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *onlinePriceLabel;

@end

@implementation OrderCheckSeventhCell

- (void)configureCell:(NSDictionary *)model {
    OrderCheckM *orderCheckM = model[kModel];

    _productPriceLabel.text = [NSString stringWithFormat:@"￥ %.2f", [orderCheckM.productPrice floatValue]];
    if (orderCheckM.setupPrice) {
        _setupPriceLabel.text = [NSString stringWithFormat:@"+ ￥ %.2f", [orderCheckM.setupPrice floatValue]];
    }
    else {
        _setupPriceLabel.text = @"请先提交订单，再联系商家";
    }
    if (orderCheckM.freightPrice) {
        _freightPriceLabel.text = [NSString stringWithFormat:@"+ ￥ %.2f", [orderCheckM.freightPrice floatValue]];
    }
    else {
        _freightPriceLabel.text = @"请先提交订单，再联系商家";
    }
    _privilegePriceLabel.text = [NSString stringWithFormat:@"- ￥ %.2f",
                                 orderCheckM.privilegePrice ? [orderCheckM.privilegePrice floatValue] : 0.00];
    _cashPriceLabel.text = [NSString stringWithFormat:@"- ￥ %.2f",
                            orderCheckM.cashPrice ? [orderCheckM.cashPrice floatValue] : 0.00];
    
    float onlinePrice = [orderCheckM.onlinePrice floatValue];
    NSString *cashAmount = model[@"kCashAmount"];
    if (STRING_NOT_EMPTY(cashAmount)) {
        onlinePrice = onlinePrice - [cashAmount floatValue];
    }
    NSString *privilegeAmount = model[@"kPrivilegeAmount"];
    if (STRING_NOT_EMPTY(privilegeAmount)) {
        onlinePrice = onlinePrice - [privilegeAmount floatValue];
    }
    _onlinePriceLabel.text = [NSString stringWithFormat:@"实付款: ￥ %.2f", onlinePrice];
}

@end

