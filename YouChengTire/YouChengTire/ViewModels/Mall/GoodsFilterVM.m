//
//  GoodsFilterVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsFilterVM.h"
// ViewModels
#import "GoodsFilterHeader.h"
// Models
#import "GoodsFilterM.h"

@interface GoodsFilterVM ()

@end

@implementation GoodsFilterVM

#pragma mark - Override
- (void)initialize {
    self.title = @"筛选";
}

- (void)initializeData {
    NSMutableArray *mArraySection01 = @[].mutableCopy;
    NSDictionary *areas = @{
                            kTitle : @"省、市",
                            kValue : _goodsFilterM.areasValue,
                            kENum : @(GoodsFilterProvinceType)
                            };
    [mArraySection01 addObject:areas];
    
    NSMutableArray *mArraySection02 = @[].mutableCopy;
    NSDictionary *brand = @{
                            kTitle : @"品牌",
                            kValue : _goodsFilterM.brandValue,
                            kENum : @(GoodsFilterBrandType)
                            };
    [mArraySection02 addObject:brand];
    
    if ([@"1" isEqualToString:_type]) {
        NSDictionary *series = @{
                                 kTitle : @"系列",
                                 kValue : _goodsFilterM.seriesValue,
                                 kENum : @(GoodsFilterSeriesType)
                                 };
        [mArraySection02 addObject:series];
        
        NSDictionary *standard = @{
                                   kTitle : @"规格",
                                   kValue : _goodsFilterM.standardValue,
                                   kENum : @(GoodsFilterStandardType)
                                   };
        [mArraySection02 addObject:standard];
    }

    self.array = @[
                   mArraySection01,
                   mArraySection02
                   ];
}

@end
