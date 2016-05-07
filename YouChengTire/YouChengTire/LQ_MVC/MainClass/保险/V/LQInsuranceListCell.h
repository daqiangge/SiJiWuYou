//
//  LQInsuranceListCell.h
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQModelinsuranceList.h"

@interface LQInsuranceListCell : UITableViewCell

@property (nonatomic, strong) LQModelinsuranceList *model;

+ (LQInsuranceListCell *)cellWithTableView:(UITableView *)tableView;

@end
