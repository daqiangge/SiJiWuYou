//
//  PayMethodVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@interface PayMethodVM : BaseVM

/**
 *  0 : 在线支付
 *  1 : 货到付款
 */
@property (strong, nonatomic) NSNumber *payMethodTypeNumber;

@end
