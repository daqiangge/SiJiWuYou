//
//  GoodsFilterDataVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsFilterDataVM.h"
// Models
#import "GoodsFilterM.h"
#import "GoodsFilterDataM.h"

@implementation GoodsFilterDataVM

- (void)requestRefreshData:(void (^ _Nullable)(id _Nullable object))success
                     error:(void (^ _Nullable)(NSError  * _Nullable error))error
                   failure:(void (^ _Nullable)(NSError  * _Nullable error))failure
                completion:(void (^ _Nullable)(void))completion {}

- (void)setGoodsFilterDataM:(GoodsFilterDataM * _Nullable)goodsFilterDataM {}

@end

@implementation GoodsFilterProvinceDataVM

#pragma mark - Override
- (void)initialize {
    self.title = @"省";
    self.goodsFilterType = GoodsFilterProvinceType;
}

- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"area"
                                           ofType:@"plist"];
    NSDictionary *areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *components = [areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *provinceTmp = @[].mutableCopy;
    for (int i=0; i < sortedArray.count; i++) {
        NSString *index = sortedArray[i];
        NSArray *tmp = [areaDic[index] allKeys];
        [provinceTmp addObject:tmp[0]];
    }
    NSArray *province = [[NSArray alloc] initWithArray:provinceTmp];
    
    NSMutableArray *mArray = @[].mutableCopy;
    for (NSString *name in province ) {
        GoodsFilterDataM *model = [GoodsFilterDataM new];
        model.sId = name;
        model.name = name;
        [mArray addObject:model];
    }
    for (GoodsFilterDataM *model in mArray) {
        if ([self.goodsFilterM.provinceValue isEqualToString:model.sId]) {
            model.isSelectNumber = @YES;
            break;
        }
    }
    self.array = mArray;
    success(nil);
    completion();
}

- (void)setGoodsFilterDataM:(GoodsFilterDataM * _Nullable)goodsFilterDataM {
//    self.goodsFilterM.provinceKey = goodsFilterDataM.sId;
    self.goodsFilterM.provinceValue = goodsFilterDataM.name;
}

@end

@implementation GoodsFilterCityDataVM

#pragma mark - Override
- (void)initialize {
    self.title = @"市";
    self.goodsFilterType = GoodsFilterCityType;
}

- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"area"
                                           ofType:@"plist"];
    NSDictionary *areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *components = [areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *provinceTmp = @[].mutableCopy;
    for (int i = 0; i < sortedArray.count; i++) {
        NSString *index = sortedArray[i];
        NSArray *tmp = [areaDic[index] allKeys];
        [provinceTmp addObject:tmp[0]];
    }
    NSArray *province = [[NSArray alloc] initWithArray:provinceTmp];
    NSInteger row = [province indexOfObject:self.goodsFilterM.provinceValue];
    
    NSDictionary *tmp = [NSDictionary dictionaryWithDictionary:areaDic[[NSString stringWithFormat:@"%ld", (long)row]]];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:tmp[self.goodsFilterM.provinceValue]];
    NSArray *cityArray = [dic allKeys];
    sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;//递减
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;//上升
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    NSMutableArray *city = @[].mutableCopy;
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = sortedArray[i];
        NSArray *temp = [dic[index] allKeys];
        [city addObject:temp[0]];
    }
    
    NSMutableArray *mArray = @[].mutableCopy;
    for (NSString *name in city) {
        GoodsFilterDataM *model = [GoodsFilterDataM new];
        model.sId = name;
        model.name = name;
        [mArray addObject:model];
    }
    for (GoodsFilterDataM *model in mArray) {
        if ([self.goodsFilterM.cityKey isEqualToString:model.sId]) {
            model.isSelectNumber = @YES;
            break;
        }
    }
    self.array = mArray;
    success(nil);
    completion();
}

- (void)setGoodsFilterDataM:(GoodsFilterDataM * _Nullable)goodsFilterDataM {
    self.goodsFilterM.cityKey = goodsFilterDataM.sId;
    self.goodsFilterM.cityValue = goodsFilterDataM.name;
    //
    self.goodsFilterM.provinceKey = self.goodsFilterM.provinceValue;
    //
    self.goodsFilterM.areasValue = [NSString stringWithFormat:@"%@、%@",
                                    self.goodsFilterM.provinceValue,
                                    self.goodsFilterM.cityValue];
}

