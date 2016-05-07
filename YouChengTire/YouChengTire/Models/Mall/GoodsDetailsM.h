//
//  GoodsDetailsM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/2.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@class GoodsDetailsProductM;

@interface GoodsDetailsM : BaseM

@property (nonatomic, strong) GoodsDetailsProductM *product;

@property (nonatomic, strong) NSArray *packageList;

@property (nonatomic, strong) NSArray *commentList;

@end

@interface GoodsDetailsProductM : BaseM

@property (nonatomic, strong) NSString *sId;
/**
 *  轮播图片
 */
@property (nonatomic, strong) NSArray<NSString *> *appImageList;
/**
 *  APP图片
 */
@property (nonatomic, strong) NSString *appPhoto;
/**
 *  图文详情
 */
@property (nonatomic, strong) NSString *appPictureDescUrl;
/**
 *  产品参数
 */
@property (nonatomic, strong) NSString *parametersUrl;
/**
 *  留言个数
 */
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *uDescription;
@property (nonatomic, strong) NSString *oldPrice;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *saleAmount;
/**
 *  标签
 */
@property (nonatomic, strong) NSString *productGift;
/**
 *  赠品
 */
@property (nonatomic, strong) NSString *serviceGift;


@end
