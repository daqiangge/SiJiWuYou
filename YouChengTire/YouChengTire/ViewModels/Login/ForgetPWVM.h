//
//  ForgetPWVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/23.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@interface ForgetPWVM : BaseVM

/**
 * 手机号
 */
@property (strong, nonatomic) NSString *mobile;
/**
 * 手机验证码
 */
@property (strong, nonatomic) NSString *verificationCode;
/**
 * 用户密码密文
 */
@property (strong, nonatomic) NSString *password;

/**
 *  加载框的父视图
 */
@property (weak, nonatomic) UIView *loadingSuperV;

/**
 *  使用手机号码，手机验证码修改密码
 *
 *  @param success    success description
 *  @param error      error description
 *  @param failure    failure description
 *  @param completion completion description
 */
- (void)requestUpdatePasswordByMobile:(void (^)(id object))success
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

@end
