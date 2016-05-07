//
//  CartVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/12.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "CartVM.h"
// Models
#import "CartM.h"
#import "OrderCheckM.h"

@implementation CartVM

#pragma mark - Override
- (void)initialize {
    self.title = @"购物车";
    
    _isEditNumber = @NO;
    _totalPrice = @"0.00";
    _totalCount = @"0";
    
    _productId = @"";
    _productCount = @"";
    _cartPackageId = @"";
    _cartPackageCount = @"";
}

#pragma mark - Public
- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{}.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    @weakify(self);
    [ZPHTTP wPost:@"app/shop/order/getCart"
       parameters:parameters
          success:^(NSDictionary *object) {
              @strongify(self);
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  NSArray<CartM *> *cartMArray = [NSArray yy_modelArrayWithClass:CartM.class
                                                                            json:data[@"cartList"]];
                  [self configureCell:cartMArray];
                  success(nil);
                  completion();
              }
              else {
                  NSInteger errnoInteger = [object[@"msgCode"] integerValue];
                  NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : object[@"msg"] };
                  NSError *uError = [NSError errorWithDomain:@"ZPCustom"
                                                        code:errnoInteger
                                                    userInfo:userInfo];
                  error(uError);
                  completion();
              }
          } failure:^(NSError *error) {
              failure(error);
              completion();
          }];
}

- (void)requestSaveCartCount:(void (^)(id object))success
                       error:(void (^)(NSError *error))error
                     failure:(void (^)(NSError *error))failure
                  completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"productId" : _productId,
                                        @"productCount" : _productCount,
                                        @"cartPackageId" : _cartPackageId,
                                        @"cartPackageCount" : _cartPackageCount
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    [ZPHTTP wPost:@"/app/shop/order/saveCartCount"
       parameters:parameters
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  success(nil);
                  completion();
              }
              else {
                  NSInteger errnoInteger = [object[@"msgCode"] integerValue];
                  NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : object[@"msg"] };
                  NSError *uError = [NSError errorWithDomain:@"ZPCustom"
                                                        code:errnoInteger
                                                    userInfo:userInfo];
                  error(uError);
                  completion();
              }
          } failure:^(NSError *error) {
              failure(error);
              completion();
          }];
}

- (void)requestDeleteCartProduct:(void (^)(id object))success
                           error:(void (^)(NSError *error))error
                         failure:(void (^)(NSError *error))failure
                      completion:(void (^)(void))completion {
    NSString *cartProductIds = @"";
    for (NSString *productId in _cartProductIdsArray) {
        cartProductIds = [cartProductIds stringByAppendingFormat:@"%@,", productId];
    }
    if (cartProductIds.length > 0) {
        cartProductIds = [cartProductIds substringToIndex:cartProductIds.length - 1];
    }
    
    NSString *cartPackageIds = @"";
    for (NSString *packageId in _cartPackageIdsArray) {
        cartPackageIds = [cartPackageIds stringByAppendingFormat:@"%@,", packageId];
    }
    if (cartPackageIds.length > 0) {
        cartPackageIds = [cartPackageIds substringToIndex:cartPackageIds.length - 1];
    }
    
    NSMutableDictionary *parameters = @{
                                        @"cartProductIds" : cartProductIds,
                                        @"cartPackageIds" : cartPackageIds
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    [ZPHTTP wPost:@"/app/shop/order/deleteCartProduct"
       parameters:parameters
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  success(nil);
//                  completion();
              }
              else {
                  NSInteger errnoInteger = [object[@"msgCode"] integerValue];
                  NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : object[@"msg"] };
                  NSError *uError = [NSError errorWithDomain:@"ZPCustom"
                                                        code:errnoInteger
                                                    userInfo:userInfo];
                  error(uError);
                  completion();
              }
          } failure:^(NSError *error) {
              failure(error);
              completion();
          }];
}

