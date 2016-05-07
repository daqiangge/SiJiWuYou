//
//  GoodsM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/2.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@interface GoodsM : BaseM

@property (nonatomic, strong) NSArray *productList;

@end

@interface GoodsItemM : BaseM

@property (nonatomic, strong) NSString *sId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *saleAmount;
@property (nonatomic, strong) NSString *isRecommended;
@property (nonatomic, strong) NSString *appPhoto;
@property (nonatomic, strong) NSString *uDescription;

@end
