//
//  ModelClaim.m
//  YouChengTire
//
//  Created by liqiang on 16/4/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "ModelClaim.h"

@implementation ModelClaim

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"_id":@"id",@"_description":@"description"};
}

+ (NSDictionary *)objectClassInArray
{
    return @{@"pictureList":@"LQModelPicture"};
}

@end
