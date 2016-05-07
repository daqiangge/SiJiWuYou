//
//  GetRescueM.m
//  YouChengTire
//
//  Created by Baby on 16/4/6.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GetRescueM.h"

@implementation GetRescueM
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"pictureList" : [GetRescuePicM class],
             };
}
@end

@implementation GetRescuePointM
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             };
}
@end

@implementation GetRescuePicM
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             };
}
@end