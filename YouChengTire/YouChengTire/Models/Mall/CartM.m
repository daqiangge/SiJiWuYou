//
//  CartM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/5.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "CartM.h"

@implementation CartM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"shopId" : @"shopId",
             @"shopName" : @"shopName",
             @"cartProductList" : @"cartProductList"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"cartProductList" : CartProductM.class
             };
}

@end

@implementation CartProductM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"count" : @"count",
             @"product" : @"product"
             };
}

@end

@implementation CartProductInfoM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"appPhoto" : @"appPhoto",
             @"name" : @"name",
             @"price" : @"price",
             @"oldPrice" : @"oldPrice"
             };
}

@end
