//
//  CartVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/12.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@class OrderCheckM;

@interface CartVM : BaseVM

@property (nonatomic, weak) UIViewController *masterVC;

@property (nonatomic, strong) NSNumber *isEditNumber;

@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSString *totalCount;

- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion;

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productCount;
@property (nonatomic, strong) NSString *cartPackageId;
@property (nonatomic, strong) NSString *cartPackageCount;

- (void)requestSaveCartCount:(void (^)(id object))success
                       error:(void (^)(NSError *error))error
                     failure:(void (^)(NSError *error))failure
                  completion:(void (^)(void))completion;

@property (nonatomic, strong) NSArray<NSString *> *cartProductIdsArray;
@property (nonatomic, strong) NSArray<NSString *> *cartPackageIdsArray;

- (void)requestDeleteCartProduct:(void (^)(id object))success
                           error:(void (^)(NSError *error))error
                         failure:(void (^)(NSError *error))failure
                      completion:(void (^)(void))completion;

@property (nonatomic, strong) NSString *cartProductIds;
@property (nonatomic, strong) NSString *cartPackageIds;
@property (nonatomic, strong) OrderCheckM *orderCheckM;

- (void)requestSubmitOrder:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion;

- (BOOL)isSelectAll;
- (void)configureSelectAllButton:(BOOL)isSelectAll;

@end
