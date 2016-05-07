//
//  OrderPayVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/22.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderPayVM.h"
// Models
#import "OrderPayM.h"

@implementation OrderPayVM

#pragma mark - Override
- (void)initialize {
    self.title = @"支付订单";
}

- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"id" : _orderId,
                                        @"type" : @"1"
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    //    @weakify(self);
    [ZPHTTP wPost:@"app/shop/order/getOrderInfo"
       parameters:parameters
          success:^(NSDictionary *object) {
              //              @strongify(self);
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  
                  NSDictionary *order = data[@"order"];
                  _orderInfo = order[@"orderInfo"];
                  _sign = [self urlEncodedString:order[@"sign"]];
                  
                  _orderPayM = [OrderPayM new];
                  _orderPayM.orderId = _orderId;
                  _orderPayM.number = [NSString stringWithFormat:@"%@", order[@"number"]];
                  
                  NSDictionary *address = order[@"address"];
                  _orderPayM.contacts = address[@"name"];
                  _orderPayM.mobile = [NSString stringWithFormat:@"%@", address[@"mobile"]];
                  _orderPayM.address = [NSString stringWithFormat:@"%@ %@ %@ %@",
                                        address[@"province"],
                                        address[@"city"],
                                        address[@"county"],
                                        address[@"detail"]];
                  _orderPayM.payment = order[@"payment"];
                  _orderPayM.price = _totalPrice;
                  
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

- (NSString*)urlEncodedString:(NSString *)string
{
    NSString * encodedString = (__bridge_transfer  NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
    
    return encodedString;
}

#pragma mark - Public
- (void)dataArray {
    NSDictionary *data_01 = @{
                              @"kType" : @"first",
                              @"kTotalPrice" : _totalPrice
                              };
    NSDictionary *data_02 = @{
                              @"kType" : @"second",
                              };
//    NSDictionary *data_03 = @{
//                              @"kType" : @"third",
//                              };
    NSDictionary *data_04 = @{
                              @"kType" : @"fourth",
                              };
//    return @[
//             data_01,
//             data_02,
////             data_03,
//             data_04
//             ];
    self.array = @[
                   data_01,
                   data_02,
                   //             data_03,
                   data_04
                   ];
}


@end