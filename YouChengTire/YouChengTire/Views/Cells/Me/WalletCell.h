//
//  WalletCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/10.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"

@protocol WalletCellDelegate <NSObject>

- (void)enterMall;

@end

@interface WalletCell : BaseCell

@property (nullable, nonatomic, weak) id<WalletCellDelegate> delegate;

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface WalletFirstCell : WalletCell

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface WalletSecondCell : WalletCell

@end

/*****************************************************************************************
 * 三
 *****************************************************************************************/
@interface WalletThirdCell : WalletCell

@end

/*****************************************************************************************
 * 四
 *****************************************************************************************/
@interface WalletFourthCell : WalletCell

@end