//
//  ZPHTTPSessionManager.m
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/9.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "ZPHTTPSessionManager.h"

@implementation ZPHTTPSessionManager

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    // Requset 非JSON
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    // Response JSON
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    // Timte Out
    self.requestSerializer.timeoutInterval = 20;
    return self;
}

#pragma mark - Static Public
+ (instancetype)sharedManager {
    static ZPHTTPSessionManager *sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [[ZPHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kWebService]];
    });
    return sessionManager;
}

#pragma mark - Public
- (void)wGet:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure {
    DLog(@"\n===========GET===========\n%@:\n%@", URLString, parameters);
    [self GET:URLString
   parameters:parameters
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
          DLog(@"\n===========success===========\n%@:\n%@", URLString, responseObject);
          success(responseObject);
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          DLog(@"\n===========error===========\n%@:\n%@", URLString, error);
          failure(error);
      }];
}

- (void)wHead:(NSString *)URLString
   parameters:(id)parameters
      success:(void (^)(id responseObject))success
      failure:(void (^)(NSError *error))failure {
    DLog(@"\n===========HEAD===========\n%@:\n%@", URLString, parameters);
    [self HEAD:URLString
    parameters:parameters
       success:^(NSURLSessionDataTask * _Nonnull task) {
           DLog(@"\n===========success===========\n%@:", URLString);
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           DLog(@"\n===========error===========\n%@:\n%@", URLString, error);
           failure(error);
       }];
}

- (void)wPost:(NSString *)URLString
   parameters:(id)parameters
      success:(void (^)(id responseObject))success
      failure:(void (^)(NSError *error))failure {
    DLog(@"\n===========POST===========\n%@:\n%@", URLString, parameters);
    [self POST:URLString
    parameters:parameters
       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
           DLog(@"\n===========success===========\n%@:\n%@", URLString, responseObject);
           success(responseObject);
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           DLog(@"\n===========error===========\n%@:\n%@", URLString, error);
           failure(error);
       }];
}

- (void)wPut:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure {
    DLog(@"\n===========PUT===========\n%@:\n%@", URLString, parameters);
    [self PUT:URLString
   parameters:parameters
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
          DLog(@"\n===========success===========\n%@:\n%@", URLString, responseObject);
          success(responseObject);
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          DLog(@"\n===========error===========\n%@:\n%@", URLString, error);
          failure(error);
      }];
}

- (void)wPatch:(NSString *)URLString
    parameters:(id)parameters
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure {
    DLog(@"\n===========PATCH===========\n%@:\n%@", URLString, parameters);
    [self PATCH:URLString
     parameters:parameters
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            DLog(@"\n===========success===========\n%@:\n%@", URLString, responseObject);
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DLog(@"\n===========error===========\n%@:\n%@", URLString, error);
            failure(error);
        }];
}

- (void)wDelete:(NSString *)URLString
     parameters:(id)parameters
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSError *error))failure {
    DLog(@"\n===========DELETE===========\n%@:\n%@", URLString, parameters);
    [self DELETE:URLString
      parameters:parameters
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
             DLog(@"\n===========success===========\n%@:\n%@", URLString, responseObject);
             success(responseObject);
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             DLog(@"\n===========error===========\n%@:\n%@", URLString, error);
             failure(error);
         }];
}

- (void)wPost:(NSString *)URLString
   parameters:(id)parameters
     fileInfo:(NSDictionary *)fileInfo
      success:(void (^)(NSDictionary *object))success
      failure:(void (^)(NSError *error))failure {
    DLog(@"\n===========PUT===========\n%@:\n%@", URLString, parameters);
    [self POST:URLString
    parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (fileInfo) {
            [formData appendPartWithFileData:fileInfo[@"kFileData"]
                                        name:fileInfo[@"kName"]
                                    fileName:fileInfo[@"kFileName"]
                                    mimeType:fileInfo[@"kMimeType"]];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        DLog(@"\n===========success===========\n%@:\n%@", URLString, responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"\n===========error===========\n%@:\n%@", URLString, error);
        failure(error);
    }];
}

- (void)wPost:(NSString *)URLString
   parameters:(id)parameters
    fileInfos:(NSArray *)fileInfos
      success:(void (^)(NSDictionary *object))success
      failure:(void (^)(NSError *error))failure {
    DLog(@"\n===========PUT===========\n%@:\n%@", URLString, parameters);
    [self POST:URLString
    parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSDictionary *fileInfo in fileInfos) {
            if (fileInfo) {
                [formData appendPartWithFileData:fileInfo[@"kFileData"]
                                            name:fileInfo[@"kName"]
                                        fileName:fileInfo[@"kFileName"]
                                        mimeType:fileInfo[@"kMimeType"]];
            }
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        DLog(@"\n===========success===========\n%@:\n%@", URLString, responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"\n===========error===========\n%@:\n%@", URLString, error);
        failure(error);
    }];
}

- (void)LQPost:(NSString *)URLString
    parameters:(id)parameters
      fileInfo:(NSMutableArray *)fileInfos
       success:(void (^)(NSDictionary *))success
       failure:(void (^)(NSError *))failure
{
    [self POST:URLString
    parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSDictionary *fileInfo in fileInfos)
        {
            if (fileInfo) {
                [formData appendPartWithFileData:fileInfo[@"kFileData"]
                                            name:fileInfo[@"kName"]
                                        fileName:fileInfo[@"kFileName"]
                                        mimeType:fileInfo[@"kMimeType"]];
            }
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        DLog(@"\n===========success===========\n%@:\n%@", URLString, responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"\n===========error===========\n%@:\n%@", URLString, error);
        failure(error);
    }];
}

@end
