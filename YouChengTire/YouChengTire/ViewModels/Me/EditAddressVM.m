//
//  EditAddressVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/10.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "EditAddressVM.h"

@implementation EditAddressVM

#pragma mark - Override
- (void)initialize {
    self.title = @"新增地址";
    
    _receiptAddressItemM = [ReceiptAddressItemM new];
    _receiptAddressItemM.sId = @"";
//    _receiptAddressItemM.name = @"";
//    _receiptAddressItemM.mobile = @"";
//    _receiptAddressItemM.province = @"";
//    _receiptAddressItemM.city = @"";
//    _receiptAddressItemM.county = @"";
//    _receiptAddressItemM.detail = @"";
    _receiptAddressItemM.isDefault = @"0";
    
//    _receiptAddressItemM.sId = @"";
//    _receiptAddressItemM.name = @"王志鹏";
//    _receiptAddressItemM.mobile = @"18955529166";
//    _receiptAddressItemM.province = @"江苏省";
//    _receiptAddressItemM.city = @"南京市";
//    _receiptAddressItemM.county = @"雨花台区";
//    _receiptAddressItemM.detail = @"软件大道";
//    _receiptAddressItemM.isDefault = @"0";
}

#pragma mark - Public
/**
 * 编辑收货地址
 */
- (void)requestEditAddress:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"id" : _receiptAddressItemM.sId,
                                        @"name" : _receiptAddressItemM.name,
                                        @"mobile" : _receiptAddressItemM.mobile,
                                        @"province" : _receiptAddressItemM.province,
                                        @"city" : _receiptAddressItemM.city,
                                        @"county" : _receiptAddressItemM.county,
                                        @"detail" : _receiptAddressItemM.detail,
                                        @"isDefault" : _receiptAddressItemM.isDefault,
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    
    [ZPHTTP wPost:@"app/prd/address/saveAddress"
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
