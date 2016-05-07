//
//  GoodsFilterDataVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"
// ViewModels
#import "GoodsFilterHeader.h"

@class GoodsFilterM;
@class GoodsFilterDataM;

@interface GoodsFilterDataVM : BaseVM

@property (nullable, nonatomic, strong) NSString *type;
@property (nullable, nonatomic, strong) GoodsFilterM *goodsFilterM;
@property (nullable, nonatomic, strong) NSString *parent;

@property (nonatomic, assign) GoodsFilterType goodsFilterType;

- (void)requestRefreshData:(void (^ _Nullable)(id _Nullable object))success
                     error:(void (^ _Nullable)(NSError  * _Nullable error))error
                   failure:(void (^ _Nullable)(NSError  * _Nullable error))failure
                completion:(void (^ _Nullable)(void))completion;

- (void)setGoodsFilterDataM:(GoodsFilterDataM * _Nullable)goodsFilterDataM;

@end

@interface GoodsFilterProvinceDataVM : GoodsFilterDataVM

@end

@interface GoodsFilterCityDataVM : GoodsFilterDataVM

@end

@interface GoodsFilterBrandDataVM : GoodsFilterDataVM

@end

@interface GoodsFilterSeriesDataVM : GoodsFilterDataVM

@end

@interface GoodsFilterStandardDataVM : GoodsFilterDataVM

@end
