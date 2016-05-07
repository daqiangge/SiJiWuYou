//
//  OrderPayVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/22.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@class OrderPayM;

@interface OrderPayVM : BaseVM

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *totalPrice;

@property (nonatomic, weak) UIViewController *masterVC;

@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *orderInfo;

@property (nonatomic, strong) OrderPayM *orderPayM;

- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion;

- (void)dataArray;

@end
