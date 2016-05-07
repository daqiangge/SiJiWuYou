//
//  OrderCheckM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/4.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@class ReceiptAddressItemM;

@interface OrderCheckM : BaseM
/**
 *  收货地址
 */
@property (nullable, nonatomic, strong) ReceiptAddressItemM *address;

@property (nullable, nonatomic, strong) NSArray<NSDictionary *> *productList;
/**
 *  商家编号
 */
@property (nullable, nonatomic, strong) NSString *belongId;
/**
 *  商家名称
 */
@property (nullable, nonatomic, strong) NSString *belongName;
/**
 *  商家地址
 */
@property (nullable, nonatomic, strong) NSString *belongAddress;
/**
 *  现金券
 */
@property (nullable, nonatomic, strong) NSDictionary *cashTicket;
/**
 *  优惠券
 */
@property (nullable, nonatomic, strong) NSDictionary *privilegeTicket;
/**
 *  货到付款金额
 */
@property (nullable, nonatomic, strong) NSString *codPrice;
/**
 *  商品总额
 */
@property (nullable, nonatomic, strong) NSString *productPrice;
/**
 *  运费
 */
@property (nullable, nonatomic, strong) NSString *freightPrice;
/**
 *  安装费
 */
@property (nullable, nonatomic, strong) NSString *setupPrice;
/**
 *  现金卷
 */
@property (nullable, nonatomic, strong) NSString *cashPrice;
/**
 *  优惠劵
 */
@property (nullable, nonatomic, strong) NSString *privilegePrice;
/**
 *  订单总额
 */
@property (nullable, nonatomic, strong) NSString *totalPrice;
/**
 *  在线支付金额
 */
@property (nullable, nonatomic, strong) NSString *onlinePrice;

@end
