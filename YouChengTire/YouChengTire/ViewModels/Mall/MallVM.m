//
//  MallVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "MallVM.h"
// Models
#import "MallM.h"

@implementation MallVM

#pragma mark - Override
- (void)initialize {
    self.title = @"商城";
}

#pragma mark - Public
- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    [ZPHTTP wPost:@"/app/shop/product/getHomeInfo"
       parameters:nil
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  MallM *mallM = [MallM yy_modelWithJSON:object[@"data"]];
                  self.array = [self configureCell:mallM];
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

- (NSArray *)configureCell:(MallM *)mallM {
    NSMutableArray *mArray = @[].mutableCopy;
    
    NSDictionary *data_01 = @{
                              @"kType" : @"first",
                              @"kArray" : mallM.imageList
                              };
    [mArray addObject:data_01];

    NSDictionary *data_02 = @{
                              @"kType" : @"second",
                              @"kArray" : mallM.shopList
                              };
    [mArray addObject:data_02];
    
    NSDictionary *data_03 = @{
                              @"kType" : @"third",
                              };
    [mArray addObject:data_03];
    
    NSInteger row = mallM.productList.count / 2;
    NSInteger rest = mallM.productList.count % 2;
    NSInteger count = row + rest;
    NSInteger index = 0;
    for (NSInteger i = 0; i < count; i ++) {
        if (i == count - 1
            && index == mallM.productList.count - 1) {
            NSDictionary *data_04 = @{
                                      @"kType" : @"fourth",
                                      @"kArray" : @[mallM.productList[index]]
                                      };
            [mArray addObject:data_04];
        }
        else {
            NSDictionary *data_05 = @{
                                      @"kType" : @"fourth",
                                      @"kArray" : @[mallM.productList[index++], mallM.productList[index++]]
                                      };
            [mArray addObject:data_05];
        }
    }
    return mArray;
}

@end
