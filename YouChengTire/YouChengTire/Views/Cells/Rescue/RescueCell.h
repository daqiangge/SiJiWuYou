//
//  RescueCell.h
//  YouChengTire
//
//  Created by Baby on 16/3/23.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"
#import "NearbyPointM.h"
#import "RescueM.h"

@interface RescueCell : BaseCell

@end

/*****************************************************************************************
 * 一健救援
 *****************************************************************************************/

@protocol RescueFirstCellDelegate <NSObject>
@optional
- (void)clickButtonWithIndex:(NSIndexPath *)_index;
@end
@interface RescueFirstCell : RescueCell
@property (nonatomic, assign) id<RescueFirstCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath * index;
- (void)refrashData:(RescueItemM *)_rModel idex:(NSIndexPath *)_idex;
@end

/*****************************************************************************************
 * 我的救援
 *****************************************************************************************/

@protocol RescueSecondCellDelegate <NSObject>
@optional
- (void)clickLeftButtonWithIndex:(NSIndexPath *)_index obj:(UIButton *)_btn;
- (void)clickRightButtonWithIndex:(NSIndexPath *)_index obj:(UIButton *)_btn;
@end
@interface RescueSecondCell : RescueCell
@property (nonatomic, assign) id<RescueSecondCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath* index;
- (void)refrashDataWithVIP:(BOOL)_isVIP data:(NSDictionary *)_dic idx:(NSIndexPath *)_idex;
@end

/*****************************************************************************************
 * 自行救援
 *****************************************************************************************/
@protocol RescueThirdDelegate <NSObject>
@optional
- (void)clickButtonWithIndex:(NSIndexPath *)_index;
@end
@interface RescueThirdCell : RescueCell
@property (nonatomic, assign) id<RescueThirdDelegate> delegate;
@property (nonatomic, strong) NSIndexPath * index;
- (void)refrashData:(NearbyPointItemM *)_nModel idex:(NSIndexPath *)_idex;
@end