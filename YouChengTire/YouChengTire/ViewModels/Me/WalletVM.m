//
//  WalletVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "WalletVM.h"
// Models
#import "WalletM.h"

@implementation WalletVM

#pragma mark - Override
- (void)initialize {
    self.title = @"我的钱包";
    
    self.tabNumber = @(0);
}

#pragma mark - Public
/**
 * 获取用户的积分
 */
- (void)requestGetPoints:(void (^)(id object))success
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"type" : @"1"
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    
    [ZPHTTP wPost:@"app/prd/purse/getPoints"
       parameters:parameters
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  self.pointsM = [WalletPointsM yy_modelWithJSON:data[@"points"]];
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


/**
 * 获取用户的现金卷
 */
- (void)requestGetCashTickets:(void (^)(id object))success
                        error:(void (^)(NSError *error))error
                      failure:(void (^)(NSError *error))failure
                   completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"type" : @"2"
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    
    [ZPHTTP wPost:@"app/prd/purse/getTicketList"
       parameters:parameters
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  self.cashTicketMArray = [NSArray yy_modelArrayWithClass:WalletTicketM.class
                                                                     json:data[@"ticketList"]];
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

/**
 * 获取用户的优惠券
 */
- (void)requestGetDiscountTickets:(void (^)(id object))success
                            error:(void (^)(NSError *error))error
                          failure:(void (^)(NSError *error))failure
                       completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"type" : @"3"
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    
    [ZPHTTP wPost:@"app/prd/purse/getTicketList"
       parameters:parameters
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  self.discountTicketMArray = [NSArray yy_modelArrayWithClass:WalletTicketM.class
                                                                         json:data[@"ticketList"]];
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

- (BOOL)switchFirst {
    if ([_tabNumber integerValue] != 1) {
        self.tabNumber = @1;
        return YES;
    }
    return NO;
}

- (BOOL)switchSecond {
    if ([_tabNumber integerValue] != 2) {
        self.tabNumber = @2;
        return YES;
    }
    return NO;
}

- (BOOL)switchThird {
    if ([_tabNumber integerValue] != 3) {
        self.tabNumber = @3;
        return YES;
    }
    return NO;
}

@end
