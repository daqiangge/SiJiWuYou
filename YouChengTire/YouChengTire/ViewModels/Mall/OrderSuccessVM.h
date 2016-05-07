//
//  OrderSuccessVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/21.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@interface OrderSuccessVM : BaseVM

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *totalPrice;

@end
