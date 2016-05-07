//
//  LQFaHuoDetailVC.h
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVC.h"

typedef void(^deleteGoodsSuccess)();

@interface LQFaHuoDetailVC : BaseVC

@property (nonatomic, copy) deleteGoodsSuccess deleteGoodsSuccess;
@property (nonatomic, copy) NSString *_id;
@end
