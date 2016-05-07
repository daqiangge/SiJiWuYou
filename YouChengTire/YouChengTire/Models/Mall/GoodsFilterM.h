//
//  GoodsFilterM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/21.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@interface GoodsFilterM : BaseM

@property (nullable, nonatomic, strong) NSString *provinceKey;
@property (nullable, nonatomic, strong) NSString *provinceValue;
@property (nullable, nonatomic, strong) NSString *cityKey;
@property (nullable, nonatomic, strong) NSString *cityValue;
@property (nullable, nonatomic, strong) NSString *areasValue;

@property (nullable, nonatomic, strong) NSString *brandKey;
@property (nullable, nonatomic, strong) NSString *brandValue;
@property (nullable, nonatomic, strong) NSString *seriesKey;
@property (nullable, nonatomic, strong) NSString *seriesValue;
@property (nullable, nonatomic, strong) NSString *standardKey;
@property (nullable, nonatomic, strong) NSString *standardValue;

@property (nullable, nonatomic, strong) NSArray *standardArray;

@end
