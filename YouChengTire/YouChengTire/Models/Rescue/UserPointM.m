//
//  UserPointM.m
//  YouChengTire
//
//  Created by Baby on 16/4/5.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "UserPointM.h"

@implementation UserPointM
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"pointList" : [UserPointItemM class],
             };
}
@end


@implementation UserPointItemM
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"name" : @"name",
             @"contact" : @"contact",
             @"phone" : @"phone",
             @"brand" : @"brand",
             @"scope" : @"scope",
             @"charge" : @"charge",
             @"lng" : @"lng",
             @"lat" : @"lat",
             @"province" : @"province",
             @"city" : @"city",
             @"county" : @"county",
             @"detail" : @"detail",
             @"distance" : @"distance"
             };
}
@end
