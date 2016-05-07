//
//  LQSetUpCell.h
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQSetUpCell : UITableViewCell

@property (nonatomic, strong) NSMutableDictionary *modelDic;

+ (LQSetUpCell *)cellWithTableView:(UITableView *)tableView;

@end
