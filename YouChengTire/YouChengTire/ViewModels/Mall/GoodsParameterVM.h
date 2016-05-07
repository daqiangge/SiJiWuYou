//
//  GoodsParameterVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@interface GoodsParameterVM : BaseVM

@property (nullable ,nonatomic, strong) NSNumber *tabNumber;

/**
 *  图文详情
 */
@property (nullable ,nonatomic, strong) NSString *appPictureDescUrl;
/**
 *  产品参数
 */
@property (nullable ,nonatomic, strong) NSString *parametersUrl;
/**
 *  用户评论
 */
@property (nullable ,nonatomic, strong) NSString *parentId;

@property (nullable ,nonatomic, strong) NSNumber *isFirstSuccess;
@property (nullable ,nonatomic, strong) NSNumber *isSecondSuccess;

- (void)requestGetCommentList:(void (^ _Nullable)(id _Nullable object))success
                        error:(void (^ _Nullable)(NSError * _Nullable error))error
                      failure:(void (^ _Nullable)(NSError * _Nullable error))failure
                   completion:(void (^ _Nullable)(void))completion;

- (BOOL)switchFirst;
- (BOOL)switchSecond;
- (BOOL)switchThird;

@end
