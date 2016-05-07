//
//  OrderCheckCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"

@protocol OrderCheckCellDelegate <NSObject>

- (void)merchantTelephone;
- (void)refreshPrice;

@end

@interface OrderCheckCell : BaseCell

@property (nonatomic, weak) id<OrderCheckCellDelegate> delegate;

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface OrderCheckFirstCell : OrderCheckCell

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface OrderCheckSecondCell : OrderCheckCell

@end

/*****************************************************************************************
 * 三
 *****************************************************************************************/
@interface OrderCheckThirdCell : OrderCheckCell

@end

/*****************************************************************************************
 * 四
 *****************************************************************************************/
@interface OrderCheckFourthCell : OrderCheckCell

@end

/*****************************************************************************************
 * 五
 *****************************************************************************************/
@interface OrderCheckFifthCell : OrderCheckCell

@end

/*****************************************************************************************
 * 六
 *****************************************************************************************/
@interface OrderCheckSixthCell : OrderCheckCell

@end

/*****************************************************************************************
 * 七
 *****************************************************************************************/
@interface OrderCheckSeventhCell : OrderCheckCell

@end
