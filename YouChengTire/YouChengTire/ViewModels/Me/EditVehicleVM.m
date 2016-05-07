//
//  EditVehicleVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/10.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "EditVehicleVM.h"
// Models
#import "VehicleManagerM.h"

@implementation EditVehicleVM

#pragma mark - Override
- (void)initialize {
    self.title = @"新增车辆";
    
    _vehicleTruckM = [VehicleTruckM new];
    _vehicleTruckM.sId  = @"";
//    _vehicleTruckM.brand = @"";
//    _vehicleTruckM.model = @"";
//    _vehicleTruckM.drive = @"";
//    _vehicleTruckM.number = @"";
//    _vehicleTruckM.engine = @"";
    _vehicleTruckM.isDefault = @"0";
    
//    _vehicleTruckM.sId  = @"";
//    _vehicleTruckM.brand = @"品牌";
//    _vehicleTruckM.model = @"车型";
//    _vehicleTruckM.drive = @"驱动形式";
//    _vehicleTruckM.number = @"车牌号";
//    _vehicleTruckM.engine = @"发动机号";
//    _vehicleTruckM.isDefault = @"0";
}

#pragma mark - Public
/**
 * 获取车辆品牌和车型
 */
- (void)requestGetBrands:(void (^)(id object))success
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion {
    [ZPHTTP wPost:@"app/prd/truck/getBrandList"
       parameters:nil
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  self.brandArray = [NSArray yy_modelArrayWithClass:VehicleBrandM.class
                                                               json:data[@"brandList"]];
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
 * 编辑车辆
 */
- (void)requestEditTruck:(void (^)(id object))success
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"id" : _vehicleTruckM.sId,
                                        @"brand" : _vehicleTruckM.brand,
                                        @"model" : _vehicleTruckM.model,
                                        @"drive" : _vehicleTruckM.drive,
                                        @"number" : _vehicleTruckM.number,
                                        @"engine" : _vehicleTruckM.engine,
                                        @"isDefault" : _vehicleTruckM.isDefault
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    [ZPHTTP wPost:@"app/prd/truck/saveTruck"
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
