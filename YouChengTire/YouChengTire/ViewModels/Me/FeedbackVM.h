//
//  FeedbackVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@interface FeedbackVM : BaseVM

/**
 * 意见反馈
 */
@property (strong, nonatomic) NSString *content;
/**
 * 联系方式
 */
@property (strong, nonatomic) NSString *mobile;

@property (nonatomic, strong, readonly) RACSignal *validPlaceholderSignal;

/**
 * 添加用户反馈
 */
- (void)requestSaveFeedback:(void (^)(id object))success
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion;

@end
