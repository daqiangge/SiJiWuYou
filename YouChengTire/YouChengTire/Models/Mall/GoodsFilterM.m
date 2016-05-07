//
//  GoodsFilterM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/21.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsFilterM.h"

@implementation GoodsFilterM

- (instancetype)init {
    if (self = [super init]) {
        self.provinceKey = @"";
        self.cityKey = @"";
        self.areasValue = @"不限";
        self.brandKey = @"";
        self.brandValue = @"不限";
        self.seriesKey = @"";
        self.seriesValue = @"不限";
        self.standardKey = @"";
        self.standardValue = @"不限";
    }
    return self;
}

@end
