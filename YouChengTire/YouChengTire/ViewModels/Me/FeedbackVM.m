//
//  FeedbackVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "FeedbackVM.h"

@implementation FeedbackVM

#pragma mark - Override
- (void)initialize {
    self.title = @"意见反馈";
    
    _validPlaceholderSignal = [[RACSignal
                                combineLatest:@[
                                                RACObserve(self, content)
                                                ]
                                reduce:^(NSString *content) {
                                    return @(content.length > 0);
                                    
                                }] distinctUntilChanged];
}

#pragma mark - Public
/**
 * 添加用户反馈
 */
- (void)requestSaveFeedback:(void (^)(id object))success
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"mobile" : _mobile,
                                        @"content" : _content
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    
    [ZPHTTP wPost:@"app/prd/feedback/saveFeedback"
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
