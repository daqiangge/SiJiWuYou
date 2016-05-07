//
//  GoodsClassifyM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/2.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsClassifyM.h"

@implementation GoodsClassifyM

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"productTypeList" : GoodsClassifyItemM.class
             };
}

@end

@implementation GoodsClassifyItemM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"type" : @"type",
             @"path" : @"path",
             @"sort" : @"sort",
             @"target" : @"target",
             @"title" : @"title",
             @"uDescription" : @"description"
             };
}

@end
