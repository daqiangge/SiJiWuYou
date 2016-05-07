//
//  GoodsFilterV.h
//  YouChengTire
//  商品筛选
//  Created by WangZhipeng on 16/4/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseV.h"

@interface GoodsFilterV : BaseV

@property (nullable, nonatomic, weak) IBOutlet UIView *masterV;

@property (nullable, nonatomic, strong) UINavigationController *nc;

+ (instancetype __nullable)sharedManager;

- (void)showView;
- (void)closeView;

@end
