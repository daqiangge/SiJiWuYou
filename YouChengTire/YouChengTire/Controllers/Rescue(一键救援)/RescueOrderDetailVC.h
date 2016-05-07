//
//  RescueOrderDetailVC.h
//  YouChengTire
//
//  Created by Baby on 16/3/23.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVC.h"

typedef enum : NSUInteger {
    RESCUE_FIRST_TYPE,      // 商家抢单详情
    RESCUE_SECOND_TYPE,     // 商家救援订单详情
    RESCUE_THIRD_TYPE,      // 会员救援订单详情未付款
} RESCUETYPE;


@interface RescueOrderDetailVC : BaseVC

@property (nonatomic, assign) RESCUETYPE rescueType;
@property (nonatomic, copy) NSString * sid;
@end
