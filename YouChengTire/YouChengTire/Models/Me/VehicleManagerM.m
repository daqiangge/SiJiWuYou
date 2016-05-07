//
//  VehicleManagerM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "VehicleManagerM.h"

@implementation VehicleManagerM

@end

/**********************************************************************
 * 车辆
 **********************************************************************/
@implementation VehicleTruckM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"brand" : @"brand",
             @"model" : @"model",
             @"drive" : @"drive",
             @"number" : @"number",
             @"engine" : @"engine",
             @"isDefault" : @"isDefault"
             };
}

@end

/**********************************************************************
 * 车辆品牌
 **********************************************************************/
@implementation VehicleBrandM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"name" : @"name",
             @"sort" : @"sort",
             @"sort" : @"sort",
             @"childrenArray" : @"childList",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"childrenArray" : [VehicleBrandM class],
             };
}

@end

/**********************************************************************
 * 轮胎
 **********************************************************************/
@implementation VehicleTireM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"series" : @"series",
             @"standard" : @"standard",
             @"drive" : @"drive",
             @"brand" : @"brand",
             @"pattern" : @"pattern",
             @"isDefault" : @"isDefault"
             };
}

@end

/**********************************************************************
 * 轮胎规格
 **********************************************************************/
@implementation VehicleStandardM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"name" : @"name",
             @"sort" : @"sort",
             @"sort" : @"sort",
             @"childrenArray" : @"childList",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"childrenArray" : [VehicleStandardM class],
             };
}

@end
