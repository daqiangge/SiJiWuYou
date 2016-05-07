//
//  LQJIFenShangChengHomeCell1.m
//  YouChengTire
//
//  Created by liqiang on 16/4/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQJIFenShangChengHomeCell1.h"

@implementation LQJIFenShangChengHomeCell1


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (LQJIFenShangChengHomeCell1 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"LQJIFenShangChengHomeCell1";
    
    LQJIFenShangChengHomeCell1 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    
    if (cell == nil)
    {
        cell = [[LQJIFenShangChengHomeCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor redColor];
    label.text = @"所有商品";
    [self.contentView addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.font = [UIFont systemFontOfSize:13];
    label2.textColor = [UIColor lightGrayColor];
    label2.textAlignment = NSTextAlignmentRight;
//    label2.text = @"全部分类";
    [self.contentView addSubview:label2];
    
    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.image = [UIImage imageNamed:@"me_cell_arrow"];
    [self.contentView addSubview:imageView];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_LightGray;
    [self.contentView addSubview:lineView];
    
    imageView.sd_layout
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(8)
    .heightIs(15);
    
    label2.sd_layout
    .rightSpaceToView(imageView,5)
    .centerYEqualToView(self.contentView)
    .widthIs(80)
    .heightIs(15);
    
    label.sd_layout
    .leftSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(80)
    .heightIs(20);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .heightIs(1);
}

@end
