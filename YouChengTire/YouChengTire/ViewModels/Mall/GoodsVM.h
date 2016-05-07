//
//  GoodsVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/15.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@class GoodsFilterM;

/**
 *  0：按推荐排序
 *  1：按销量从高到低
 *  2：按评分从高到低
 *  3：按价格从底到高
 *  4：按价格从高到底
 */
typedef NS_ENUM(NSUInteger, GoodsSort) {
    GoodsSortRecommendDesc = 0,
    GoodsSortScoreDesc = 1,
    GoodsSortSalesDesc = 2,
    GoodsSortPriceDesc = 3,
    GoodsSortPriceAsc = 4
};

@interface GoodsVM : BaseVM

@property (nonatomic, strong) NSNumber *goodsSortNumber;
/**
 *  商品分类，值来自pictureList中的target
 */
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) GoodsFilterM *goodsFilterM;

@property (assign, nonatomic, readonly) BOOL isHasNext;

- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion;

- (void)requestLoadMoreData:(void (^)(id object))success
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion;

@end
