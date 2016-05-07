//
//  LQFahuoListCell.h
//  YouChengTire
//
//  Created by liqiang on 16/4/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQModelGoods.h"

@interface LQFahuoListCell : UITableViewCell
@property (nonatomic, strong) LQModelGoods *model;

+ (LQFahuoListCell *)cellWithTableView:(UITableView *)tableView;

@end
