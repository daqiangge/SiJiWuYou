//
//  RescueM.m
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "RescueM.h"

@implementation RescueM

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"rescueList" : [RescueItemM class],
             };
}

@end

@implementation RescueItemM
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"des" : @"description"
             };
}
@end