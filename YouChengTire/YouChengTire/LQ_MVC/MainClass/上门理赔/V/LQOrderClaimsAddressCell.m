//
//  LQOrderClaimsAddressCell.m
//  YouChengTire
//
//  Created by liqiang on 16/4/25.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQOrderClaimsAddressCell.h"

@interface LQOrderClaimsAddressCell()

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation LQOrderClaimsAddressCell


+ (LQOrderClaimsAddressCell *)cellWithTableView:(UITableView *)tableView
{
    UINib *nib = [UINib nibWithNibName:@"LQOrderClaimsAddressCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"LQOrderClaimsAddressCell"];
    
    LQOrderClaimsAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQOrderClaimsAddressCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setHideLine:(BOOL)hideLine
{
    _hideLine = hideLine;
    
    self.lineView.hidden = hideLine;
}

@end
