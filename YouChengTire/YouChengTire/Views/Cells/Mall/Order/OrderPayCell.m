//
//  OrderPayCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/22.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderPayCell.h"

@implementation OrderPayCell

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface OrderPayFirstCell ()

@property (nonatomic, weak) IBOutlet UILabel *totalPrice;

@end

@implementation OrderPayFirstCell

- (void)configureCell:(NSDictionary *)model {
    _totalPrice.text = [NSString stringWithFormat:@"￥ %@", model[@"kTotalPrice"]];
}

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@implementation OrderPaySecondCell

@end

/*****************************************************************************************
 * 三
 *****************************************************************************************/
@implementation OrderPayThirdCell

@end

/*****************************************************************************************
 * 四
 *****************************************************************************************/
@implementation OrderPayFourthCell

@end
