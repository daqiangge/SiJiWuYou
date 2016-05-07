//
//  LQOrderClaimsShangMengTimeCell.h
//  YouChengTire
//
//  Created by liqiang on 16/4/25.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQOrderClaimsShangMengTimeCell : UITableViewCell

@property (nonatomic, copy) NSString *dateStr;

@property (nonatomic, assign) BOOL hideLine;

+ (LQOrderClaimsShangMengTimeCell *)cellWithTableView:(UITableView *)tableView;

@end
