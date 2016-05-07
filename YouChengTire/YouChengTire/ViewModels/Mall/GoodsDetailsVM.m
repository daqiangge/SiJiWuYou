//
//  GoodsDetailsVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsDetailsVM.h"
// Models
#import "GoodsDetailsM.h"
#import "OrderCheckM.h"

@interface GoodsDetailsM ()

@end

@implementation GoodsDetailsVM

#pragma mark - Override
- (void)initialize {
    self.title = @"商品详情";
    
    _productCount = @"1";
}

#pragma mark - Public
- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    NSDictionary *dictionary = @{
                                 @"id" : _sId
                                 };
    @weakify(self)
    [ZPHTTP wPost:@"/app/shop/product/getProduct"
       parameters:dictionary
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  @strongify(self)
                  GoodsDetailsM *goodsDetailsM = [GoodsDetailsM yy_modelWithJSON:object[@"data"]];
                  self.array = [self configureCell:goodsDetailsM];
                  
                  self.product = goodsDetailsM.product;
                  
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

- (NSArray *)configureCell:(GoodsDetailsM *)goodsDetailsM {
    NSMutableArray *mArray = @[].mutableCopy;
    
    GoodsDetailsProductM *productM = goodsDetailsM.product;
    // Section 01
    NSMutableArray *mSectionArray01 = @[].mutableCopy;
    NSDictionary *data_01 = @{
                              kCell : @"GoodsDetailsFirstCell",
                              kModel : productM
                              };
    [mSectionArray01 addObject:data_01];
    
    NSDictionary *data_02 = @{
                              kCell : @"GoodsDetailsSecondCell",
                              kModel : productM
                              };
    [mSectionArray01 addObject:data_02];
    
    NSDictionary *data_03 = @{
                              kCell : @"GoodsDetailsThirdCell",
                              kModel : productM
                              };
    [mSectionArray01 addObject:data_03];
    
    NSArray *serviceGiftArray = @[];
    if (productM.serviceGift.length > 0) {
        serviceGiftArray =  [productM.serviceGift componentsSeparatedByString:@";"];
    }
    if (serviceGiftArray.count > 0) {
        NSDictionary *data_04 = @{
                                  kCell : @"GoodsDetailsFourthCell",
                                  kArray : serviceGiftArray
                                  };
        [mSectionArray01 addObject:data_04];
    }
    
    [mArray addObject:mSectionArray01];
    
    // Section 02
    NSDictionary *data_05 = @{
                              kCell : @"GoodsDetailsFifthCell"
                              };
    
    NSArray *sectionArray02 = @[ data_05 ];
    [mArray addObject:sectionArray02];
    
    // Section 03
    NSMutableArray *mSectionArray03 = @[].mutableCopy;
    NSArray *productGiftArray = @[];
    if (productM.productGift.length > 0) {
        productGiftArray =  [productM.productGift componentsSeparatedByString:@";"];
    }
    for (NSInteger i = 0; i < productGiftArray.count; i++) {
        if (![productGiftArray[i] isEqualToString:@""]) {
            NSDictionary *data_06 = @{
                                      kCell : @"GoodsDetailsSixthCell",
                                      kTitle : [NSString stringWithFormat:@"赠品%li", (long)i+1],
                                      kValue : productGiftArray[i]
                                      };
            [mSectionArray03 addObject:data_06];
        }
    }
    [mArray addObject:mSectionArray03];
    
    //    NSDictionary *data_07 = @{
    //                              @"kType" : @"seventh",
    //                              };
    //    NSArray *section_04 = @[
    //                            data_07,
    //                            data_07
    //                            ];
    
    //    NSDictionary *data_08 = @{
    //                              @"kType" : @"eighth",
    //                              };
    //    NSDictionary *data_09 = @{
    //                              @"kType" : @"ninth",
    //                              };
    //    NSArray *section_05 = @[
    //                            data_08,
    //                            data_09,
    //                            data_09
    //                            ];
    
    NSDictionary *data_07 = @{
                              kCell : @"GoodsDetailsEighthCell",
                              kModel : productM,
                              kMethod : @"userComment"
                              };
    NSArray *sectionArray04 = @[
                                data_07
                                ];
    [mArray addObject:sectionArray04];
    
    NSDictionary *data_08 = @{
                              kCell : @"GoodsDetailsTenthCell",
                              kTitle : @"图文详情",
                              kMethod : @"graphicDetails"
                              };
    NSDictionary *data_09 = @{
                              kCell : @"GoodsDetailsTenthCell",
                              kTitle : @"产品参数",
                              kMethod : @"productParameters"
                              };
    NSArray *sectionArray05 = @[
                                data_08,
                                data_09
                                ];
    [mArray addObject:sectionArray05];
    
    return mArray;
}

- (void)requestSubmitOrder:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"productId" : _product.sId,
                                        @"productCount" : _productCount
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    @weakify(self)
    [ZPHTTP wPost:@"app/shop/order/submitOrder"
       parameters:parameters
          success:^(NSDictionary *object) {
              @strongify(self)
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

- (void)requestSaveCart:(void (^)(id object))success
                  error:(void (^)(NSError *error))error
                failure:(void (^)(NSError *error))failure
             completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"productId" : _product.sId,
                                        @"count" : _productCount
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    [ZPHTTP wPost:@"app/shop/order/saveProductCart"
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

@end
