//
//  OrderTicketCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"

@interface OrderTicketCell : BaseCell

@end

/*****************************************************************************************
 * 现金券
 *****************************************************************************************/
@interface OrderCurrencyTicketCell : OrderTicketCell

@end

/*****************************************************************************************
 * 优惠券
 *****************************************************************************************/
@interface OrderDiscountTicketCell : OrderTicketCell

@end
