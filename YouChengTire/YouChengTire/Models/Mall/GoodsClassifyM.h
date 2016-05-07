//
//  GoodsClassifyM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/2.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@interface GoodsClassifyM : BaseM

@property (nonatomic, strong) NSArray *productTypeList;

@end

@interface GoodsClassifyItemM : BaseM

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *target;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *uDescription;

@end
