//
//  OrderDetailsM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/6.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderDetailsM.h"

@implementation OrderDetailsM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"number" : @"number",
             @"status" : @"status",
             @"address" : @"address",
             @"belongName" : @"belongName",
             @"productList" : @"productList",
             @"payment" : @"payment",
             @"setup" : @"setup",
             @"receipt" : @"receipt",
             @"message" : @"message",
             @"productPrice" : @"productPrice",
             @"freightPrice" : @"freightPrice",
             @"setupPrice" : @"setupPrice",
             @"cashPrice" : @"cashPrice",
             @"privilegePrice" : @"privilegePrice",
             @"totalPrice" : @"totalPrice",
             @"onlinePrice" : @"onlinePrice",
             @"createDate" : @"createDate"
             };
}

@end

@implementation OrderDetailsProductM

@end