//
//  LQInsuranceDetailCell.h
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQInsuranceDetailCell : UITableViewCell

@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UILabel *namelabel;

+ (LQInsuranceDetailCell *)cellWithTableView:(UITableView *)tableView;

@end
