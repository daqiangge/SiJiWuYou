//
//  PersonalDataVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@class UserDetailsM;

@interface PersonalDataVM : BaseVM

@property (nonatomic, strong) UserDetailsM *userDetailsM;
@property (nonatomic, strong) UIImage *fileImage;
@property (nonatomic, strong, readonly) NSNumber *isReloadDataSuccess;

/**
 * 获取个人资料
 */
- (void)requestgetUser:(void (^)(id object))success
                 error:(void (^)(NSError *error))error
               failure:(void (^)(NSError *error))failure
            completion:(void (^)(void))completion;
/**
 * 修改个人资料
 */
- (void)requestUpdateUser:(void (^)(id object))success
                    error:(void (^)(NSError *error))error
                  failure:(void (^)(NSError *error))failure
               completion:(void (^)(void))completion;

/**
 * 修改个人资料带有头像
 */
- (void)requestUpdateUserWithPhoto:(void (^)(id object))success
                             error:(void (^)(NSError *error))error
                           failure:(void (^)(NSError *error))failure
                        completion:(void (^)(void))completion;

@end
