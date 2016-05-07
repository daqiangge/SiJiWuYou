//
//  OrderAddRemarkVM.h
//  YouChengTire
//  商品添加评论
//  Created by WangZhipeng on 16/4/25.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"
// Models
#import "OrderFrameM.h"

@interface OrderAddRemarkVM : BaseVM

@property (nonnull, nonatomic, strong) OrderFrameM *orderFrameM;

@property (nullable, nonatomic, strong) NSString *score;
@property (nullable, nonatomic, strong) NSString *remark;
@property (nullable, nonatomic, strong) NSMutableArray<UIImage *> *imageMutableArray;
@property (nullable, nonatomic, strong, readonly) RACSignal *validPlaceholderSignal;

- (void)requestsaveComment:(void (^ _Nullable)(id _Nullable object))success
                     error:(void (^ _Nullable)(NSError * _Nullable error))error
                   failure:(void (^ _Nullable)(NSError * _Nullable error))failure
                completion:(void (^ _Nullable)(void))completion;

- (void)requestDeleteComment:(void (^ _Nullable)(id _Nullable object))success
                       error:(void (^ _Nullable)(NSError * _Nullable error))error
                     failure:(void (^ _Nullable)(NSError * _Nullable error))failure
                  completion:(void (^ _Nullable)(void))completion;

@end
