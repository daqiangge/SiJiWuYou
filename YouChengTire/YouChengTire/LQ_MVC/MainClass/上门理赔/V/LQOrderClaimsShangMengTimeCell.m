//
//  LQOrderClaimsShangMengTimeCell.m
//  YouChengTire
//
//  Created by liqiang on 16/4/25.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQOrderClaimsShangMengTimeCell.h"

@interface LQOrderClaimsShangMengTimeCell()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation LQOrderClaimsShangMengTimeCell


+ (LQOrderClaimsShangMengTimeCell *)cellWithTableView:(UITableView *)tableView
{
    UINib *nib = [UINib nibWithNibName:@"LQOrderClaimsShangMengTimeCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"LQOrderClaimsShangMengTimeCell"];
    
    LQOrderClaimsShangMengTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQOrderClaimsShangMengTimeCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setDateStr:(NSString *)dateStr
{
    _dateStr = dateStr;
    
    self.timeLabel.text = dateStr;
}

- (void)setHideLine:(BOOL)hideLine
{
    _hideLine = hideLine;
    
    self.lineView.hidden = hideLine;
}

@end
