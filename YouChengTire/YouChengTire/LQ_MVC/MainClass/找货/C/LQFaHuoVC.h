//
//  LQFaHuoVC.h
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVC.h"

typedef void(^saveGoodsSuccess)();

@interface LQFaHuoVC : BaseVC

@property (nonatomic, copy) saveGoodsSuccess saveGoodsSuccess;

@end
