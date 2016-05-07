//
//  VehicleManagerCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/10.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"

@protocol VehicleManagerCellDelegate <NSObject>

- (void)refreshSelectAllStatus;

@end

@interface VehicleManagerCell : BaseCell

@property (nonatomic, weak) id<VehicleManagerCellDelegate> delegate;

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface VehicleManagerFirstCell : VehicleManagerCell

- (void)selectCell;

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface VehicleManagerSecondCell : VehicleManagerCell

@end
