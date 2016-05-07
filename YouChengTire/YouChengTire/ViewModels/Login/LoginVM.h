//
//  LoginVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/9.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@interface LoginVM : BaseVM

/**
 * 登录名
 */
@property (strong, nonatomic) NSString *loginName;
/**
 * 密码
 */
@property (strong, nonatomic) NSString *password;
/**
 * 手机号码
 */
@property (strong, nonatomic) NSString *mobile;
/**
 * 手机验证码
 */
@property (strong, nonatomic) NSString *verificationCode;

@property (strong, nonatomic) NSNumber *isFirstNumber;
/**
 *  加载框的父视图
 */
@property (weak, nonatomic) UIView *loadingSuperV;

/**
 *  使用用户名/手机号码，密码登录
 *
 *  @param success    success description
 *  @param error      error description
 *  @param failure    failure description
 *  @param completion completion description
 */
- (void)requestLogin:(void (^)(id object))success
               error:(void (^)(NSError *error))error
             failure:(void (^)(NSError *error))failure
          completion:(void (^)(void))completion;

/**
 *  使用手机号码，手机验证码登录
 *
 *  @param success    success description
 *  @param error      error description
 *  @param failure    failure description
 *  @param completion completion description
 */
- (void)requestLoginByMobile:(void (^)(id object))success
                       error:(void (^)(NSError *error))error
                     failure:(void (^)(NSError *error))failure
                  completion:(void (^)(void))completion;

/**
 *  获取手机验证码
 *
 *  @param success    success description
 *  @param error      error description
 *  @param failure    failure description
 *  @param completion completion description
 */
- (void)requestAuthCode:(void (^)(id object))success
                  error:(void (^)(NSError *error))error
                failure:(void (^)(NSError *error))failure
             completion:(void (^)(void))completion;

- (void)switchFirst;
- (void)switchSecond;

@end
