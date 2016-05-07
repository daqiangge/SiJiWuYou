//
//  LQJIFenShangChengHomeCell2.m
//  YouChengTire
//
//  Created by liqiang on 16/4/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQJIFenShangChengHomeCell2.h"

@implementation LQJIFenShangChengHomeCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (LQJIFenShangChengHomeCell2 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"LQJIFenShangChengHomeCell2";
    
    LQJIFenShangChengHomeCell2 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    
    if (cell == nil)
    {
        cell = [[LQJIFenShangChengHomeCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    self.contentView.backgroundColor = COLOR_LightGray;
    
    UIButton *btn1 = [[UIButton alloc] init];
    [btn1 setImage:[UIImage imageNamed:@"home_cell_fourth_01"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"home_cell_fourth_01"] forState:UIControlStateHighlighted];
    [btn1 addTarget:self action:@selector(didClickBtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] init];
    [btn2 setImage:[UIImage imageNamed:@"home_cell_fourth_02"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"home_cell_fourth_02"] forState:UIControlStateHighlighted];
    [btn2 addTarget:self action:@selector(didClickBtn2) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] init];
    [btn3 setImage:[UIImage imageNamed:@"home_cell_fourth_03"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"home_cell_fourth_03"] forState:UIControlStateHighlighted];
    [btn3 addTarget:self action:@selector(didClickBtn3) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn3];
    
    UIButton *btn4 = [[UIButton alloc] init];
    [btn4 setImage:[UIImage imageNamed:@"home_cell_fourth_04"] forState:UIControlStateNormal];
    [btn4 setImage:[UIImage imageNamed:@"home_cell_fourth_04"] forState:UIControlStateHighlighted];
    [btn4 addTarget:self action:@selector(didClickBtn4) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn4];
    
    btn1.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,0)
    .widthRatioToView(self.contentView,0.5)
    .heightIs((kScreenWidth/2)/2.25);
    
    btn2.sd_layout
    .leftSpaceToView(btn1,0)
    .topSpaceToView(self.contentView,0)
    .widthRatioToView(self.contentView,0.5)
    .heightIs((kScreenWidth/2)/2.25);
    
    btn3.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(btn1,1)
    .widthRatioToView(self.contentView,0.5)
    .heightIs((kScreenWidth/2)/2.25);
    
    btn4.sd_layout
    .leftSpaceToView(btn3,0)
    .topSpaceToView(btn1,1)
    .widthRatioToView(self.contentView,0.5)
    .heightIs((kScreenWidth/2)/2.25);
}

- (void)didClickBtn1
{
    if (self.clickBtn1) {
        self.clickBtn1();
    }
}

- (void)didClickBtn2
{
    if (self.clickBtn2) {
        self.clickBtn2();
    }
}

- (void)didClickBtn3
{
    if (self.clickBtn3) {
        self.clickBtn3();
    }
}

- (void)didClickBtn4
{
    if (self.clickBtn4) {
        self.clickBtn4();
    }
}

@end