@end

@implementation GoodsFilterBrandDataVM

#pragma mark - Override
- (void)initialize {
    self.title = @"品牌";
    self.goodsFilterType = GoodsFilterBrandType;
}

- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    NSDictionary *dictionary = @{ @"type" : self.type };
    @weakify(self);
    [ZPHTTP wPost:@"/app/shop/productBrand/getBrandList"
       parameters:dictionary
          success:^(NSDictionary *object) {
              @strongify(self);
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  NSArray<GoodsFilterDataM *> *array = [NSArray yy_modelArrayWithClass:GoodsFilterDataM.class
                                                                                  json:data[@"brandList"]];
                  GoodsFilterDataM *model = [GoodsFilterDataM new];
                  model.sId = @"";
                  model.name = @"不限";
                  NSMutableArray *mArray = array.mutableCopy;
                  [mArray insertObject:model
                               atIndex:0];
                  for (GoodsFilterDataM *model in mArray) {
                      if ([self.goodsFilterM.brandKey isEqualToString:model.sId]) {
                          model.isSelectNumber = @YES;
                          break;
                      }
                  }
                  self.array = mArray;
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

- (void)setGoodsFilterDataM:(GoodsFilterDataM * _Nullable)goodsFilterDataM {
    self.goodsFilterM.brandKey = goodsFilterDataM.sId;
    self.goodsFilterM.brandValue = goodsFilterDataM.name;
}

@end

@implementation GoodsFilterSeriesDataVM

#pragma mark - Override
- (void)initialize {
    self.title = @"系列";
    self.goodsFilterType = GoodsFilterSeriesType;
}

- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    [ZPHTTP wPost:@"app/prd/tire/getStandardList"
       parameters:nil
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  NSArray<GoodsFilterStandardM *> *array = [NSArray yy_modelArrayWithClass:GoodsFilterStandardM.class
                                                                                      json:data[@"standardList"]];
                  GoodsFilterStandardM *model = [GoodsFilterStandardM new];
                  model.sId = @"";
                  model.name = @"不限";
                  NSMutableArray *mArray = array.mutableCopy;
                  [mArray insertObject:model
                               atIndex:0];
                  for (GoodsFilterDataM *model in mArray) {
                      if ([self.goodsFilterM.seriesKey isEqualToString:model.sId]) {
                          model.isSelectNumber = @YES;
                          break;
                      }
                  }
                  self.array = mArray;
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

- (void)setGoodsFilterDataM:(GoodsFilterDataM * _Nullable)goodsFilterDataM {
    self.goodsFilterM.seriesKey = goodsFilterDataM.sId;
    self.goodsFilterM.seriesValue = goodsFilterDataM.name;
    self.goodsFilterM.standardArray = ((GoodsFilterStandardM *)goodsFilterDataM).childList;
}

@end

@implementation GoodsFilterStandardDataVM

#pragma mark - Override
- (void)initialize {
    self.title = @"规格";
    self.goodsFilterType = GoodsFilterStandardType;
}

- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    GoodsFilterStandardM *model = [GoodsFilterStandardM new];
    model.sId = @"";
    model.name = @"不限";
    NSMutableArray *mArray = self.goodsFilterM.standardArray.mutableCopy;
    [mArray insertObject:model
                 atIndex:0];
    for (GoodsFilterDataM *model in mArray) {
        if ([self.goodsFilterM.standardKey isEqualToString:model.sId]) {
            model.isSelectNumber = @YES;
            break;
        }
    }
    self.array = mArray;
    success(nil);
    completion();
}

- (void)setGoodsFilterDataM:(GoodsFilterDataM * _Nullable)goodsFilterDataM {
    self.goodsFilterM.standardKey = goodsFilterDataM.sId;
    self.goodsFilterM.standardValue = goodsFilterDataM.name;
}

@end
