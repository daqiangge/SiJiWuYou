//
//  MallM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/2.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@class MallImageItemM;
@class MallShopItemM;
@class MallProductItemM;

@interface MallM : BaseM

@property (nullable, nonatomic, copy) NSArray<MallImageItemM *> *imageList;
@property (nullable, nonatomic, copy) NSArray<MallShopItemM *> *shopList;
@property (nullable, nonatomic, copy) NSArray<MallProductItemM *> *productList;

@end

@interface MallImageItemM : BaseM

@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *path;
@property (nullable, nonatomic, copy) NSString *sort;
@property (nullable, nonatomic, copy) NSString *target;

@end

@interface MallShopItemM : BaseM

@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *path;
@property (nullable, nonatomic, copy) NSString *sort;
@property (nullable, nonatomic, copy) NSString *target;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *uDescription;

@end

@interface MallProductItemM : BaseM

@property (nullable, nonatomic, copy) NSString *sId;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *price;
@property (nullable, nonatomic, copy) NSString *saleAmount;
@property (nullable, nonatomic, copy) NSString *isRecommended;
@property (nullable, nonatomic, copy) NSString *appPhoto;

@end
