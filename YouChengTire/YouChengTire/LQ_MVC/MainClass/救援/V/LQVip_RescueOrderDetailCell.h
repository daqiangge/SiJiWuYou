//
//  LQVip_RescueOrderDetailCell.h
//  YouChengTire
//
//  Created by liqiang on 16/4/23.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQModelRescueDetail.h"

@interface LQVip_RescueOrderDetailCell : UITableViewCell

@property (nonatomic, strong) LQModelRescueDetail *modelRescueDetail;

+ (LQVip_RescueOrderDetailCell *)cellWithTableView:(UITableView *)tableView;

@end
