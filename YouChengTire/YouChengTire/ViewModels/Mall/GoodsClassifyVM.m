//
//  GoodsClassifyVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/15.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsClassifyVM.h"
// Models
#import "GoodsClassifyM.h"

@implementation GoodsClassifyVM

#pragma mark - Override
- (void)initialize {
    self.title = @"全部分类";
}

#pragma mark - Public
- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    [ZPHTTP wPost:@"/app/shop/product/getProductTypeList"
       parameters:nil
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  GoodsClassifyM *goodsClassifyM = [GoodsClassifyM yy_modelWithJSON:object[@"data"]];
                  self.array = [self configureCell:goodsClassifyM];
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

- (NSArray *)configureCell:(GoodsClassifyM *)goodsClassifyM {
    NSMutableArray *mArray = @[].mutableCopy;
    
    NSInteger row = goodsClassifyM.productTypeList.count / 2;
    NSInteger rest = goodsClassifyM.productTypeList.count % 2;
    NSInteger count = row + rest;
    NSInteger index = 0;
    for (NSInteger i = 0; i < count; i ++) {
        if (i == count - 1
            && index == goodsClassifyM.productTypeList.count - 1) {
            NSDictionary *data_04 = @{
                                      @"kArray" : @[goodsClassifyM.productTypeList[index]]
                                      };
            [mArray addObject:data_04];
        }
        else {
            NSDictionary *data_05 = @{
                                      @"kType" : @"fourth",
                                      @"kArray" : @[
                                              goodsClassifyM.productTypeList[index++],
                                              goodsClassifyM.productTypeList[index++]
                                              ]
                                      };
            [mArray addObject:data_05];
        }
    }
    return mArray;
}

@end
