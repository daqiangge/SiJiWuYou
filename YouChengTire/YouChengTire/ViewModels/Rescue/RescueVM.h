//
//  RescueVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

#import "NearbyPointM.h"
#import "UserPointM.h"
#import "RescueM.h"


@interface RescueVM : BaseVM

/****************************************救援信息************************************************/
// 添加救援
- (void)requestSaveRescue:(void (^)(id object))success
                     data:(NSDictionary *)_params
                    error:(void (^)(NSError *error))error
                  failure:(void (^)(NSError *error))failure
               completion:(void (^)(void))completion;

// 救援信息
- (void)requestGetRescue:(void (^)(id object))success
                    data:(NSDictionary *)_params
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion;

/****************************************自行协商************************************************/

// 获取附近网点列表
- (void)requestGetNearbyPointList:(void (^)(id object))success
                             data:(NSDictionary *)_params
                            error:(void (^)(NSError *error))error
                          failure:(void (^)(NSError *error))failure
                       completion:(void (^)(void))completion;

// 获取常用网点列表
- (void)requestGetUsedPointList:(void (^)(id object))success
                           data:(NSDictionary *)_params
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion;

// 确定救援商家
- (void)requestEnsurePoint:(void (^)(id object))success
                      data:(NSDictionary *)_params
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion;


/****************************************发布救援************************************************/

// 获取网点列表
- (void)requestGetPointListByDistance:(void (^)(id object))success
                                 data:(NSDictionary *)_params
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion;

// 发布救援
- (void)requestPublishRescue:(void (^)(id object))success
                        data:(NSDictionary *)_params
                                error:(void (^)(NSError *error))error
                              failure:(void (^)(NSError *error))failure
                           completion:(void (^)(void))completion;

/****************************************救援订单************************************************/

// 获取救援订单列表
- (void)requestGetRescueList:(void (^)(id object))success
                        data:(NSDictionary *)_params
                    error:(void (^)(NSError *error))error
                  failure:(void (^)(NSError *error))failure
               completion:(void (^)(void))completion;

// 更新救援状态
- (void)requestUpdateStatus:(void (^)(id object))success
                       data:(NSDictionary *)_params
                       error:(void (^)(NSError *error))error
                     failure:(void (^)(NSError *error))failure
                  completion:(void (^)(void))completion;

// 提交订单
- (void)requestSubmitRescue:(void (^)(id object))success
                       data:(NSDictionary *)_params
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion;

// 取消订单
- (void)requestCancelRescue:(void (^)(id object))success
                       data:(NSDictionary *)_params
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion;

// 删除订单
- (void)requestDeleteRescue:(void (^)(id object))success
                       data:(NSDictionary *)_params
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion;

// 现金支付
- (void)requestCashPayment:(void (^)(id object))success
                      data:(NSDictionary *)_params
                       error:(void (^)(NSError *error))error
                     failure:(void (^)(NSError *error))failure
                  completion:(void (^)(void))completion;

// 获取支付订单信息(在线支付)
- (void)requestGetRescueInfo:(void (^)(id object))success
                        data:(NSDictionary *)_params
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion;

/****************************************商家救援************************************************/

// 获取发布救援列表
- (void)requestGetPublishRescueList:(void (^)(id object))success
                        data:(NSDictionary *)_params
                       error:(void (^)(NSError *error))error
                     failure:(void (^)(NSError *error))failure
                  completion:(void (^)(void))completion;

// 抢单
- (void)requestRushRescue:(void (^)(id object))success
                        data:(NSDictionary *)_params
                       error:(void (^)(NSError *error))error
                     failure:(void (^)(NSError *error))failure
                  completion:(void (^)(void))completion;

// 更新救援价格
- (void)requestUpdateRescuePrice:(void (^)(id object))success
                        data:(NSDictionary *)_params
                       error:(void (^)(NSError *error))error
                     failure:(void (^)(NSError *error))failure
                  completion:(void (^)(void))completion;

// 获取商家救援列表
- (void)requestGetPointRescueList:(void (^)(id object))success
                        data:(NSDictionary *)_params
                       error:(void (^)(NSError *error))error
                     failure:(void (^)(NSError *error))failure
                  completion:(void (^)(void))completion;


@end
