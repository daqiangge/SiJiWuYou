//
//  OrderSuccessCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/21.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderSuccessCell.h"

@interface OrderSuccessCell ()

/**
 *  查看订单
 */
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
/**
 *  继续购物
 */
@property (weak, nonatomic) IBOutlet UIButton *secondButton;

@end

@implementation OrderSuccessCell

- (void)awakeFromNib {
    // Initialization code
    [self configureButton];
}

- (void)configureButton {
    [self configureBorder:_firstButton];
    [self configureBorder:_secondButton];
}

- (void)configureBorder:(UIView *)view {
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 6;
    view.layer.borderColor = [UIColor clearColor].CGColor;
}

@end
