//
//  OrderFrameM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/5.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@class OrderFrameProductM;

@interface OrderFrameM : BaseM

@property (nonatomic, strong) NSString *sId;
@property (nonatomic, strong) NSString *belongId;
@property (nonatomic, strong) NSString *belongName;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *isClaimed;

@property (nonatomic, strong) NSString *codPrice;
@property (nonatomic, strong) NSString *productPrice;
@property (nonatomic, strong) NSString *freightPrice;
@property (nonatomic, strong) NSString *setupPrice;
@property (nonatomic, strong) NSString *cashPrice;
@property (nonatomic, strong) NSString *privilegePrice;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSString *onlinePrice;

@property (nonatomic, strong) NSArray<NSDictionary *> *productList;
@property (nonatomic, strong) NSArray<NSDictionary *> *packageList;

@end

@interface OrderFrameProductM : BaseM

@property (nonatomic, strong) NSString *sId;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *oldPrice;

@end
