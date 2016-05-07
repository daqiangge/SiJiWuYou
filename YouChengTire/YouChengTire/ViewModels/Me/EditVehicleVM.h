//
//  EditVehicleVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/10.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@class VehicleTruckM;
@class VehicleBrandM;

@interface EditVehicleVM : BaseVM

@property (nonatomic, strong) VehicleTruckM *vehicleTruckM;
@property (nonatomic, strong) NSArray<VehicleBrandM *> *brandArray;

@property (nonatomic, weak) UIViewController *viewController;

/**
 * 获取车辆品牌和车型
 */
- (void)requestGetBrands:(void (^)(id object))success
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion;

/**
 * 编辑车辆
 */
- (void)requestEditTruck:(void (^)(id object))success
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion;


@end
