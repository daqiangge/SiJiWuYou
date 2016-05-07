//
//  ReceiptAddressCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/10.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"

@protocol ReceiptAddressCellDelegate <NSObject>

- (void)refreshSelectAllStatus;

@end

@interface ReceiptAddressCell : BaseCell

@property (nullable, nonatomic, weak) id<ReceiptAddressCellDelegate> delegate;

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface ReceiptAddressFirstCell : ReceiptAddressCell

- (void)selectCell;

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface ReceiptAddressSecondCell : ReceiptAddressCell

@end
