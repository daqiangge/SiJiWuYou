//
//  ReceiptAddressVC.h
//  YouChengTire
//  收货地址
//  Created by WangZhipeng on 16/1/19.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVC.h"

@class ReceiptAddressItemM;

typedef void(^selectAddress)(ReceiptAddressItemM *model);

@interface ReceiptAddressVC : BaseVC

@property (nonatomic, copy) selectAddress selectAddress;
/**
 *  来自 LQOrderClaimsVC、OrderCheckVC
 */
@property (nonatomic, assign) BOOL isFromLQOrderClaimsVC;

@end