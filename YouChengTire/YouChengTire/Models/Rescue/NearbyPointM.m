//
//  NearbyPointM.m
//  YouChengTire
//
//  Created by Baby on 16/4/5.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "NearbyPointM.h"

@implementation NearbyPointM
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"pointList" : [NearbyPointItemM class],
             };
}
@end

@implementation NearbyPointItemM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"name" : @"name",
             @"phone" : @"phone",
             @"mobile" : @"mobile",
             @"province" : @"province",
             @"city" : @"city",
             @"county" : @"county",
             @"address" : @"address",
             @"userType" : @"userType",
             @"distance" : @"distance",
             @"roleNames" : @"roleNames",
             @"appPhoto" : @"appPhoto",
             
             @"p_type" : @"point.type",
             @"p_name" : @"point.name",
             @"p_contact" : @"point.contact",
             @"p_phone" : @"point.phone",
             @"p_brand" : @"point.brand",
             @"p_scope" : @"point.scope",
             @"p_charge" : @"point.charge",
             @"p_position" : @"point.position",
             @"p_lng" : @"point.lng",
             @"p_lat" : @"point.lat",
             @"p_id" : @"point.id"
             };
}

@end
