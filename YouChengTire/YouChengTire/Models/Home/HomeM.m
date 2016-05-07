//
//  HomeM.m
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "HomeM.h"

@implementation HomeM

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"pictureList1" : HomePictureM.class,
             @"pictureList2" : HomePictureM.class,
             @"infoList" : HomeInfoM.class
             };
}

@end

@implementation HomePictureM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"type" : @"type",
             @"path" : @"appPath",
             @"sort" : @"sort",
             @"target" : @"target"
             };
}

@end

@implementation HomeInfoM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"title" : @"title",
             @"photo" : @"photo",
             @"content" : @"content",
             @"sId" : @"id",
             @"isHot" : @"isHot",
             @"path" : @"path"
             };
}

@end
