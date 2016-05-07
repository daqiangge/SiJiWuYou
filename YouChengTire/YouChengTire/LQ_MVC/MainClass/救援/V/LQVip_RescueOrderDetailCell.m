//
//  LQVip_RescueOrderDetailCell.m
//  YouChengTire
//
//  Created by liqiang on 16/4/23.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQVip_RescueOrderDetailCell.h"
#import "LQModelRescue.h"
#import "LQModelPoint.h"

@interface LQVip_RescueOrderDetailCell()

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *addressLabel;

@end

@implementation LQVip_RescueOrderDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (LQVip_RescueOrderDetailCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"LQVip_RescueOrderDetailCell";
    
    LQVip_RescueOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    
    if (cell == nil)
    {
        cell = [[LQVip_RescueOrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
    }
    
    return cell;
}

- (void)drawView
{
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"安大安师大";
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.text = @"安大安师大请求为企鹅企鹅请问请问请问请问请问";
    addressLabel.font = [UIFont systemFontOfSize:12];
    addressLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:addressLabel];
    self.addressLabel = addressLabel;
    
    UILabel *xinjiLabel = [[UILabel alloc] init];
    xinjiLabel.text = @"评价星级：";
    xinjiLabel.font = [UIFont systemFontOfSize:12];
    xinjiLabel.textColor = [UIColor lightGrayColor];
//    [self.contentView addSubview:xinjiLabel];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineView];
    
    UIButton *callBtn = [[UIButton alloc] init];
    [callBtn setImage:[UIImage imageNamed:@"ic_phone"] forState:UIControlStateNormal];
    [callBtn addTarget:self action:@selector(didClickCallBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:callBtn];
    
    callBtn.sd_layout
    .rightSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthIs(80);
    
    lineView.sd_layout
    .rightSpaceToView(callBtn,0)
    .topSpaceToView(self.contentView,10)
    .bottomSpaceToView(self.contentView,10)
    .widthIs(1);
    
    nameLabel.sd_layout
    .leftSpaceToView(self.contentView ,10)
    .topSpaceToView(self.contentView,10)
    .rightSpaceToView(lineView,5)
    .autoHeightRatio(0);
    
    addressLabel.sd_layout
    .leftSpaceToView(self.contentView ,10)
    .topSpaceToView(self.nameLabel,10)
    .rightSpaceToView(lineView,5)
    .autoHeightRatio(0);
    
    xinjiLabel.sd_layout
    .leftSpaceToView(self.contentView ,10)
    .topSpaceToView(addressLabel,10)
    .rightSpaceToView(lineView,5)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:addressLabel bottomMargin:10];
}

- (void)didClickCallBtn
{
    if (self.modelRescueDetail && self.modelRescueDetail.rescue.point.phone.length)
    {
        NSString * phoneNum = [NSString stringWithFormat:@"tel:%@",self.modelRescueDetail.rescue.point.phone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneNum]]];
        [self addSubview:callWebview];
    }
}

- (void)setModelRescueDetail:(LQModelRescueDetail *)modelRescueDetail
{
    _modelRescueDetail = modelRescueDetail;
    
    self.nameLabel.text =  modelRescueDetail.rescue.point.brand;
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",modelRescueDetail.rescue.point.province,modelRescueDetail.rescue.point.city,modelRescueDetail.rescue.point.county,modelRescueDetail.rescue.point.detail];
}

@end
