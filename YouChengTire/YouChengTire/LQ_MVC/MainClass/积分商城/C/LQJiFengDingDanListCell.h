//
//  LQJiFengDingDanListCell.h
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LQModelGiftList.h"

@interface LQJiFengDingDanListCell : UITableViewCell

@property (nonatomic, strong) LQModelGiftList *model;

+ (LQJiFengDingDanListCell *)cellWithTableView:(UITableView *)tableView;

@end
