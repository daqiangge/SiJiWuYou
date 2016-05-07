//
//  OrderCheckVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@class OrderCheckM;
@class WalletTicketM;

@interface OrderCheckVM : BaseVM

@property (nonatomic, strong) OrderCheckM *orderCheckM;

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *totalPrice;

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productCount;
@property (nonatomic, strong) NSString *cartProductIds;
@property (nonatomic, strong) NSString *cartPackageIds;

@property (nonatomic, strong) NSString *payment;
@property (nonatomic, strong) NSString *setup;

@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) NSString *receiptId;
@property (nonatomic, strong) NSString *receiptType;

@property (nonatomic, strong) WalletTicketM *cashTicketM;
@property (nonatomic, strong) WalletTicketM *privilegeTicketM;

- (void)configureCell:(OrderCheckM *)orderCheckM;

- (void)requestSaveOrder:(void (^)(id object))success
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion;

- (void)requestRefreshPrice:(void (^)(id object))success
                      error:(void (^)(NSError *error))error
                    failure:(void (^)(NSError *error))failure
                 completion:(void (^)(void))completion;

@end
