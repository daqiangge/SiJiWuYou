//
//  GoodsFilterVC.h
//  YouChengTire
//  商品筛选
//  Created by WangZhipeng on 16/4/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVC.h"

@class GoodsFilterM;

@protocol GoodsFilterVCDelegate <NSObject>

- (void)callBackGoodsFilterM:(GoodsFilterM *)goodsFilter;

@end

@interface GoodsFilterVC : BaseVC

@end
