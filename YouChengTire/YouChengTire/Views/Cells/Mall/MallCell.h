//
//  MallCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/12.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"

@protocol MallCellDelegate <NSObject>

- (void)didSelectType:(NSString *)type;

- (void)didSelectSId:(NSString *)sId;

@end

@interface MallCell : BaseCell

@property (nonatomic, weak) IBOutlet id<MallCellDelegate> delegate;

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface MallFirstCell : MallCell

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface MallSecondCell : MallCell

@end

/*****************************************************************************************
 * 三
 *****************************************************************************************/
@interface MallThirdCell : MallCell

@end

/*****************************************************************************************
 * 四
 *****************************************************************************************/
@interface MallFourthCell : MallCell

@end