- (void)requestSubmitOrder:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    NSString *cartProductIds = @"";
    for (NSString *productId in _cartProductIdsArray) {
        cartProductIds = [cartProductIds stringByAppendingFormat:@"%@;", productId];
    }
    if (cartProductIds.length > 0) {
        cartProductIds = [cartProductIds substringToIndex:cartProductIds.length - 1];
    }
    _cartProductIds = cartProductIds;
    
    NSString *cartPackageIds = @"";
    for (NSString *packageId in _cartPackageIdsArray) {
        cartPackageIds = [cartPackageIds stringByAppendingFormat:@"%@;", packageId];
    }
    if (cartPackageIds.length > 0) {
        cartPackageIds = [cartPackageIds substringToIndex:cartPackageIds.length - 1];
    }
    _cartPackageIds = cartPackageIds;
    
    NSMutableDictionary *parameters = @{
                                        @"cartProductIds" : _cartProductIds,
                                        @"cartPackageIds" : _cartPackageIds
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    
    [ZPHTTP wPost:@"app/shop/order/submitOrder"
       parameters:parameters
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  self.orderCheckM = [OrderCheckM yy_modelWithJSON:data[@"order"]];
                  success(nil);
                  completion();
              }
              else {
                  NSInteger errnoInteger = [object[@"msgCode"] integerValue];
                  NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : object[@"msg"] };
                  NSError *uError = [NSError errorWithDomain:@"ZPCustom"
                                                        code:errnoInteger
                                                    userInfo:userInfo];
                  error(uError);
                  completion();
              }
          } failure:^(NSError *error) {
              failure(error);
              completion();
          }];
}

- (void)configureCell:(NSArray<CartM *> *)cartMArray {
    NSMutableArray *mArray = @[].mutableCopy;
    for (CartM *cartM in cartMArray) {
        NSMutableArray *sectionMArray = @[].mutableCopy;
        NSDictionary *dictionary = @{
                                     @"kCell" : @"First",
                                     @"kModel" : cartM
                                     };
        [sectionMArray addObject:dictionary];
        for (CartProductM *cartProductM in cartM.cartProductList) {
            NSDictionary *dictionary = @{
                                         @"kCell" : @"Second",
                                         @"kModel" : cartProductM
                                         };
            [sectionMArray addObject:dictionary];
        }
        [mArray addObject:sectionMArray];
    }
    self.array = mArray;
}

- (BOOL)isSelectAll {
    BOOL isSelectAll = YES;
    NSMutableArray *mArray = @[].mutableCopy;
    NSInteger totalCount = 0;
    CGFloat totalPrice = 0.00;
    if (self.array.count > 0) {
        for (NSArray *array in self.array) {
            for (NSDictionary *dictionary in array) {
                NSMutableDictionary *mDictionary = dictionary.mutableCopy;
                if ([dictionary[@"kCell"] isEqualToString:@"First"]) {
                    CartM *cartM = mDictionary[@"kModel"];
                    if (![cartM.isSelectNumber boolValue] && isSelectAll) {
                        isSelectAll = NO;
                    }
                }
                else {
                    CartProductM *cartProductM = mDictionary[@"kModel"];
                    if ([cartProductM.isSelectNumber boolValue]) {
                        [mArray addObject:cartProductM.sId];
                        NSInteger count = [cartProductM.count integerValue];
                        CGFloat price = [cartProductM.product.price floatValue];
                        totalCount = totalCount + 1;
                        totalPrice = totalPrice + price * count;
                    }
                }
            }
        }
    }
    else {
        isSelectAll = NO;
    }
    _cartProductIdsArray = mArray;
    self.totalPrice = [NSString stringWithFormat:@"%.2f", totalPrice];
    self.totalCount = [NSString stringWithFormat:@"%ld", (long)totalCount];
    return isSelectAll;
}

- (void)configureSelectAllButton:(BOOL)isSelectAll {
    for (NSArray *array in self.array) {
        for (NSDictionary *dictionary in array) {
            NSMutableDictionary *mDictionary = dictionary.mutableCopy;
            if ([dictionary[@"kCell"] isEqualToString:@"First"]) {
                CartM *cartM = mDictionary[@"kModel"];
                cartM.isSelectNumber = @(isSelectAll);
                mDictionary[@"kModel"] = cartM;
            }
            else {
                CartProductM *cartProductM = mDictionary[@"kModel"];
                cartProductM.isSelectNumber = @(isSelectAll);
                mDictionary[@"kModel"] = cartProductM;
            }
        }
    }
}

@end
