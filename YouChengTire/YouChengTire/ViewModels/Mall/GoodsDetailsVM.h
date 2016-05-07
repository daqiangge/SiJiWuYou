//
//  GoodsDetailsVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"
// Models
#import "OrderCheckM.h"

@class GoodsDetailsProductM;

@interface GoodsDetailsVM : BaseVM

@property (nonatomic, strong) NSString *sId;

@property (nonatomic, strong) GoodsDetailsProductM *product;
@property (nonatomic, strong) NSString *productCount;

@property (nonatomic, strong) OrderCheckM *orderCheckM;

- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion;

- (void)requestSubmitOrder:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion;

- (void)requestSaveCart:(void (^)(id object))success
                  error:(void (^)(NSError *error))error
                failure:(void (^)(NSError *error))failure
             completion:(void (^)(void))completion;

@end
