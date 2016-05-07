//
//  HomeCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"

@protocol HomeCellDelegate <NSObject>

- (void)didSelectFirstCell:(id)sender;
- (void)didSelectSecondCell:(id)sender;
- (void)didSelectThirdCell:(id)sender;
- (void)didSelectFourthCell:(id)sender;

@end

@interface HomeCell : BaseCell

@property (weak, nonatomic) id<HomeCellDelegate> delegate;

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface HomeFirstCell : HomeCell

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface HomeSecondCell : HomeCell

@end

/*****************************************************************************************
 * 三
 *****************************************************************************************/
@interface HomeThirdCell : HomeCell

@end

/*****************************************************************************************
 * 四
 *****************************************************************************************/
@interface HomeFourthCell : HomeCell

@end

/*****************************************************************************************
 * 五
 *****************************************************************************************/
@interface HomeFifthCell : HomeCell

@end

/*****************************************************************************************
 * 六
 *****************************************************************************************/
@interface HomeSixthCell : HomeCell

@end

