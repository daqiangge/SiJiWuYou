//
//  EditTireVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/10.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "EditTireVM.h"
// Models
#import "VehicleManagerM.h"

@implementation EditTireVM

#pragma mark - Override
- (void)initialize {
    self.title = @"新增轮胎";
    
    _vehicleTireM = [VehicleTireM new];
    _vehicleTireM.sId = @"";
//    _vehicleTireM.series = @"";
//    _vehicleTireM.standard = @"";
//    _vehicleTireM.brand = @"";
//    _vehicleTireM.pattern = @"";
    _vehicleTireM.isDefault = @"0";
    
    //    _vehicleTireM.sId = @"";
    //    _vehicleTireM.series = @"系列";
    //    _vehicleTireM.standard = @"规格";
    //    _vehicleTireM.brand = @"品牌";
    //    _vehicleTireM.pattern = @"花纹";
    //    _vehicleTireM.isDefault = @"0";
}

/**
 * 获取轮胎规格
 */
- (void)requestGetSeries:(void (^)(id object))success
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion {
    [ZPHTTP wPost:@"app/prd/tire/getStandardList"
       parameters:nil
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  self.standardArray = [NSArray yy_modelArrayWithClass:VehicleStandardM.class
                                                                  json:data[@"standardList"]];
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
 * 编辑轮胎
 */
- (void)requestEditTire:(void (^)(id object))success
                  error:(void (^)(NSError *error))error
                failure:(void (^)(NSError *error))failure
             completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"id" : _vehicleTireM.sId,
                                        @"series" : _vehicleTireM.series,
                                        @"standard" : _vehicleTireM.standard,
                                        @"brand" : _vehicleTireM.brand,
                                        @"pattern" : _vehicleTireM.pattern,
                                        @"isDefault" : _vehicleTireM.isDefault
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    [ZPHTTP wPost:@"app/prd/tire/saveTire"
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
