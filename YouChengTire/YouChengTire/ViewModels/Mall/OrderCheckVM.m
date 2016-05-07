//
//  OrderCheckVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderCheckVM.h"
// Models
#import "OrderCheckM.h"
#import "ReceiptAddressM.h"
#import "WalletM.h"

@implementation OrderCheckVM

#pragma mark - Override
- (void)initialize {
    self.title = @"核对订单";
    
    _payment = @"在线支付";
    _setup = @"上门安装";
    _message = @"";
    _receiptId = @"";
    _receiptType = @"";
    
    _productId = @"";
    _productCount = @"";
    _cartProductIds = @"";
    _cartPackageIds = @"";
}

#pragma mark - Public
- (void)configureCell:(OrderCheckM *)orderCheckM {
    NSMutableArray *mArray = @[].mutableCopy;
    
    NSMutableArray *mArraySection01 = @[].mutableCopy;
    NSDictionary *data01 = @{
                             kCell : @"OrderCheckFirstCell",
                             kModel : orderCheckM.address,
                             kMethod : @"selectAddress"
                             };
    [mArraySection01 addObject:data01];
    [mArray addObject:mArraySection01];
    
    NSMutableArray *mArraySection02 = @[].mutableCopy;
    NSDictionary *data02 = @{
                             kCell : @"OrderCheckSecondCell",
                             kTitle : orderCheckM.belongName
                             };
    [mArraySection02 addObject:data02];
    for (NSDictionary *dict in orderCheckM.productList) {
        NSDictionary *data03 = @{
                                 kCell : @"OrderCheckThirdCell",
                                 kModel : dict
                                 };
        [mArraySection02 addObject:data03];
    }
    NSDictionary *data04 = @{
                             kCell : @"OrderCheckFourthCell",
                             kTitle : @"支付方式",
                             @"kSubtitle" : _payment,
                             kMethod : @"payMethod"
                             };
    [mArraySection02 addObject:data04];
    NSDictionary *data05 = @{
                             kCell : @"OrderCheckFourthCell",
                             kTitle : @"安装方式",
                             @"kSubtitle" : _setup,
                             kMethod : @"installMethod"
                             };
    [mArraySection02 addObject:data05];
    NSDictionary *data06 = @{
                             kCell : @"OrderCheckFifthCell",
                             };
    [mArraySection02 addObject:data06];
    //    NSDictionary *data07 = @{
    //                             @"kType" : @"sixth",
    //                             };
    //    [mArraySection02 addObject:data07];
    [mArray addObject:mArraySection02];
    
    NSMutableArray *mArraySection03 = @[].mutableCopy;
    
    NSString *kSubtitle = @"不开发票";
    if ([_receiptType isEqualToString:@"0"]) {
        kSubtitle = @"普通发票";
    }
    else if ([_receiptType isEqualToString:@"1"]) {
        kSubtitle = @"专用发票";
    }
    NSDictionary *data08 = @{
                             kCell : @"OrderCheckFourthCell",
                             kTitle : @"开票",
                             @"kSubtitle" : kSubtitle,
                             kMethod : @"receipt"
                             };
    [mArraySection03 addObject:data08];
    [mArray addObject:mArraySection03];
    
    NSMutableArray *mArraySection04 = @[].mutableCopy;
    //    if (orderCheckM.cashTicket) {
    NSDictionary *data09 = @{
                             kCell : @"OrderCheckFourthCell",
                             kTitle : @"现金券",
                             @"kSubtitle" : _cashTicketM ? [NSString stringWithFormat:@"满%@减%@",
                                                            _cashTicketM.usedAmount,
                                                            _cashTicketM.amount] : @"",
                             @"kSubtitleColor" : RGB(255, 143, 0),
                             kMethod : @"currencyTicket"
                             };
    [mArraySection04 addObject:data09];
    //    }
    //    if (orderCheckM.privilegeTicket) {
    NSDictionary *data10 = @{
                             kCell : @"OrderCheckFourthCell",
                             kTitle : @"优惠券",
                             @"kSubtitle" : _privilegeTicketM ? [NSString stringWithFormat:@"满%@减%@",
                                                                 _privilegeTicketM.usedAmount,
                                                                 _privilegeTicketM.amount] : @"",
                             @"kSubtitleColor" : RGB(235, 77, 68),
                             kMethod : @"discountTicket"
                             };
    [mArraySection04 addObject:data10];
    //    }
    if (mArraySection04.count > 0) {
        [mArray addObject:mArraySection04];
    }
    
    NSMutableArray *mArraySection05 = @[].mutableCopy;
    NSDictionary *data11 = @{
                             kCell : @"OrderCheckSeventhCell",
                             kModel : orderCheckM,
                             @"kCashAmount" : _cashTicketM ? _cashTicketM.amount : @"",
                             @"kPrivilegeAmount" : _privilegeTicketM ? _privilegeTicketM.amount : @"",
                             };
    [mArraySection05 addObject:data11];
    [mArray addObject:mArraySection05];
    
    self.array = mArray;
}

- (void)requestSaveOrder:(void (^)(id object))success
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"productId" : _productId,
                                        @"productCount" : _productCount,
                                        @"cartProductIds" : _cartProductIds,
                                        @"cartPackageIds" : _cartPackageIds,
                                        @"addressId" : _orderCheckM.address.sId,
                                        @"receiptId" : _receiptId,
                                        @"payment" : _payment,
                                        @"setup" : _setup,
                                        @"message" : _message
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    
    [ZPHTTP wPost:@"app/shop/order/saveOrder"
       parameters:parameters
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  NSDictionary *order = data[@"order"];
                  _orderId = order[@"id"];
                  _totalPrice = order[@"totalPrice"];
                  success(nil);
                  completion();
              }
              else {
                  NSInteger errnoInteger = [object[@"msgCode"] integerValue];
                  NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : object[@"msg"] };
                  NSError *uError = [NSError errorWithDomain:@"ZPCustom"
                                                        code:errnoInteger
                                                    userInfo:userInfo];
                  error(uError);
                  completion();
              }
          } failure:^(NSError *error) {
              failure(error);
              completion();
          }];
}

- (void)requestRefreshPrice:(void (^)(id object))success
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"id" : _orderId,
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    @weakify(self)
    [ZPHTTP wPost:@"app/shop/order/refreshPrice"
       parameters:parameters
          success:^(NSDictionary *object) {
              @strongify(self)
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"orderPrices"];
                  OrderCheckM *orderCheckM = [OrderCheckM yy_modelWithDictionary:data[@"orderPrices"]];
                  
                  _orderCheckM.codPrice = orderCheckM.codPrice;
                  _orderCheckM.productPrice = orderCheckM.productPrice;
                  _orderCheckM.freightPrice = orderCheckM.freightPrice;
                  _orderCheckM.setupPrice = orderCheckM.setupPrice;
                  _orderCheckM.cashPrice = orderCheckM.cashPrice;
                  _orderCheckM.privilegePrice = orderCheckM.privilegePrice;
                  _orderCheckM.totalPrice = orderCheckM.totalPrice;
                  _orderCheckM.onlinePrice = orderCheckM.onlinePrice;
                  
                  [self configureCell:_orderCheckM];
                  
                  success(nil);
                  completion();
              }
              else {
                  NSInteger errnoInteger = [object[@"msgCode"] integerValue];
                  NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : object[@"msg"] };
                  NSError *uError = [NSError errorWithDomain:@"ZPCustom"
                                                        code:errnoInteger
                                                    userInfo:userInfo];
                  error(uError);
                  completion();
              }
          } failure:^(NSError *error) {
              failure(error);
              completion();
          }];
}

@end
