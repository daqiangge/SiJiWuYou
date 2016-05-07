//
//  WalletM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "WalletM.h"

@implementation WalletM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"pointsM" : @"points",
             @"ticketMArray" : @"ticketList"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"ticketMArray" : WalletTicketM.class,
             };
}

@end

@implementation WalletPointsM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"currentPoint" : @"currentPoints",
             @"usedPoint" : @"usedPoints",
             @"expiredPoint" : @"expiredPoints"
             };
}

@end

@implementation WalletTicketM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"type" : @"type",
             @"status" : @"status",
             @"amount" : @"amount",
             @"usedAmount" : @"usedAmount",
             @"fromDate" : @"fromDate",
             @"endDate" : @"endDate",
             @"belong" : @"belong",
             };
}

@end

@implementation WalletBelongM

@end