//
//  GoodsDetailsM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/2.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsDetailsM.h"

@implementation GoodsDetailsM

@end

@implementation GoodsDetailsProductM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"appImageList" : @"appImageList",
             @"appPhoto" : @"appPhoto",
             @"appPictureDescUrl" : @"appPictureDescUrl",
             @"parametersUrl" : @"parametersUrl",
             @"commentCount" : @"commentCount",
             @"brand" : @"brand",
             @"name" : @"name",
             @"uDescription" : @"description",
             @"oldPrice" : @"oldPrice",
             @"price" : @"price",
             @"saleAmount" : @"saleAmount",
             @"productGift" : @"productGift",
             @"serviceGift" : @"serviceGift"
             };
}

@end