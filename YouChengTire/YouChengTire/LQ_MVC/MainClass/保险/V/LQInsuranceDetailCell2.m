//
//  LQInsuranceDetailCell2.m
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQInsuranceDetailCell2.h"

@implementation LQInsuranceDetailCell2


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (LQInsuranceDetailCell2 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"LQInsuranceDetailCell2";
    LQInsuranceDetailCell2 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[LQInsuranceDetailCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UILabel *namelabel = [[UILabel alloc] init];
    namelabel.text = @"行驶证";
    namelabel.font = [UIFont systemFontOfSize:15];
    namelabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:namelabel];
    
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.userInteractionEnabled = YES;
    [self.contentView addSubview:imageView1];
    self.imageView1 = imageView1;
    
    UIImageView *imageView2 = [[UIImageView alloc] init];
    imageView2.userInteractionEnabled = YES;
    [self.contentView addSubview:imageView2];
    self.imageView2 = imageView2;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2)];
    [imageView1 addGestureRecognizer:tap1];
    [imageView2 addGestureRecognizer:tap2];
    
    namelabel.sd_layout
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,15)
    .heightIs(20)
    .widthIs(70);
    
    imageView1.sd_layout
    .topSpaceToView(self.contentView,5)
    .leftSpaceToView(namelabel,10)
    .widthIs(60)
    .heightEqualToWidth();
    
    imageView2.sd_layout
    .topSpaceToView(self.contentView,5)
    .leftSpaceToView(imageView1,10)
    .widthIs(60)
    .heightEqualToWidth();
}

- (void)tap1
{
    if (self.didTapImageView1) {
        self.didTapImageView1(self.imageView1);
    }
}

- (void)tap2
{
    if (self.didTapImageView2) {
        self.didTapImageView1(self.imageView2);
    }
    
}

@end
