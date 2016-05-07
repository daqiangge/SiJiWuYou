//
//  MallM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/2.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "MallM.h"

@implementation MallM

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"imageList" : MallImageItemM.class,
             @"shopList" : MallShopItemM.class,
             @"productList" : MallProductItemM.class
             };
}

@end

@implementation MallImageItemM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"type" : @"type",
             @"path" : @"appPath",
             @"sort" : @"sort",
             @"target" : @"target"
             };
}

@end

@implementation MallShopItemM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"type" : @"type",
             @"path" : @"appPath",
             @"sort" : @"sort",
             @"target" : @"target",
             @"title" : @"title",
             @"uDescription" : @"description"
             };
}

@end

@implementation MallProductItemM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"name" : @"name",
             @"price" : @"price",
             @"saleAmount" : @"saleAmount",
             @"isRecommended" : @"isRecommended",
             @"appPhoto" : @"appPhoto"
             };
}

@end


