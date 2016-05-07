//
//  GoodsM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/2.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsM.h"

@implementation GoodsM

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"productList" : GoodsItemM.class
             };
}

@end

@implementation GoodsItemM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"name" : @"name",
             @"price" : @"price",
             @"saleAmount" : @"saleAmount",
             @"isRecommended" : @"isRecommended",
             @"appPhoto" : @"appPhoto",
             @"uDescription" : @"description"
             };
}

@end