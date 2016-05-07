//
//  ForgetPWVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/23.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "ForgetPWVM.h"

@implementation ForgetPWVM

#pragma mark - Override
- (void)initialize {
    [super initialize];
    self.title = @"找回密码";
}

#pragma mark - Public
- (void)requestUpdatePasswordByMobile:(void (^)(id object))success
                                error:(void (^)(NSError *error))error
                              failure:(void (^)(NSError *error))failure
                           completion:(void (^)(void))completion {
    NSDictionary *parameters = @{
                                 @"mobile" : _mobile,
                                 @"verificationCode" : _verificationCode,
                                 @"password" : [_password encryptSHA1]
                                 };
    [ZPHTTP wPost:@"app/sys/user/updatePasswordByMobile"
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

@end
