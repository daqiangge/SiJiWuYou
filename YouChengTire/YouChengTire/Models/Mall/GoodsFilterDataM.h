//
//  GoodsFilterDataM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/21.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@interface GoodsFilterDataM : BaseM

@property (nullable, nonatomic, strong) NSString *sId;
@property (nullable, nonatomic, strong) NSString *name;
@property (nullable, nonatomic, strong) NSNumber *isSelectNumber;

@end

@interface GoodsFilterStandardM : GoodsFilterDataM

@property (nullable, strong, nonatomic) NSString *sort;
@property (nullable, strong, nonatomic) NSArray<GoodsFilterStandardM *> *childList;

@end
