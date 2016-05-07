//
//  LQOrderClaimsAddressDetailCell.m
//  YouChengTire
//
//  Created by liqiang on 16/4/25.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQOrderClaimsAddressDetailCell.h"

@interface LQOrderClaimsAddressDetailCell()

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *phoneNumLabel;
@property (nonatomic, weak) UILabel *addressLabel;

@end

@implementation LQOrderClaimsAddressDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (LQOrderClaimsAddressDetailCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"LQOrderClaimsAddressDetailCell";
    LQOrderClaimsAddressDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil) {
        cell = [[LQOrderClaimsAddressDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"mall_order_cell_logo"];
    [self.contentView addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor lightGrayColor];
//    nameLabel.text = @"张三";
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *phoneNumLabel = [[UILabel alloc] init];
    phoneNumLabel.textColor = [UIColor lightGrayColor];
//    phoneNumLabel.text = @"12345678909";
    phoneNumLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:phoneNumLabel];
    self.phoneNumLabel = phoneNumLabel;
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.textColor = [UIColor lightGrayColor];
//    addressLabel.text = @"撒打算打算打算打算打算的飒飒大发发发无人玩儿玩儿额外热温热污染为人";
    addressLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:addressLabel];
    self.addressLabel = addressLabel;
    
    imageView.sd_layout
    .widthIs(25)
    .heightIs(25)
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,15);
    
    nameLabel.sd_layout
    .topSpaceToView(self.contentView,5)
    .leftSpaceToView(imageView,10)
    .heightIs(20)
    .widthIs(100);
    
    phoneNumLabel.sd_layout
    .topSpaceToView(self.contentView,5)
    .leftSpaceToView(nameLabel,10)
    .heightIs(20)
    .widthIs(150);
    
    addressLabel.sd_layout
    .topSpaceToView(nameLabel,5)
    .leftSpaceToView(imageView,10)
    .rightSpaceToView(self.contentView,15)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomViewsArray:@[imageView,addressLabel] bottomMargin:15];
}

- (void)setModel:(ReceiptAddressItemM *)model
{
    _model = model;
    
    self.nameLabel.text = model.name;
    self.phoneNumLabel.text = model.mobile;
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.county,model.detail];
}

@end
