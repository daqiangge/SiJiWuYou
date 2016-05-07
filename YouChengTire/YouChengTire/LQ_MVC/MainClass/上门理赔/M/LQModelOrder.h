//
//  LQModelOrder.h
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReceiptAddressM.h"

@interface LQModelOrder : NSObject

@property (nonatomic, copy) NSString *belongAddress;
@property (nonatomic, copy) NSString *belongId;
@property (nonatomic, copy) NSString *belongName;
@property (nonatomic, copy) NSString *belongPhoto;
@property (nonatomic, copy) NSString *belongPosition;
@property (nonatomic, copy) NSString *cashPrice;
@property (nonatomic, copy) NSString *codPrice;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *freightPrice;
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *isClaimed;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *onlinePrice;
@property (nonatomic, copy) NSString *payment;
@property (nonatomic, copy) NSString *privilegePrice;
@property (nonatomic, copy) NSString *setup;
@property (nonatomic, copy) NSString *setupPrice;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *totalPrice;
@property (nonatomic, strong) ReceiptAddressItemM *address;
@property (nonatomic, strong) NSArray *productList;

@end
