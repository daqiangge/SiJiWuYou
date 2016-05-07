//
//  LQJIFenShangChengHomeCell3.m
//  YouChengTire
//
//  Created by liqiang on 16/4/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQJIFenShangChengHomeCell3.h"

@interface LQJIFenShangChengHomeCell3()

@property (nonatomic, weak) UIImageView *imageVieww;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UIButton *btn;

@end

@implementation LQJIFenShangChengHomeCell3

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (LQJIFenShangChengHomeCell3 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"LQJIFenShangChengHomeCell3";
    
    LQJIFenShangChengHomeCell3 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    
    if (cell == nil)
    {
        cell = [[LQJIFenShangChengHomeCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    self.contentView.backgroundColor = COLOR_LightGray;
    
    UIView *backGroundView = [[UIView alloc] init];
    backGroundView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backGroundView];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [backGroundView addSubview:imageView];
    self.imageVieww = imageView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = @"阿萨斯的的";
    [backGroundView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.text = @"￥123213";
    [backGroundView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"兑换" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.enabled = false;
    [backGroundView addSubview:btn];
    self.btn = btn;
    
    backGroundView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,5)
    .bottomSpaceToView(self.contentView,5);
    
    imageView.sd_layout
    .leftSpaceToView(backGroundView,10)
    .topSpaceToView(backGroundView,5)
    .bottomSpaceToView(backGroundView,5)
    .widthEqualToHeight();
    
    titleLabel.sd_layout
    .leftSpaceToView(imageView,10)
    .rightSpaceToView(backGroundView,10)
    .topSpaceToView(backGroundView,10)
    .autoHeightRatio(0);
    [titleLabel setMaxNumberOfLinesToShow:2];
    
    priceLabel.sd_layout
    .leftSpaceToView(imageView,10)
    .bottomSpaceToView(backGroundView,10)
    .heightIs(18)
    .widthIs(100);
    
    btn.sd_layout
    .rightSpaceToView(backGroundView,10)
    .bottomSpaceToView(backGroundView,5)
    .widthIs(45)
    .heightIs(25);

}

- (void)setModel:(LQModelGift *)model
{
    _model = model;
    
    [self.imageVieww sd_setImageWithURL:[NSURL URLWithString:model.appPhoto] placeholderImage:[UIImage imageNamed:@"ic_service_logo"]];
    self.titleLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%ld",model.price];
}

@end
