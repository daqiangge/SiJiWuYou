//
//  ReceiptAddressVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "ReceiptAddressVM.h"
// Models
#import "ReceiptAddressM.h"

@implementation ReceiptAddressVM

#pragma mark - Override
- (void)initialize {
    self.title = @"收货地址";
    
    _isEditNumber = @NO;
    _isSelectAllNumber = @NO;
}

#pragma mark - Public
/**
 * 获取收货地址
 */
- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{}.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    
    [ZPHTTP wPost:@"/app/prd/address/getAddressList"
       parameters:parameters
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  ReceiptAddressM *receiptAddressM = [ReceiptAddressM yy_modelWithJSON:object[@"data"]];
                  if ([_isEditNumber boolValue]) {
                      self.array = receiptAddressM.addressList;
                  }
                  else {
                      self.array = [self addLastOne:receiptAddressM.addressList];
                  }
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
 * 删除收货地址
 */
- (void)requestDeleteAddress:(void (^)(id object))success
                       error:(void (^)(NSError *error))error
                     failure:(void (^)(NSError *error))failure
                  completion:(void (^)(void))completion {
    NSString *sId = @"";
    for (ReceiptAddressItemM *model in self.selectArray) {
        sId = [sId stringByAppendingFormat:@"%@,", model.sId];
    }
    sId = [sId substringToIndex:sId.length - 1];
    NSMutableDictionary *parameters = @{ @"id" : sId }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    [ZPHTTP wPost:@"/app/prd/address/deleteAddress"
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

- (NSArray *)addLastOne:(NSArray *)dataArray {
    NSMutableArray *tempArray = dataArray.mutableCopy;
    [tempArray addObject:@{}];
    return tempArray;
}

- (NSArray *)removeLastOne:(NSArray *)dataArray {
    NSMutableArray *tempArray = dataArray.mutableCopy;
    [tempArray removeLastObject];
    return tempArray;
}

@end
