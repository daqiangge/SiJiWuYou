//
//  WalletVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@class WalletPointsM;
@class WalletTicketM;

@interface WalletVM : BaseVM

@property (strong, nonatomic) NSNumber *tabNumber;
/**
 *  积分
 */
@property (strong, nonatomic) WalletPointsM *pointsM;
/**
 *  现金
 */
@property (strong, nonatomic) NSArray<WalletTicketM *> *cashTicketMArray;
/**
 *  优惠
 */
@property (strong, nonatomic) NSArray<WalletTicketM *> *discountTicketMArray;

/**
 * 获取用户的积分
 */
- (void)requestGetPoints:(void (^)(id object))success
                   error:(void (^)(NSError *error))error
                 failure:(void (^)(NSError *error))failure
              completion:(void (^)(void))completion;


/**
 * 获取用户的现金卷
 */
- (void)requestGetCashTickets:(void (^)(id object))success
                        error:(void (^)(NSError *error))error
                      failure:(void (^)(NSError *error))failure
                   completion:(void (^)(void))completion;

/**
 * 获取用户的优惠券
 */
- (void)requestGetDiscountTickets:(void (^)(id object))success
                            error:(void (^)(NSError *error))error
                          failure:(void (^)(NSError *error))failure
                       completion:(void (^)(void))completion;

- (BOOL)switchFirst;
- (BOOL)switchSecond;
- (BOOL)switchThird;

@end
