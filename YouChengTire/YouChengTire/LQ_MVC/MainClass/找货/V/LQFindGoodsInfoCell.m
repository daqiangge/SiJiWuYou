//
//  LQFindGoodsInfoCell.m
//  YouChengTire
//
//  Created by liqiang on 16/4/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQFindGoodsInfoCell.h"

@implementation LQFindGoodsInfoCell


+ (LQFindGoodsInfoCell *)cellWithTableView:(UITableView *)tableView
{
    UINib *nib = [UINib nibWithNibName:@"LQFindGoodsInfoCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"LQFindGoodsInfoCell"];
    
    LQFindGoodsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQFindGoodsInfoCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
