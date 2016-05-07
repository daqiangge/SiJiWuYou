//
//  OrderDetailsM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/6.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@class ReceiptAddressItemM;

@interface OrderDetailsM : BaseM

@property (nonatomic, strong) NSString *sId;

@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) ReceiptAddressItemM *address;

@property (nonatomic, strong) NSString *belongName;

@property (nonatomic, strong) NSArray<NSDictionary *> *productList;

@property (nonatomic, strong) NSString *payment;
@property (nonatomic, strong) NSString *setup;
@property (nonatomic, strong) NSDictionary *receipt;

@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) NSString *productPrice;
@property (nonatomic, strong) NSString *freightPrice;
@property (nonatomic, strong) NSString *setupPrice;
@property (nonatomic, strong) NSString *cashPrice;
@property (nonatomic, strong) NSString *privilegePrice;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSString *onlinePrice;

@property (nonatomic, strong) NSString *createDate;

@end

@interface OrderDetailsProductM : BaseM

@property (nonatomic, strong) NSString *sId;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;

@end
