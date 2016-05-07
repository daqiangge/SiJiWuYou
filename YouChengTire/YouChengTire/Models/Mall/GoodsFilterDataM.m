//
//  GoodsFilterDataM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/21.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsFilterDataM.h"

@implementation GoodsFilterDataM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{ @"sId" : @"id" };
}

@end

@implementation GoodsFilterStandardM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{ @"sId" : @"id" };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"childList" : GoodsFilterStandardM.class };
}

@end


