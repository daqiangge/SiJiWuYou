//
//  CartM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/5.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@class CartProductM;
@class CartProductInfoM;

@interface CartM : BaseM

@property (nullable, nonatomic, strong) NSString *sId;
@property (nullable, nonatomic, strong) NSString *shopId;
@property (nullable, nonatomic, strong) NSString *shopName;
@property (nullable, nonatomic, strong) NSArray<CartProductM *> *cartProductList;

@property (nullable, nonatomic, strong) NSNumber *isSelectNumber;

@end

@interface CartProductM : BaseM

@property (nullable, nonatomic, strong) NSString *sId;
@property (nullable, nonatomic, strong) NSString *count;
@property (nullable, nonatomic, strong) CartProductInfoM *product;

@property (nullable, nonatomic, strong) NSNumber *isSelectNumber;

@end

@interface CartProductInfoM : BaseM

@property (nullable, nonatomic, strong) NSString *sId;
@property (nullable, nonatomic, strong) NSString *appPhoto;
@property (nullable, nonatomic, strong) NSString *name;
@property (nullable, nonatomic, strong) NSString *price;
@property (nullable, nonatomic, strong) NSString *oldPrice;

@end
