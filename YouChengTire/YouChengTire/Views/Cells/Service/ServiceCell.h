//
//  ServiceCell.h
//  YouChengTire
//
//  Created by Baby on 16/2/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"
#import "NearbyPointM.h"

@interface ServiceCell : BaseCell

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/

@protocol ServiceFirstCellDelegate <NSObject>
- (void)callClickedWithIndex:(NSIndexPath *)_index;
@end

@interface ServiceFirstCell : ServiceCell
@property (nonatomic, assign) id<ServiceFirstCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath * index;
- (void)refrashData:(NearbyPointItemM *)_nModel index:(NSIndexPath *)_idex;
@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface ServiceSecondCell : ServiceCell

@end

/*****************************************************************************************
 * 三
 *****************************************************************************************/
@protocol ServiceThirdCellDelegate <NSObject>
- (void)leftBtnClickedWithIndex:(NSIndexPath *)_index;
- (void)rightBtnClickedWithIndex:(NSIndexPath *)_index;
@end

@interface ServiceThirdCell : ServiceCell
@property (nonatomic, assign) id<ServiceThirdCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath * index;
- (void)refrashData:(NSDictionary *)_dic index:(NSIndexPath *)_idex;
@end

/*****************************************************************************************
 * 四
 *****************************************************************************************/
@protocol ServiceFourCellDelegate <NSObject>
- (void)leftBtnClickedWithIndex:(NSIndexPath *)_index;
- (void)rightBtnClickedWithIndex:(NSIndexPath *)_index;
@end
@interface ServiceFourCell : ServiceCell

@property (nonatomic, assign) id<ServiceFourCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath * index;
- (void)refrashData:(NSDictionary *)_dic index:(NSIndexPath *)_idex;
@end