//
//  CartCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/11.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"

@class CartCell;

@protocol CartCellDelegate <NSObject>

- (void)didSelectSection:(CartCell *)cell isSelect:(NSNumber *)isSelectNumber;
- (void)didSelectRow:(CartCell *)cell isSelect:(NSNumber *)isSelectNumber;

@end

@interface CartCell : BaseCell

@property (nonatomic, weak) id<CartCellDelegate> delegate;

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface CartFirstCell : CartCell

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface CartSecondCell : CartCell

@end
