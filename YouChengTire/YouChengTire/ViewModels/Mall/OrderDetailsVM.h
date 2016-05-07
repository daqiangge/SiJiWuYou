//
//  OrderDetailsVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@class OrderDetailsM;

@interface OrderDetailsVM : BaseVM

@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, strong) OrderDetailsM *orderDetailsM;

- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion;

@end
