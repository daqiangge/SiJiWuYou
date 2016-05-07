//
//  GoodsParameterVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsParameterVM.h"
// Models
#import "OrderRemarkM.h"

@implementation GoodsParameterVM

#pragma mark - Override
- (void)initialize {
    self.title = @"商品";
    _isFirstSuccess = @NO;
    _isSecondSuccess = @NO;
}

- (void)requestGetCommentList:(void (^ _Nullable)(id _Nullable object))success
                        error:(void (^ _Nullable)(NSError * _Nullable error))error
                      failure:(void (^ _Nullable)(NSError * _Nullable error))failure
                   completion:(void (^ _Nullable)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"parentId" : _parentId,
                                        @"pageNo" : @"1",
                                        @"pageSize" : @"20"
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    @weakify(self)
    [ZPHTTP wPost:@"/app/shop/comment/getCommentList"
       parameters:parameters
          success:^(NSDictionary *object) {
              @strongify(self)
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  NSArray<OrderRemarkM *> *array = [NSArray yy_modelArrayWithClass:OrderRemarkM.class
                                                                              json:data[@"commentList"]];
                  self.array = array;
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

- (BOOL)switchFirst {
    if ([_tabNumber integerValue] != 1) {
        self.tabNumber = @1;
        return YES;
    }
    return NO;
}

- (BOOL)switchSecond {
    if ([_tabNumber integerValue] != 2) {
        self.tabNumber = @2;
        return YES;
    }
    return NO;
}

- (BOOL)switchThird {
    if ([_tabNumber integerValue] != 3) {
        self.tabNumber = @3;
        return YES;
    }
    return NO;
}

@end
