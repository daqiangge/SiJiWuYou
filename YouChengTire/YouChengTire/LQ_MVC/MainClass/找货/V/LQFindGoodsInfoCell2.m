//
//  LQFindGoodsInfoCell2.m
//  YouChengTire
//
//  Created by liqiang on 16/4/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQFindGoodsInfoCell2.h"

@interface LQFindGoodsInfoCell2()

@property (nonatomic, weak)  UILabel *contentlabel;

@end

@implementation LQFindGoodsInfoCell2


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (LQFindGoodsInfoCell2 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"LQFindGoodsInfoCell2";
    LQFindGoodsInfoCell2 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[LQFindGoodsInfoCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:17];
    label.text = @"货物描述";
    [self.contentView addSubview:label];
    
    UILabel *contentlabel = [[UILabel alloc] init];
    contentlabel.font = [UIFont systemFontOfSize:14];
    contentlabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:contentlabel];
    self.contentlabel = contentlabel;
    
    label.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,10)
    .widthIs(100)
    .heightIs(40);
    
    contentlabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(label,5)
    .rightSpaceToView(self.contentView,15)
    .autoHeightRatio(0);
    
//    [self setupAutoHeightWithBottomView:contentlabel bottomMargin:15];
}

- (void)setStr:(NSString *)str
{
    _str = str;
    
    self.contentlabel.text = str;
}

@end
