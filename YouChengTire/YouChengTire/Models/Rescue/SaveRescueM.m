//
//  SaveRescueM.m
//  YouChengTire
//
//  Created by Baby on 16/4/6.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "SaveRescueM.h"

@implementation SaveRescueM
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"pictureList" : [SaveRescuePicM class],
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
//             @"userId" : @"userId"
//             @"number" : @"number"
//             @"paymentType" : @"paymentType"
//             @"type" : @"type"
//             @"province" : @"province"
//             @"city" : @"city"
//             @"county" : @"county"
//             @"detail" : @"detail"
//             @"lng" : @"lng"
//             @"lat" : @"lat"
             @"desc" : @"description"
//             @"price" : @"price"
             };
}

@end

@implementation SaveRescuePointM
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             };
}
@end

@implementation SaveRescuePicM
@end
