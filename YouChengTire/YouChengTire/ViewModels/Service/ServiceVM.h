//
//  ServiceVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"
#import "NearbyPointM.h"


@interface ServiceVM : BaseVM

/****************************************服务网点************************************************/
// 获取服务网点列表
- (void)requestGetPointList:(void (^)(id object))success
                     data:(NSDictionary *)_params
                    error:(void (^)(NSError *error))error
                  failure:(void (^)(NSError *error))failure
               completion:(void (^)(void))completion;



/****************************************上门安装************************************************/
// 获取上门安装信息列表
- (void)requestGetSetupList:(void (^)(id object))success
                     data:(NSDictionary *)_params
                    error:(void (^)(NSError *error))error
                  failure:(void (^)(NSError *error))failure
               completion:(void (^)(void))completion;

// 获取上门安装信息
- (void)requestGetSetup:(void (^)(id object))success
                       data:(NSDictionary *)_params
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion;

// 确认上门安装
- (void)requestUpdateStatus:(void (^)(id object))success
                       data:(NSDictionary *)_params
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion;

// 删除上门安装
- (void)requestDeleteSetup:(void (^)(id object))success
                      data:(NSDictionary *)_params
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion;

/****************************************上门理赔************************************************/
// 获取上门理赔信息列表
- (void)requestGetClaimList:(void (^)(id object))success
                       data:(NSDictionary *)_params
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion;


// 获取上门理赔信息
- (void)requestGetClaim:(void (^)(id object))success
                       data:(NSDictionary *)_params
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion;


// 新增／修改理赔
- (void)requestSaveClaim:(void (^)(id object))success
                       data:(NSDictionary *)_params
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion;

// 提交身份理赔信息
- (void)requestUpdateClaim:(void (^)(id object))success
                    data:(NSDictionary *)_params
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion;

// 删除上门理赔
- (void)requestDeleteClaim:(void (^)(id object))success
                    data:(NSDictionary *)_params
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion;

@end
