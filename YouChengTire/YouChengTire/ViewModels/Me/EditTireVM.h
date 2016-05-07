//
//  EditTireVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/10.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@class VehicleTireM;
@class VehicleStandardM;

@interface EditTireVM : BaseVM

@property (nonatomic, strong) VehicleTireM *vehicleTireM;
@property (nonatomic, strong) NSArray<VehicleStandardM *> *standardArray;

@property (nonatomic, weak) UIViewController *viewController;

/**
 * 获取轮胎规格
 */
- (void)requestGetSeries:(void (^)(id object))success
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion;

/**
 * 编辑轮胎
 */
- (void)requestEditTire:(void (^)(id object))success
                  error:(void (^)(NSError *error))error
                failure:(void (^)(NSError *error))failure
             completion:(void (^)(void))completion;

@end
