//
//  ZPHTTPSessionManager.h
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/9.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#define ZPHTTP [ZPHTTPSessionManager sharedManager]

@interface ZPHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

- (void)wGet:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

- (void)wHead:(NSString *)URLString
   parameters:(id)parameters
      success:(void (^)(id responseObject))success
      failure:(void (^)(NSError *error))failure;

- (void)wPost:(NSString *)URLString
   parameters:(id)parameters
      success:(void (^)(id responseObject))success
      failure:(void (^)(NSError *error))failure;

- (void)wPut:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

- (void)wPatch:(NSString *)URLString
    parameters:(id)parameters
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure;

- (void)wDelete:(NSString *)URLString
     parameters:(id)parameters
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSError *error))failure;

- (void)wPost:(NSString *)URLString
   parameters:(id)parameters
     fileInfo:(NSDictionary *)fileInfo
      success:(void (^)(NSDictionary *object))success
      failure:(void (^)(NSError *error))failure;

- (void)wPost:(NSString *)URLString
   parameters:(id)parameters
    fileInfos:(NSArray *)fileInfos
      success:(void (^)(NSDictionary *object))success
      failure:(void (^)(NSError *error))failure;

- (void)LQPost:(NSString *)URLString
    parameters:(id)parameters
      fileInfo:(NSMutableArray *)fileInfos
       success:(void (^)(NSDictionary *))success
       failure:(void (^)(NSError *))failure;

@end
