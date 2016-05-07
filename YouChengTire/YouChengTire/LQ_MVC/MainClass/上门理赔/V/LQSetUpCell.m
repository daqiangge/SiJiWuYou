//
//  LQSetUpCell.m
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQSetUpCell.h"

@interface LQSetUpCell()

@property (nonatomic, weak) UIImageView *imageVieww;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *numLabel;

@end

@implementation LQSetUpCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (LQSetUpCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"LQSetUpCell";
    LQSetUpCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[LQSetUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:imageView];
    self.imageVieww = imageView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"2313";
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.textColor = [UIColor lightGrayColor];
    priceLabel.text = @"￥2313";
    [self.contentView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.font = [UIFont systemFontOfSize:14];
    numLabel.textColor = [UIColor lightGrayColor];
    numLabel.text = @"x10";
    numLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:numLabel];
    self.numLabel = numLabel;
    
    imageView.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,10)
    .bottomSpaceToView(self.contentView,10)
    .widthEqualToHeight();
    
    titleLabel.sd_layout
    .leftSpaceToView(imageView,10)
    .topEqualToView(imageView)
    .rightSpaceToView(self.contentView,15)
    .autoHeightRatio(0);
    
    priceLabel.sd_layout
    .leftSpaceToView(imageView,10)
    .bottomEqualToView(imageView)
    .widthIs(150)
    .heightIs(20);
    
    numLabel.sd_layout
    .rightSpaceToView(self.contentView,15)
    .bottomEqualToView(imageView)
    .widthIs(150)
    .heightIs(20);
    
}

- (void)setModelDic:(NSMutableDictionary *)modelDic
{
    _modelDic = modelDic;
    
    NSDictionary *dic = [modelDic valueForKey:@"product"];
    
    [self.imageVieww sd_setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"photo"]] placeholderImage:[UIImage imageNamed:@"me_discount_logo"]];
    self.titleLabel.text = [dic valueForKey:@"name"];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",[dic valueForKey:@"price"]];
    self.numLabel.text = [NSString stringWithFormat:@"x%@",[modelDic valueForKey:@"count"]];
}

@end
