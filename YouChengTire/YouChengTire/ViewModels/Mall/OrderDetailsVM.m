//
//  OrderDetailsVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderDetailsVM.h"
// Models
#import "OrderDetailsM.h"

@implementation OrderDetailsVM

#pragma mark - Override
- (void)initialize {
    self.title = @"订单详情";
}

#pragma mark - Public
- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"id" : _orderId,
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    @weakify(self)
    [ZPHTTP wPost:@"app/shop/order/getOrder"
       parameters:parameters
          success:^(NSDictionary *object) {
              @strongify(self)
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  self.orderDetailsM = [OrderDetailsM yy_modelWithDictionary:data[@"order"]];
                  [self configureCell:self.orderDetailsM];
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

- (void)configureCell:(OrderDetailsM *)orderDetailsM {
    NSMutableArray *mArray = @[].mutableCopy;
    
    NSMutableArray *sectionArray01 = @[].mutableCopy;
    NSDictionary *data01 = @{
                              @"kType" : @"fifth",
                              @"kTitle" : @"订单号:",
                              @"kSubtitle" : orderDetailsM.number
                              };
    [sectionArray01 addObject:data01];
    NSDictionary *data02 = @{
                              @"kType" : @"fifth",
                              @"kTitle" : @"订单状态:",
                              @"kSubtitle" : orderDetailsM.status,
                              @"kSubtitleColor" : RGB(235, 77, 68)
                              };
    [sectionArray01 addObject:data02];
    [mArray addObject:sectionArray01];
    
    NSMutableArray *sectionArray02 = @[].mutableCopy;
    NSDictionary *data03 = @{
                              @"kType" : @"first",
                              @"kModel" : orderDetailsM.address
                              };
    [sectionArray02 addObject:data03];
    [mArray addObject:sectionArray02];
    
    NSMutableArray *sectionArray03 = @[].mutableCopy;
    NSDictionary *data04 = @{
                              @"kType" : @"second",
                              @"kTitle" : orderDetailsM.belongName
                              };
    [sectionArray03 addObject:data04];
    for (NSDictionary *dictonary in orderDetailsM.productList) {
        NSDictionary *data05 = @{
                                  @"kType" : @"third",
                                  @"kModel" : dictonary
                                  };
        [sectionArray03 addObject:data05];
    }
    NSDictionary *data06 = @{
                              @"kType" : @"fourth",
                              @"kTitle" : @"支付方式",
                              @"kSubtitle" : orderDetailsM.payment
                              };
    [sectionArray03 addObject:data06];
    NSDictionary *data07 = @{
                              @"kType" : @"fourth",
                              @"kTitle" : @"安装方式",
                              @"kSubtitle" : orderDetailsM.setup
                              };
    [sectionArray03 addObject:data07];
    
    NSString *receipt = @"不开发票";
    if (orderDetailsM.receipt) {
        NSString *number = orderDetailsM.receipt[@"number"];
        if ([number isEqualToString:@""]) {
            receipt = @"普通发票";
        }
        else {
            receipt = @"专用发票";
        }
    }
    NSDictionary *data08 = @{
                              @"kType" : @"fourth",
                              @"kTitle" : @"开票",
                              @"kSubtitle" : receipt
                              };
    [sectionArray03 addObject:data08];
    NSDictionary *data09 = @{
                              @"kType" : @"fifth",
                              @"kTitle" : @"我的留言:",
                              @"kSubtitle" : orderDetailsM.message ? orderDetailsM.message : @"无"
                              };
    [sectionArray03 addObject:data09];
    [mArray addObject:sectionArray03];
    
    NSMutableArray *sectionArray04 = @[].mutableCopy;
    NSDictionary *data10 = @{
                              @"kType" : @"sixth",
                              @"kModel" : orderDetailsM,
                              };
    [sectionArray04 addObject:data10];
    [mArray addObject:sectionArray04];
    
    self.array = mArray;
}

@end
