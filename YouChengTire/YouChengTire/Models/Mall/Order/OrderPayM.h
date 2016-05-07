//
//  OrderPayM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/6.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@interface OrderPayM : BaseM

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *contacts;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *payment;
@property (nonatomic, strong) NSString *price;

@end
