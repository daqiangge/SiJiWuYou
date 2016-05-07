//
//  OrderAddRemarkCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/5/1.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"
#import "BaseV.h"

@interface OrderAddRemarkCell : BaseCell

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface OrderAddRemarkFirstCell : BaseCell

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface OrderAddRemarkSecondCell : BaseCell

@end

/*****************************************************************************************
 * 三
 *****************************************************************************************/
@interface OrderAddRemarkThirdCell : BaseCell

@end

@interface OrderAddRemarkThirdV : BaseV

@property (nullable, nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nullable, nonatomic, strong) UIImage *logoImage;

@end
