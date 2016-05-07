//
//  ReceiptVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/23.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "ReceiptVM.h"

@interface ReceiptVM ()

@property (nonatomic, strong, readwrite) NSDictionary *receiptDictionary;

@end

@implementation ReceiptVM

#pragma mark - Override
- (void)initialize {
    self.title = @"设置开票信息";
}

#pragma mark - Public
- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{}.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    @weakify(self);
    [ZPHTTP wPost:@"app/shop/order/getReceiptList"
       parameters:parameters
          success:^(NSDictionary *object) {
              @strongify(self);
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  self.receiptDictionary = object[@"data"];
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

- (void)requestSaveReceipt:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = nil;
    _sId = @"";
    if ([_receiptTypeNumber integerValue] == 1) {
        if (_receiptDictionary[@"receipt0"]) {
            NSDictionary *receipt0 = _receiptDictionary[@"receipt0"];
            if (receipt0[@"id"]) {
                _sId = receipt0[@"id"];
            }
        }
        parameters = @{
                       @"id" : _sId,
                       @"type" : @"0",
                       @"name" : _name,
                       }.mutableCopy;
    }
    else {
        if (_receiptDictionary[@"receipt1"]) {
            NSDictionary *receipt1 = _receiptDictionary[@"receipt1"];
            if (receipt1[@"id"]) {
                _sId = receipt1[@"id"];
            }
        }
        parameters = @{
                       @"id" : _sId,
                       @"type" : @"1",
                       @"name" : _name,
                       @"number" : _number,
                       @"address" : _address,
                       @"phone" : _phone,
                       @"blank" : _blank,
                       @"blankNumber" : _blankNumber,
                       }.mutableCopy;
    }
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    [ZPHTTP wPost:@"app/shop/order/saveReceipt"
       parameters:parameters
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
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
