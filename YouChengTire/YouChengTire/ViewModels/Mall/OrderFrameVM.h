//
//  OrderFrameVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@interface OrderFrameVM : BaseVM

@property (strong, nonatomic) NSNumber *tabNumber;

@property (strong, nonatomic) NSString *orderId;

@property (nonatomic, strong) NSArray<NSArray *> *fristArray;
@property (nonatomic, strong) NSArray<NSArray *> *secondArray;
@property (nonatomic, strong) NSArray<NSArray *> *thirdArray;
@property (nonatomic, strong) NSArray<NSArray *> *fourthArray;
@property (nonatomic, strong) NSArray<NSArray *> *fifthArray;

@property (nonatomic, assign) NSInteger fristCurpage;
@property (nonatomic, assign) NSInteger secondCurpage;
@property (nonatomic, assign) NSInteger thirdCurpage;
@property (nonatomic, assign) NSInteger fourthCurpage;
@property (nonatomic, assign) NSInteger fifthCurpage;

@property (assign, nonatomic, readwrite) BOOL fristIsHasNext;
@property (assign, nonatomic, readwrite) BOOL secondIsHasNext;
@property (assign, nonatomic, readwrite) BOOL thirdIsHasNext;
@property (assign, nonatomic, readwrite) BOOL fourthIsHasNext;
@property (assign, nonatomic, readwrite) BOOL fifthIsHasNext;

- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion;

- (void)requestLoadMoreData:(void (^)(id object))success
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion;

- (void)requestEnsureProduct:(void (^)(id object))success
                       error:(void (^)(NSError *error))error
                     failure:(void (^)(NSError *error))failure
                  completion:(void (^)(void))completion;

@end
