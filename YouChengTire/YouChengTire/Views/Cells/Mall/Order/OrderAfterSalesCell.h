//
//  OrderAfterSalesCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/5/1.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"
#import "BaseV.h"

@interface OrderAfterSalesCell : BaseCell

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface OrderAfterSalesFirstCell : BaseCell

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface OrderAfterSalesSecondCell : BaseCell

@end

/*****************************************************************************************
 * 三
 *****************************************************************************************/
@interface OrderAfterSalesThirdCell : BaseCell

@end

@interface OrderAfterSalesThirdV : BaseV

@property (nullable, nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nullable, nonatomic, strong) UIImage *logoImage;

@end

