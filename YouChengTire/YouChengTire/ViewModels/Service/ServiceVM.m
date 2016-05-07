//
//  ServiceVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "ServiceVM.h"

@implementation ServiceVM

/****************************************服务网点************************************************/
// 获取服务网点列表
- (void)requestGetPointList:(void (^)(id object))success
                       data:(NSDictionary *)_params
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/prd/point/getPointList"
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



/****************************************上门安装************************************************/
// 获取上门安装信息列表
- (void)requestGetSetupList:(void (^)(id object))success
                       data:(NSDictionary *)_params
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/service/setup/getSetupList"
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

// 获取上门安装信息
- (void)requestGetSetup:(void (^)(id object))success
                   data:(NSDictionary *)_params
                  error:(void (^)(NSError *error))error
                failure:(void (^)(NSError *error))failure
             completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/service/setup/getSetup"
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

// 确认上门安装
- (void)requestUpdateStatus:(void (^)(id object))success
                       data:(NSDictionary *)_params
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/service/setup/updateStatus"
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

// 删除上门安装
- (void)requestDeleteSetup:(void (^)(id object))success
                      data:(NSDictionary *)_params
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/service/setup/deleteSetup"
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

/****************************************上门理赔************************************************/
// 获取上门理赔信息列表
- (void)requestGetClaimList:(void (^)(id object))success
                       data:(NSDictionary *)_params
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/service/claim/getClaimList"
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


// 获取上门理赔信息
- (void)requestGetClaim:(void (^)(id object))success
                   data:(NSDictionary *)_params
                  error:(void (^)(NSError *error))error
                failure:(void (^)(NSError *error))failure
             completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/service/claim/getClaim"
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


// 新增／修改理赔
- (void)requestSaveClaim:(void (^)(id object))success
                    data:(NSDictionary *)_params
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/service/claim/saveClaim"
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

// 提交身份理赔信息
- (void)requestUpdateClaim:(void (^)(id object))success
                      data:(NSDictionary *)_params
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/service/claim/updateClaim"
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

// 删除上门理赔
- (void)requestDeleteClaim:(void (^)(id object))success
                      data:(NSDictionary *)_params
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion{
    [ZPHTTP wPost:@"/app/service/claim/deleteClaim"
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
