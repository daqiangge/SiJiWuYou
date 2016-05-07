//
//  OrderFrameM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/5.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderFrameM.h"

@implementation OrderFrameM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"belongName" : @"belongName",
             @"status" : @"status",
             @"isClaimed" : @"isClaimed",
             @"codPrice" : @"codPrice",
             @"productPrice" : @"productPrice",
             @"freightPrice" : @"freightPrice",
             @"setupPrice" : @"setupPrice",
             @"cashPrice" : @"cashPrice",
             @"privilegePrice" : @"privilegePrice",
             @"totalPrice" : @"totalPrice",
             @"onlinePrice" : @"onlinePrice",
             @"productList" : @"productList",
             @"packageList" : @"packageList"
             };
}

@end

@implementation OrderFrameProductM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"photo" : @"photo",
             @"name" : @"name",
             @"price" : @"price",
             @"oldPrice" : @"oldPrice"
             };
}

@end
