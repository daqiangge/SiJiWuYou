//
//  ChangePwdVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@interface ChangePwdVM : BaseVM

@property (strong, nonatomic) NSString *originalPassword;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *confirmPassword;

- (void)requestChangePwd:(void (^)(id object))success
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion;

@end
