//
//  LQFahuoListCell.m
//  YouChengTire
//
//  Created by liqiang on 16/4/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQFahuoListCell.h"

@interface LQFahuoListCell()
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *startAddressLabel;
@property (nonatomic, weak) UILabel *endAddressLabel;
@property (nonatomic, weak) UILabel *personLabel;
@property (nonatomic, weak) UILabel *stateLabel;
@end

@implementation LQFahuoListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (LQFahuoListCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"LQFahuoListCell";
    LQFahuoListCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[LQFahuoListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.text = @"21123";
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *startAddressLabel = [[UILabel alloc] init];
    startAddressLabel.font = [UIFont systemFontOfSize:15];
    startAddressLabel.textColor = [UIColor blackColor];
    startAddressLabel.text = @"21123";
    [self.contentView addSubview:startAddressLabel];
    self.startAddressLabel = startAddressLabel;
    
    UILabel *endAddressLabel = [[UILabel alloc] init];
    endAddressLabel.font = [UIFont systemFontOfSize:15];
    endAddressLabel.textColor = [UIColor redColor];
    endAddressLabel.text = @"21123";
    [self.contentView addSubview:endAddressLabel];
    self.endAddressLabel = endAddressLabel;
    
    UILabel *personLabel = [[UILabel alloc] init];
    personLabel.font = [UIFont systemFontOfSize:15];
    personLabel.textColor = [UIColor blackColor];
    personLabel.text = @"21123";
    [self.contentView addSubview:personLabel];
    self.personLabel = personLabel;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_LightGray;
    [self.contentView addSubview:lineView];
    
    UILabel *stateLabel = [[UILabel alloc] init];
    stateLabel.font = [UIFont systemFontOfSize:15];
    stateLabel.textColor = [UIColor redColor];
    stateLabel.textAlignment = NSTextAlignmentCenter;
    stateLabel.text = @"未发货";
    [self.contentView addSubview:stateLabel];
    self.stateLabel = stateLabel;
    
    nameLabel.sd_layout
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,10)
    .widthIs(200)
    .heightIs(20);
    
    startAddressLabel.sd_layout
    .topSpaceToView(nameLabel,0)
    .leftSpaceToView(self.contentView,10)
    .widthIs(200)
    .heightIs(20);
    
    endAddressLabel.sd_layout
    .topSpaceToView(startAddressLabel,0)
    .leftSpaceToView(self.contentView,10)
    .widthIs(200)
    .heightIs(20);
    
    personLabel.sd_layout
    .topSpaceToView(endAddressLabel,0)
    .leftSpaceToView(self.contentView,10)
    .widthIs(200)
    .heightIs(20);
    
    stateLabel.sd_layout
    .topSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .widthIs(60)
    .bottomSpaceToView(self.contentView,0);
    
    lineView.sd_layout
    .topSpaceToView(self.contentView,10)
    .rightSpaceToView(stateLabel,0)
    .widthIs(1)
    .bottomSpaceToView(self.contentView,10);
    
}
- (void)setModel:(LQModelGoods *)model
{
    _model = model;
    
    self.nameLabel.text = model.name;
    self.startAddressLabel.text = [NSString stringWithFormat:@"始发地：%@",model.startPoint];
    self.endAddressLabel.text = [NSString stringWithFormat:@"目的地：%@",model.endPoint];
    self.personLabel.text = [NSString stringWithFormat:@"%@  %@", model.contacts, model.mobile];
    self.stateLabel.text = [model.status intValue] == 0?@"未发货":@"已发货";
}

@end
