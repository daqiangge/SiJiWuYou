//
//  LQShop_RobOrderDetailCell.h
//  YouChengTire
//
//  Created by liqiang on 16/4/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQModelRescueDetail.h"

@interface LQShop_RobOrderDetailCell : UITableViewCell

@property (nonatomic, strong) LQModelRescueDetail *modelRescueDetail;

+ (LQShop_RobOrderDetailCell *)cellWithTableView:(UITableView *)tableView;

@end
