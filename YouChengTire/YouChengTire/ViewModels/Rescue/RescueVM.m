//
//  RescueVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "RescueVM.h"

@implementation RescueVM

/****************************************救援信息************************************************/
// 添加救援
- (void)requestSaveRescue:(void (^)(id object))success
                     data:(NSDictionary *)_params
                    error:(void (^)(NSError *error))error
                  failure:(void (^)(NSError *error))failure
               completion:(void (^)(void))completion{
    
    [ZPHTTP wPost:@"/app/rescue/rescue/saveRescue" parameters:_params fileInfo:nil success:^(NSDictionary *object) {
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
    
//    [ZPHTTP wPost:@"/app/rescue/rescue/saveRescue"
//       parameters:_params
//          success:^(NSDictionary *object) {
//              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
//                  success(nil);
//                  completion();
//              }
//              else {
//                  NSInteger errnoInteger = [object[@"msgCode"] integerValue];
//                  NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : object[@"msg"] };
//                  NSError *uError = [NSError errorWithDomain:@"ZPCustom"
//                                                        code:errnoInteger
//                                                    userInfo:userInfo];
//                  error(uError);
//                  completion();
//              }
//          } failure:^(NSError *error) {
//              failure(error);
//              completion();
//          }];
}

// 救援信息
- (void)requestGetRescue:(void (^)(id object))success
                    data:(NSDictionary *)_params
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/rescue/rescue/getRescue"
       parameters:_params
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  success(object[@"data"]);
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

/****************************************自行协商************************************************/

// 获取附近网点列表
- (void)requestGetNearbyPointList:(void (^)(id object))success
                             data:(NSDictionary *)_params
                            error:(void (^)(NSError *error))error
                          failure:(void (^)(NSError *error))failure
                       completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/rescue/rescue/getNearbyPointList"
       parameters:_params
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NearbyPointM *nearbyPointM = [NearbyPointM yy_modelWithDictionary:object[@"data"]];
                  success(nearbyPointM);
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

// 获取常用网点列表
- (void)requestGetUsedPointList:(void (^)(id object))success
                           data:(NSDictionary *)_params
                          error:(void (^)(NSError *error))error
                        failure:(void (^)(NSError *error))failure
                     completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/rescue/rescue/getUsedPointList"
       parameters:_params
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NearbyPointM *userPointM = [NearbyPointM yy_modelWithDictionary:object[@"data"]];
                  success(userPointM);
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

// 确定救援商家
- (void)requestEnsurePoint:(void (^)(id object))success
                      data:(NSDictionary *)_params
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/rescue/rescue/ensurePoint"
       parameters:_params
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  success(object[@"msg"]);
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


/****************************************发布救援************************************************/

// 获取网点列表
- (void)requestGetPointListByDistance:(void (^)(id object))success
                                 data:(NSDictionary *)_params
                                error:(void (^)(NSError *error))error
                              failure:(void (^)(NSError *error))failure
                           completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/rescue/rescue/getPointListByDistance"
       parameters:_params
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

// 发布救援
- (void)requestPublishRescue:(void (^)(id object))success
                        data:(NSDictionary *)_params
                       error:(void (^)(NSError *error))error
                     failure:(void (^)(NSError *error))failure
                  completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/rescue/rescue/publishRescue"
       parameters:_params
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

/****************************************救援订单************************************************/

// 获取救援订单列表
- (void)requestGetRescueList:(void (^)(id object))success
                        data:(NSDictionary *)_params
                       error:(void (^)(NSError *error))error
                     failure:(void (^)(NSError *error))failure
                  completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/rescue/rescue/getRescueList"
       parameters:_params
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  success(object[@"data"]);
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

// 更新救援状态
- (void)requestUpdateStatus:(void (^)(id object))success
                       data:(NSDictionary *)_params
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/rescue/rescue/updateStatus"
       parameters:_params
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

// 提交订单
- (void)requestSubmitRescue:(void (^)(id object))success
                       data:(NSDictionary *)_params
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/rescue/rescue/submitRescue"
       parameters:_params
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

// 取消订单
- (void)requestCancelRescue:(void (^)(id object))success
                       data:(NSDictionary *)_params
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/rescue/rescue/cancelRescue"
       parameters:_params
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

// 删除订单
- (void)requestDeleteRescue:(void (^)(id object))success
                       data:(NSDictionary *)_params
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/rescue/rescue/deleteRescue"
       parameters:_params
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

// 现金支付
- (void)requestCashPayment:(void (^)(id object))success
                      data:(NSDictionary *)_params
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/rescue/rescue/cashPayment"
       parameters:_params
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

// 获取支付订单信息
- (void)requestGetRescueInfo:(void (^)(id object))success
                        data:(NSDictionary *)_params
                       error:(void (^)(NSError *error))error
                     failure:(void (^)(NSError *error))failure
                  completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/shop/payment/getRescueInfo"
       parameters:_params
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


/****************************************商家救援************************************************/

// 获取发布救援列表
- (void)requestGetPublishRescueList:(void (^)(id object))success
                               data:(NSDictionary *)_params
                              error:(void (^)(NSError *error))error
                            failure:(void (^)(NSError *error))failure
                         completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/rescue/rescue/getPublishRescueList"
       parameters:_params
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  RescueM *rescueM = [RescueM yy_modelWithDictionary:object[@"data"]];
                  NSLog(@"data == %@",rescueM);
                  success(rescueM);
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

// 抢单
- (void)requestRushRescue:(void (^)(id object))success
                     data:(NSDictionary *)_params
                    error:(void (^)(NSError *error))error
                  failure:(void (^)(NSError *error))failure
               completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/rescue/rescue/rushRescue"
       parameters:_params
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  success(object[@"msg"]);
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

// 更新救援价格
- (void)requestUpdateRescuePrice:(void (^)(id object))success
                            data:(NSDictionary *)_params
                           error:(void (^)(NSError *error))error
                         failure:(void (^)(NSError *error))failure
                      completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/rescue/rescue/updateRescuePrice"
       parameters:_params
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

// 获取商家救援列表
- (void)requestGetPointRescueList:(void (^)(id object))success
                             data:(NSDictionary *)_params
                            error:(void (^)(NSError *error))error
                          failure:(void (^)(NSError *error))failure
                       completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/rescue/rescue/getPointRescueList"
       parameters:_params
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
