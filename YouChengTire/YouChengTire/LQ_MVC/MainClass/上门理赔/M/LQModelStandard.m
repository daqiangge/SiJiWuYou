//
//  LQModelStandard.m
//  YouChengTire
//
//  Created by liqiang on 16/4/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQModelStandard.h"

@implementation LQModelStandard

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"_id":@"id"};
}

+ (NSDictionary *)objectClassInArray
{
    return @{@"childList":@"LQModelStandardChild"};
}

@end
