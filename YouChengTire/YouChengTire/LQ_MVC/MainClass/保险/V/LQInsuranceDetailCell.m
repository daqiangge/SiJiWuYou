//
//  LQInsuranceDetailCell.m
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQInsuranceDetailCell.h"

@interface LQInsuranceDetailCell()

@end

@implementation LQInsuranceDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (LQInsuranceDetailCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"LQInsuranceDetailCell";
    LQInsuranceDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[LQInsuranceDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UILabel *namelabel = [[UILabel alloc] init];
    namelabel.text = @"险种";
    namelabel.font = [UIFont systemFontOfSize:15];
    namelabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:namelabel];
    self.namelabel = namelabel;
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.text = @"险种";
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_LightGray;
    [self.contentView addSubview:lineView];
    
    namelabel.sd_layout
    .topSpaceToView(self.contentView,0)
    .leftSpaceToView(self.contentView,15)
    .bottomSpaceToView(self.contentView,0)
    .widthIs(70);
    
    contentLabel.sd_layout
    .topSpaceToView(self.contentView,0)
    .leftSpaceToView(namelabel,10)
    .bottomSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,15);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(1);
}

@end
