//
//  WalletM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@class WalletPointsM;
@class WalletTicketM;
@class WalletBelongM;

@interface WalletM : BaseM

@property (nullable, nonatomic, strong) WalletPointsM *pointsM;
@property (nullable, nonatomic, strong) NSArray<WalletTicketM *> *ticketMArray;

@end


@interface WalletPointsM : BaseM
/**
 * 当前可使用的积分
 */
@property (nullable, nonatomic, strong) NSString *currentPoint;
/**
 * 已使用的积分
 */
@property (nullable, nonatomic, strong) NSString *usedPoint;
/**
 * 已过期的积分
 */
@property (nullable, nonatomic, strong) NSString *expiredPoint;

@end

@interface WalletTicketM : BaseM

/**
 *  券编号
 */
@property (nullable, nonatomic, copy) NSString *sId;
/**
 *  积分 : 1,
 *  现金卷 : 2,
 *  优惠券 : 3
 */
@property (nullable, nonatomic, copy) NSString *type;
/**
 *  0 : 代表可以使用，
 *  1 : 代表已使用，
 *  2 : 代表已过期
 */
@property (nullable, nonatomic, copy) NSString *status;
/**
 *  数量，就是劵的面值
 */
@property (nullable, nonatomic, copy) NSString *amount;
/**
 *  该劵的使用条件，就是消费满多少才能用
 */
@property (nullable, nonatomic, copy) NSString *usedAmount;
/**
 *  有效期开始时间
 */
@property (nullable, nonatomic, copy) NSString *fromDate;
/**
 *  有效期结束时间
 */
@property (nullable, nonatomic, copy) NSString *endDate;
/**
 *  发券者对象
 */
@property (nullable, nonatomic, copy) WalletBelongM *belong;

@end

@interface WalletBelongM : BaseM

@property (nullable, nonatomic, copy) NSString *appPhoto;

@property (nullable, nonatomic, copy) NSString *name;

@end
