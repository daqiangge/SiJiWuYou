//
//  LoginVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/9.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "LoginVM.h"

@implementation LoginVM

#pragma mark - Override
- (void)initialize {
    self.title = @"登录";
    _isFirstNumber = @YES;
}

#pragma mark - Public
- (void)requestLogin:(void (^)(id object))success
               error:(void (^)(NSError *error))error
             failure:(void (^)(NSError *error))failure
          completion:(void (^)(void))completion {
    NSDictionary *parameters = @{
                                 @"loginName" : _loginName,
                                 @"password" : [_password encryptSHA1]
                                 };
    [ZPHTTP wPost:@"app/sys/user/login"
       parameters:parameters
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  UserM *userM = [UserM yy_modelWithDictionary:object[@"data"]];
                  [UserM setUserM:userM];
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

- (void)requestLoginByMobile:(void (^)(id object))success
                       error:(void (^)(NSError *error))error
                     failure:(void (^)(NSError *error))failure
                  completion:(void (^)(void))completion {
    NSDictionary *parameters = @{
                                 @"mobile" : _mobile,
                                 @"verificationCode" : _verificationCode
                                 };
    [ZPHTTP wPost:@"app/sys/user/loginByMobile"
       parameters:parameters
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  UserM *userM = [UserM yy_modelWithDictionary:object[@"data"]];
                  [UserM setUserM:userM];
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

- (void)requestAuthCode:(void (^)(id object))success
                  error:(void (^)(NSError *error))error
                failure:(void (^)(NSError *error))failure
             completion:(void (^)(void))completion {
    NSDictionary *parameters = @{
                                 @"mobile" : _mobile,
                                 };
    [ZPHTTP wPost:@"app/sys/user/getVerificationCode"
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

- (void)switchFirst {
    if (![_isFirstNumber boolValue]) {
        self.isFirstNumber = @(YES);
    }
}

- (void)switchSecond {
    if ([_isFirstNumber boolValue]) {
        self.isFirstNumber = @(NO);
    }
}

@end
