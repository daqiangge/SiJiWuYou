//
//  RegisterVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/23.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@interface RegisterVM : BaseVM

/**
 * 手机号码
 */
@property (strong, nonatomic) NSString *mobile;
/**
 * 密码
 */
@property (strong, nonatomic) NSString *password;
/**
 * 手机验证码
 */
@property (strong, nonatomic) NSString *verificationCode;
/**
 * 邀请码
 */
@property (strong, nonatomic) NSString *inviteCode;

/**
 *  加载框的父视图
 */
@property (weak, nonatomic) UIView *loadingSuperV;

/**
 *  用户注册
 *
 *  @param success    success description
 *  @param error      error description
 *  @param failure    failure description
 *  @param completion completion description
 */
- (void)requestSave:(void (^)(id object))success
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
