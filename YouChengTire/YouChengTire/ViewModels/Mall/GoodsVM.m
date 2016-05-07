//
//  GoodsVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/15.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsVM.h"
// Models
#import "GoodsM.h"
#import "GoodsFilterM.h"

@interface GoodsVM ()

/**
 *  当前页
 */
@property (nonatomic, strong) NSString *pageNo;
/**
 *  每页显示行数
 */
@property (nonatomic, strong) NSString *pageSize;

@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign, readwrite) BOOL isHasNext;

@end

@implementation GoodsVM

#pragma mark - Override
- (void)initialize {
    self.title = @"商城";
    
    _goodsSortNumber = @(GoodsSortRecommendDesc);
    _goodsFilterM = [GoodsFilterM new];
    
    _pageSize = @"20";
}

#pragma mark - Public
- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    _curPage = 1;
    NSDictionary *dictionary = @{
                                 @"type" :_type,
                                 @"orderBy" : [NSString stringWithFormat:@"%@", _goodsSortNumber],
                                 @"series" : _goodsFilterM.seriesKey,
                                 @"standard" : _goodsFilterM.standardKey,
                                 @"brand" : _goodsFilterM.brandKey,
                                 @"province" : _goodsFilterM.provinceKey,
                                 @"city" : _goodsFilterM.cityKey,
                                 @"county" : @"",
                                 @"pageNo" : @"1",
                                 @"pageSize" : _pageSize
                                 };
    @weakify(self);
    [ZPHTTP wPost:@"/app/shop/product/getProductList"
       parameters:dictionary
          success:^(NSDictionary *object) {
              @strongify(self);
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  GoodsM *goodsM = [GoodsM yy_modelWithJSON:object[@"data"]];
                  self.array = goodsM.productList;
                  self.isHasNext = (self.array.count == 20);
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

- (void)requestLoadMoreData:(void (^)(id object))success
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion {
    NSDictionary *dictionary = @{
                                 @"type" :_type,
                                 @"orderBy" : [NSString stringWithFormat:@"%@", _goodsSortNumber],
                                 @"series" : _goodsFilterM.seriesKey,
                                 @"standard" : _goodsFilterM.standardKey,
                                 @"brand" : _goodsFilterM.brandKey,
                                 @"province" : _goodsFilterM.provinceKey,
                                 @"city" : _goodsFilterM.cityKey,
                                 @"county" : @"",
                                 @"pageNo" : [NSString stringWithFormat:@"%ld", (long)++_curPage],
                                 @"pageSize" : _pageSize
                                 };
    @weakify(self);
    [ZPHTTP wPost:@"/app/shop/product/getProductList"
       parameters:dictionary
          success:^(NSDictionary *object) {
              @strongify(self);
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  GoodsM *goodsM = [GoodsM yy_modelWithJSON:object[@"data"]];
                  NSMutableArray *mArray = self.array.mutableCopy;
                  [mArray addObjectsFromArray:goodsM.productList];
                  self.array = mArray;
                  self.isHasNext = (mArray.count == 20);
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

#pragma mark - Custom Accessors

@end
