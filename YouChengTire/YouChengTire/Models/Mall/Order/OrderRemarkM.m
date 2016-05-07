//
//  OrderRemarkM.m
//  YouChengTire
//  订单评论
//  Created by WangZhipeng on 16/4/25.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderRemarkM.h"

@implementation OrderRemarkM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"userName" : @"userName",
             @"content" : @"content",
             @"score" : @"score",
             @"pictureList" : @"pictureList",
             @"childList" : @"childList"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"pictureList" : RemarkPictureM.class,
             @"childList" : OrderRemarkM.class,
             };
}

@end

@implementation RemarkPictureM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"appPath" : @"appPath",
             @"sId" : @"id",
             @"targetId" : @"targetId",
             @"createDate" : @"createDate"
             };
}

@end