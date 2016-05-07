//
//  OrderFrameVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderFrameVM.h"
// ViewModels
#import "OrderFrameM.h"

@implementation OrderFrameVM

#pragma mark - Override
- (void)initialize {
    self.title = @"我的订单";
    _tabNumber = @0;
}

#pragma mark - Public
- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    NSString *status = @"";
    switch ([_tabNumber integerValue]) {
        case 0: {
            status = @"";
            _fristCurpage = 1;
        }
            break;
            
        case 1: {
            status = @"1";
            _secondCurpage = 1;
        }
            break;
            
        case 2: {
            status = @"2";
            _thirdCurpage = 1;
        }
            break;
            
        case 3: {
            status = @"3";
            _fourthCurpage = 1;
        }
            break;
            
        case 4: {
            status = @"4";
            _fifthCurpage = 1;
        }
            break;
            
        default:
            break;
    }
    NSMutableDictionary *parameters = @{
                                        @"status" : status,
                                        @"pageNo" : @"1",
                                        @"pageSize" : @"20"
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    @weakify(self);
    [ZPHTTP wPost:@"app/shop/order/getOrderList"
       parameters:parameters
          success:^(NSDictionary *object) {
              @strongify(self);
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  NSArray<OrderFrameM *> *array = [NSArray yy_modelArrayWithClass:OrderFrameM.class
                                                                             json:data[@"orderList"]];
                  NSArray *tempArray = [self configureCell:array];
                  switch ([_tabNumber integerValue]) {
                      case 0: {
                          self.fristArray = tempArray;
                          self.fristIsHasNext = (tempArray.count == 20);
                      }
                          break;
                          
                      case 1: {
                          self.secondArray = tempArray;
                          self.secondIsHasNext = (tempArray.count == 20);
                      }
                          break;
                          
                      case 2: {
                          self.thirdArray = tempArray;
                          self.thirdIsHasNext = (tempArray.count == 20);
                      }
                          break;
                          
                      case 3: {
                          self.fourthArray = tempArray;
                          self.fourthIsHasNext = (tempArray.count == 20);
                      }
                          break;
                          
                      case 4: {
                          self.fifthArray = tempArray;
                          self.fifthIsHasNext = (tempArray.count == 20);
                      }
                          break;
                          
                      default:
                          break;
                  }
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
    NSString *status = @"";
    NSString *curpage = @"2";
    switch ([_tabNumber integerValue]) {
        case 0: {
            status = @"";
            curpage = [NSString stringWithFormat:@"%ld", (long)++_fristCurpage];
        }
            break;
            
        case 1: {
            status = @"1";
            curpage = [NSString stringWithFormat:@"%ld", (long)++_secondCurpage];
        }
            break;
            
        case 2: {
            status = @"2";
            curpage = [NSString stringWithFormat:@"%ld", (long)++_thirdCurpage];
        }
            break;
            
        case 3: {
            status = @"3";
            curpage = [NSString stringWithFormat:@"%ld", (long)++_fourthCurpage];
        }
            break;
            
        case 4: {
            status = @"4";
            curpage = [NSString stringWithFormat:@"%ld", (long)++_fifthCurpage];
        }
            break;
            
        default:
            break;
    }
    NSMutableDictionary *parameters = @{
                                        @"status" : status,
                                        @"pageNo" : curpage,
                                        @"pageSize" : @"20"
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    @weakify(self);
    [ZPHTTP wPost:@"app/shop/order/getOrderList"
       parameters:parameters
          success:^(NSDictionary *object) {
              @strongify(self);
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  NSArray<OrderFrameM *> *array = [NSArray yy_modelArrayWithClass:OrderFrameM.class
                                                                             json:data[@"orderList"]];
                  NSArray *tempArray = [self configureCell:array];
                  switch ([_tabNumber integerValue]) {
                      case 0: {
                          NSMutableArray *mutableArray = self.fristArray.mutableCopy;
                          [mutableArray addObjectsFromArray:tempArray];
                          self.fristArray = mutableArray;
                          self.fristIsHasNext = (tempArray.count == 20);
                      }
                          break;
                          
                      case 1: {
                          NSMutableArray *mutableArray = self.secondArray.mutableCopy;
                          [mutableArray addObjectsFromArray:tempArray];
                          self.secondArray = mutableArray;
                          self.secondIsHasNext = (tempArray.count == 20);
                      }
                          break;
                          
                      case 2: {
                          NSMutableArray *mutableArray = self.thirdArray.mutableCopy;
                          [mutableArray addObjectsFromArray:tempArray];
                          self.thirdArray = mutableArray;
                          self.thirdIsHasNext = (tempArray.count == 20);
                      }
                          break;
                          
                      case 3: {
                          NSMutableArray *mutableArray = self.fourthArray.mutableCopy;
                          [mutableArray addObjectsFromArray:tempArray];
                          self.fourthArray = mutableArray;
                          self.fourthIsHasNext = (tempArray.count == 20);
                      }
                          break;
                          
                      case 4: {
                          NSMutableArray *mutableArray = self.fifthArray.mutableCopy;
                          [mutableArray addObjectsFromArray:tempArray];
                          self.fifthArray = mutableArray;
                          self.fifthIsHasNext = (tempArray.count == 20);
                      }
                          break;
                          
                      default:
                          break;
                  }
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

- (void)requestEnsureProduct:(void (^)(id object))success
                       error:(void (^)(NSError *error))error
                     failure:(void (^)(NSError *error))failure
                  completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"id" : _orderId
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    
    [ZPHTTP wPost:@"/app/shop/order/ensureProduct"
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

- (NSArray *)configureCell:(NSArray *)array {
    NSMutableArray *mSectionArray = @[].mutableCopy;
    for (OrderFrameM *orderFrameM in array) {
        NSMutableArray *mCellArray = @[].mutableCopy;
        NSDictionary *data01 = @{
                                  kType : @"first",
                                  kModel : orderFrameM
                                  };
        [mCellArray addObject:data01];
        for (NSDictionary *dictionary in orderFrameM.productList) {
            NSDictionary *data02 = @{
                                      kType : @"second",
                                      kModel : dictionary
                                      };
            [mCellArray addObject:data02];
        }
        NSDictionary *data03 = @{
                                  kType : @"third",
                                  kModel : orderFrameM
                                  };
        [mCellArray addObject:data03];
        [mSectionArray addObject:mCellArray];
    }
    return mSectionArray;
}

@end
