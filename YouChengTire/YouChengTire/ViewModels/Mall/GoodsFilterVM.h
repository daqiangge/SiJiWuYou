//
//  GoodsFilterVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@class GoodsFilterM;

@interface GoodsFilterVM : BaseVM

@property (nullable, nonatomic, strong) NSString *type;
@property (nullable, nonatomic, strong) GoodsFilterM *goodsFilterM;

- (void)initializeData;

@end
