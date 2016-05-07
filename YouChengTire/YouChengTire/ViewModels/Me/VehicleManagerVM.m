//
//  VehicleManagerVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "VehicleManagerVM.h"
// Models
#import "VehicleManagerM.h"

@implementation VehicleManagerVM

#pragma mark - Override
- (void)initialize {
    [super initialize];
    self.title = @"车辆管理";
    
    self.isFirstNumber = @YES;
    self.isEditNumber = @NO;
    
    _isSelectTruckAllNumber = @NO;
    _isSelectTireAllNumber = @NO;
}

#pragma mark - Public
/**
 * 获取车辆
 */
- (void)requestGetTrucks:(void (^)(id object))success
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{}.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    [ZPHTTP wPost:@"app/prd/truck/getTruckList"
       parameters:parameters
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  NSArray<VehicleTruckM *> *tempArray = [NSArray yy_modelArrayWithClass:VehicleTruckM.class
                                                                                   json:data[@"truckList"]];
                  if ([_isEditNumber boolValue]) {
                      self.truckArray = tempArray;
                  }
                  else {
                      self.truckArray = [self firstAddLastOne:tempArray];
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
 * 删除车辆
 */
- (void)requestDeleteTruck:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    NSString *sId = @"";
    for (VehicleTruckM *model in self.selectTruckArray) {
        sId = [sId stringByAppendingFormat:@"%@,", model.sId];
    }
    sId = [sId substringToIndex:sId.length - 1];
    NSMutableDictionary *parameters = @{ @"id" : sId }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    [ZPHTTP wPost:@"app/prd/truck/deleteTruck"
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

/**
 * 获取轮胎
 */
- (void)requestGetTires:(void (^)(id object))success
                  error:(void (^)(NSError *error))error
                failure:(void (^)(NSError *error))failure
             completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{}.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    [ZPHTTP wPost:@"app/prd/tire/getTireList"
       parameters:parameters
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  NSArray<VehicleTireM *> *tempArray = [NSArray yy_modelArrayWithClass:VehicleTireM.class
                                                                                  json:data[@"tireList"]];
                  if ([_isEditNumber boolValue]) {
                      self.tireArray = tempArray;
                  }
                  else {
                      self.tireArray = [self secondAddLastOne:tempArray];
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
 * 删除轮胎
 */
- (void)requestDeleteTire:(void (^)(id object))success
                    error:(void (^)(NSError *error))error
                  failure:(void (^)(NSError *error))failure
               completion:(void (^)(void))completion {
    NSString *sId = @"";
    for (VehicleTireM *model in self.selectTireArray) {
        sId = [sId stringByAppendingFormat:@"%@,", model.sId];
    }
    sId = [sId substringToIndex:sId.length - 1];
    NSMutableDictionary *parameters = @{ @"id" : sId }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    [ZPHTTP wPost:@"app/prd/tire/deleteTire"
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

- (void)switchFirst {
    if (![_isFirstNumber boolValue]) {
        self.isFirstNumber = @(YES);
    }
}

- (void)switchSecond {
    if ([_isFirstNumber boolValue]) {
        self.isFirstNumber = @(NO);
    }
}

- (NSArray *)firstDataArray {
    NSDictionary *data_01 = @{
                              @"kTitle" : @"北奔重汽",
                              @"kSubtitle" : @"北奔V3M    苏B88888",
                              @"kIsDefault" : @(YES)
                              };
    
    NSDictionary *data_02 = @{
                              @"kTitle" : @"北奔重汽",
                              @"kSubtitle" : @"北奔V3M    苏B88888"
                              };
    NSDictionary *data_03 = @{
                              @"kTitle" : @"北奔重汽",
                              @"kSubtitle" : @"北奔V3M    苏B88888"
                              };
    return @[
             data_01,
             data_02,
             data_03
             ];
}

- (NSArray *)secondDataArray {
    NSDictionary *data_01 = @{
                              @"kTitle" : @"真空系列 8R22.5",
                              @"kSubtitle" : @"驰耐得轮胎    纵向花纹",
                              @"kIsDefault" : @(YES)
                              };
    
    NSDictionary *data_02 = @{
                              @"kTitle" : @"真空系列 8R22.5",
                              @"kSubtitle" : @"驰耐得轮胎    纵向花纹"
                              };
    NSDictionary *data_03 = @{
                              @"kTitle" : @"真空系列 8R22.5",
                              @"kSubtitle" : @"驰耐得轮胎    纵向花纹"
                              };
    return @[
             data_01,
             data_02,
             data_03
             ];
}

- (NSArray *)firstAddLastOne:(NSArray *)dataArray {
    NSMutableArray *tempArray = dataArray.mutableCopy;
    [tempArray addObject:@{
                           @"kTitle" : @"添加车辆",
                           @"kType" : @"Add",
                           @"kMethod" : @"editVehicleVC"
                           }];
    return tempArray;
}

- (NSArray *)secondAddLastOne:(NSArray *)dataArray {
    NSMutableArray *tempArray = dataArray.mutableCopy;
    [tempArray addObject:@{
                           @"kTitle" : @"添加轮胎",
                           @"kType" : @"Add",
                           @"kMethod" : @"editTireVC"
                           }];
    return tempArray;
}

- (NSArray *)removeLastOne:(NSArray *)dataArray {
    NSMutableArray *tempArray = dataArray.mutableCopy;
    [tempArray removeLastObject];
    return tempArray;
}

@end
