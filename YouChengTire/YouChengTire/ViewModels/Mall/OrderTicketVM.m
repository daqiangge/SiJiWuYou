//
//  OrderTicketVM.m
//  YouChengTire
//  订单减免
//  Created by WangZhipeng on 16/4/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderTicketVM.h"
// Models
#import "WalletM.h"

@interface OrderTicketVM ()

@property (nonatomic, assign, readwrite) OrderTicketType orderTicketType;

@end

@implementation OrderTicketVM

- (void)requestGetUsableTicketList:(void (^ _Nullable)(id _Nullable object))success
                             error:(void (^ _Nullable)(NSError * _Nullable error))error
                           failure:(void (^ _Nullable)(NSError * _Nullable error))failure
                        completion:(void (^ _Nullable)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"belongId" : _belongId,
                                        @"type" : [NSString stringWithFormat:@"%lu", (unsigned long)_orderTicketType]
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    @weakify(self)
    [ZPHTTP wPost:@"/app/shop/order/getUsableTicketList"
       parameters:parameters
          success:^(NSDictionary *object) {
              @strongify(self)
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  NSArray<WalletTicketM *> *tempArray = [NSArray yy_modelArrayWithClass:WalletTicketM.class
                                                                                   json:data[@"ticketList"]];
                  self.array = tempArray;
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

@implementation OrderCurrencyTicketVM

#pragma mark - Override
- (void)initialize {
    self.title = @"现金券";
    self.orderTicketType = OrderCurrencyTicket;
}

@end

@implementation OrderDiscountTicketVM

#pragma mark - Override
- (void)initialize {
    self.title = @"优惠券";
    self.orderTicketType = OrderDiscountTicket;
}

@end

