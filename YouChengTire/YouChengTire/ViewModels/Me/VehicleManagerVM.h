//
//  VehicleManagerVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"
// Models
#import "VehicleManagerM.h"

@interface VehicleManagerVM : BaseVM

@property (strong, nonatomic) NSNumber *isFirstNumber;
@property (strong, nonatomic) NSNumber *isEditNumber;

@property (nonatomic, strong) NSNumber *isSelectTruckAllNumber;
@property (nonatomic, strong) NSArray<VehicleTruckM *> *truckArray;
@property (nonatomic, strong) NSArray<VehicleTruckM *> *selectTruckArray;

@property (nonatomic, strong) NSNumber *isSelectTireAllNumber;
@property (nonatomic, strong) NSArray<VehicleTireM *> *tireArray;
@property (nonatomic, strong) NSArray<VehicleTireM *> *selectTireArray;

/**
 * 获取车辆
 */
- (void)requestGetTrucks:(void (^)(id object))success
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion;

/**
 * 删除车辆
 */
- (void)requestDeleteTruck:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion;

/**
 * 获取轮胎
 */
- (void)requestGetTires:(void (^)(id object))success
                  error:(void (^)(NSError *error))error
                failure:(void (^)(NSError *error))failure
             completion:(void (^)(void))completion;

/**
 * 删除轮胎
 */
- (void)requestDeleteTire:(void (^)(id object))success
                    error:(void (^)(NSError *error))error
                  failure:(void (^)(NSError *error))failure
               completion:(void (^)(void))completion;

- (void)switchFirst;
- (void)switchSecond;

- (NSArray *)firstDataArray;
- (NSArray *)secondDataArray;

- (NSArray *)firstAddLastOne:(NSArray *)dataArray;
- (NSArray *)secondAddLastOne:(NSArray *)dataArray;
- (NSArray *)removeLastOne:(NSArray *)dataArray;

@end
