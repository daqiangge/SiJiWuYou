//
//  VehicleManagerM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@interface VehicleManagerM : BaseM

@end

/**
 * 车辆
 */
@interface VehicleTruckM : BaseM
/**
 * 编号
 */
@property (strong, nonatomic) NSString *sId;
/**
 * 品牌
 */
@property (strong, nonatomic) NSString *brand;
/**
 * 车型
 */
@property (strong, nonatomic) NSString *model;
/**
 * 驱动形式
 */
@property (strong, nonatomic) NSString *drive;
/**
 * 车牌号
 */
@property (strong, nonatomic) NSString *number;
/**
 * 发动机号
 */
@property (strong, nonatomic) NSString *engine;
/**
 * 默认，1表示默认，0表示不是
 */
@property (strong, nonatomic) NSString *isDefault;
/**
 *  是否选中（非接口数据）
 */
@property (nonatomic, strong) NSNumber *isSelectNumber;

@end

/**
 * 车辆品牌
 */
@interface VehicleBrandM : BaseM
/**
 * 编号
 */
@property (strong, nonatomic) NSString *sId;
/**
 * 名称
 */
@property (strong, nonatomic) NSString *name;
/**
 * 排序
 */
@property (strong, nonatomic) NSString *sort;
/**
 * 子数组
 */
@property (strong, nonatomic) NSArray<VehicleBrandM *> *childrenArray;

@end

/**
 * 轮胎
 */
@interface VehicleTireM : BaseM
/**
 * 编号
 */
@property (strong, nonatomic) NSString *sId;
/**
 * 系列
 */
@property (strong, nonatomic) NSString *series;
/**
 * 规格
 */
@property (strong, nonatomic) NSString *standard;
/**
 * 品牌
 */
@property (strong, nonatomic) NSString *brand;
/**
 * 花纹
 */
@property (strong, nonatomic) NSString *pattern;
/**
 * 默认，1表示默认，0表示不是
 */
@property (strong, nonatomic) NSString *isDefault;
/**
 *  是否选中（非接口数据）
 */
@property (nonatomic, strong) NSNumber *isSelectNumber;

@end

/**
 * 轮胎规格
 */
@interface VehicleStandardM : BaseM
/**
 * 编号
 */
@property (strong, nonatomic) NSString *sId;
/**
 * 名称
 */
@property (strong, nonatomic) NSString *name;
/**
 * 排序
 */
@property (strong, nonatomic) NSString *sort;
/**
 * 子数组
 */
@property (strong, nonatomic) NSArray<VehicleBrandM *> *childrenArray;

@end
