//
//  LQJiFengDingDanListCell.m
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQJiFengDingDanListCell.h"

@interface LQJiFengDingDanListCell()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *shangChangJiaLabel;
@property (nonatomic, weak) UILabel *xianJiFenLabel;
@property (nonatomic, weak) UILabel *yuanJiFenLabel;
@property (nonatomic, weak) UILabel *numLabel;
@property (nonatomic, weak) UILabel *orderNumLabel;
@property (nonatomic, weak) UILabel *stateLabel;
@property (nonatomic, weak) UILabel *heJiLabel;
@property (nonatomic, weak) UIImageView *shangPingImagView;

@end

@implementation LQJiFengDingDanListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (LQJiFengDingDanListCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"LQJiFengDingDanListCell";
    LQJiFengDingDanListCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[LQJiFengDingDanListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    
    UILabel *orderNumLabel = [[UILabel alloc] init];
    orderNumLabel.textColor = [UIColor blackColor];
    orderNumLabel.font = [UIFont systemFontOfSize:15];
    orderNumLabel.text = @"订单号：";
    [self.contentView addSubview:orderNumLabel];
    self.orderNumLabel = orderNumLabel;
    
    UILabel *stateLabel = [[UILabel alloc] init];
    stateLabel.textColor = [UIColor redColor];
    stateLabel.font = [UIFont systemFontOfSize:15];
    stateLabel.textAlignment = NSTextAlignmentRight;
    stateLabel.text = @"待发货";
    [self.contentView addSubview:stateLabel];
    self.stateLabel = stateLabel;
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = COLOR_LightGray;
    [self.contentView addSubview:lineView1];
    
    UIImageView *shangPingImagView = [[UIImageView alloc] init];
    [self.contentView addSubview:shangPingImagView];
    //    [shangPingImagView sd_setImageWithURL:[NSURL URLWithString:self.model.appPhoto] placeholderImage:[UIImage imageNamed:@"ic_service_logo"]];
    self.shangPingImagView = shangPingImagView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = @"原%@积分";
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *shangChangJiaLabel = [[UILabel alloc] init];
    shangChangJiaLabel.textColor = [UIColor lightGrayColor];
    shangChangJiaLabel.font = [UIFont systemFontOfSize:12];
    shangChangJiaLabel.text = @"原%@积分";
    [self.contentView addSubview:shangChangJiaLabel];
    self.shangChangJiaLabel = shangChangJiaLabel;
    
    UILabel *xianJiFenLabel = [[UILabel alloc] init];
    xianJiFenLabel.textColor = [UIColor redColor];
    xianJiFenLabel.font = [UIFont systemFontOfSize:12];
    xianJiFenLabel.text = @"原%@积分";
    [self.contentView addSubview:xianJiFenLabel];
    self.xianJiFenLabel = xianJiFenLabel;
    
    UILabel *yuanJiFenLabel = [[UILabel alloc] init];
    yuanJiFenLabel.textColor = [UIColor lightGrayColor];
    yuanJiFenLabel.font = [UIFont systemFontOfSize:12];
    yuanJiFenLabel.text = @"原%@积分";
    [self.contentView addSubview:yuanJiFenLabel];
    self.yuanJiFenLabel = yuanJiFenLabel;
    
    
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.textColor = [UIColor lightGrayColor];
    numLabel.font = [UIFont systemFontOfSize:12];
    numLabel.text = @"x999";
    numLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:numLabel];
    self.numLabel = numLabel;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_LightGray;
    [self.contentView addSubview:lineView];
    
    UILabel *heJiLabel = [[UILabel alloc] init];
    heJiLabel.textColor = [UIColor lightGrayColor];
    heJiLabel.font = [UIFont systemFontOfSize:14];
    heJiLabel.text = @"共1件商品 合计：￥10积分";
    heJiLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:heJiLabel];
    self.heJiLabel = heJiLabel;
    
    orderNumLabel.sd_layout
    .topSpaceToView(self.contentView,0)
    .leftSpaceToView(self.contentView,10)
    .widthIs(kScreenWidth - 50)
    .heightIs(30);
    
    stateLabel.sd_layout
    .topSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,10)
    .widthIs(kScreenWidth - 50)
    .heightIs(30);
    
    lineView1.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(orderNumLabel,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(1);
    
    heJiLabel.sd_layout
    .rightSpaceToView(self.contentView,10)
    .bottomSpaceToView(self.contentView,0)
    .leftSpaceToView(self.contentView,10)
    .heightIs(30);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .bottomSpaceToView(heJiLabel,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(1);
    
    shangPingImagView.sd_layout
    .topSpaceToView(lineView1,10)
    .leftSpaceToView(self.contentView,10)
    .widthIs(80)
    .heightIs(80);
    
    titleLabel.sd_layout
    .topSpaceToView(lineView1,10)
    .leftSpaceToView(shangPingImagView,10)
    .rightSpaceToView(self.contentView,10)
    .autoHeightRatio(0);
    [titleLabel setMaxNumberOfLinesToShow:2];
    
    xianJiFenLabel.sd_layout
    .leftSpaceToView(shangPingImagView,10)
    .bottomEqualToView(shangPingImagView)
    .heightIs(15);
    [xianJiFenLabel setSingleLineAutoResizeWithMaxWidth:80];
    
    yuanJiFenLabel.sd_layout
    .leftSpaceToView(xianJiFenLabel,5)
    .bottomEqualToView(xianJiFenLabel)
    .heightIs(15);
    [yuanJiFenLabel setSingleLineAutoResizeWithMaxWidth:80];
    
    shangChangJiaLabel.sd_layout
    .leftSpaceToView(shangPingImagView,10)
    .bottomSpaceToView(xianJiFenLabel,5)
    .heightIs(15);
    [shangChangJiaLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    numLabel.sd_layout
    .rightSpaceToView(self.contentView,10)
    .bottomEqualToView(xianJiFenLabel)
    .leftSpaceToView(yuanJiFenLabel,5)
    .heightIs(15);
    
}

- (void)setModel:(LQModelGiftList *)model
{
    _model = model;
    
    [self.shangPingImagView sd_setImageWithURL:[NSURL URLWithString:model.gift.appPhoto] placeholderImage:[UIImage imageNamed:@"me_discount_logo"]];
    self.titleLabel.text = model.gift.name;
    self.shangChangJiaLabel.text = [NSString stringWithFormat:@"市场价:%@",self.model.gift.marketPrice];
    self.xianJiFenLabel.text = [NSString stringWithFormat:@"现%ld积分",self.model.gift.price];
    self.numLabel.text = [NSString stringWithFormat:@"x%@",self.model.count];
    self.orderNumLabel.text = [NSString stringWithFormat:@"订单号：%@",self.model.number];
    self.shangChangJiaLabel.hidden = !self.model.gift.marketPrice.length;
    
    NSDictionary *dic = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],
                          NSFontAttributeName:[UIFont systemFontOfSize:12],
                          NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    NSString *str = [NSString stringWithFormat:@"原%@积分",self.model.gift.oldPrice];
    NSMutableAttributedString *oldPriceAtt = [[NSMutableAttributedString alloc] initWithString:str attributes:dic];
    self.yuanJiFenLabel.attributedText = oldPriceAtt;
//    0待发货1待收货2待评价3交易完成
    switch ([model.status intValue]) {
        case 0:
        {
            self.stateLabel.text = @"待发货";
        }
            break;
        case 1:
        {
            self.stateLabel.text = @"待发货";
        }
            break;
        case 2:
        {
            self.stateLabel.text = @"待发货";
        }
            break;
        case 3:
        {
            self.stateLabel.text = @"待发货";
        }
            break;
            
        default:
            break;
    }
}

@end
