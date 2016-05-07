//
//  LQInsuranceListCell.m
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQInsuranceListCell.h"

@interface LQInsuranceListCell()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *stateLabel;


@end

@implementation LQInsuranceListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (LQInsuranceListCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"LQInsuranceListCell";
    LQInsuranceListCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[LQInsuranceListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)drawView
{
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"货物描述货物描述货物描述货物描述货物描述";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"保期：2018-10-10-";
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *stateLabel = [[UILabel alloc] init];
    stateLabel.text = @"待审核";
    stateLabel.font = [UIFont systemFontOfSize:14];
    stateLabel.textColor = [UIColor redColor];
    stateLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:stateLabel];
    self.stateLabel = stateLabel;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_LightGray;
    [self.contentView addSubview:lineView];
    
    titleLabel.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,5)
    .heightIs(20)
    .widthIs(kScreenWidth - 80);
    
    timeLabel.sd_layout
    .leftSpaceToView(self.contentView,10)
    .bottomSpaceToView(self.contentView,5)
    .heightIs(20)
    .widthIs(kScreenWidth - 80);
    
    stateLabel.sd_layout
    .rightSpaceToView(self.contentView,-8)
    .centerYEqualToView(self.contentView)
    .heightIs(20)
    .widthIs(50);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .heightIs(1)
    .widthIs(kScreenWidth)
    .bottomSpaceToView(self.contentView,0);
}

- (void)setModel:(LQModelinsuranceList *)model
{
    _model = model;
    
    self.titleLabel.text = model.monoline;
    self.timeLabel.text = [NSString stringWithFormat:@"保期：%@-%@",model.startDate,model.endDate];

    if (self.timeLabel.text.length == 4)
    {
        self.timeLabel.text = @"保期：";
    }
    
    NSString *str;
    switch ([model.status intValue])
    {
        case 0:
        {
            str = @"待审核";
        }
            break;
        case 1:
        {
            str = @"待办理";
        }
            break;
        case 2:
        {
            str = @"有效";
        }
            break;
        case 3:
        {
            str = @"审核失败";
        }
            break;
        case 4:
        {
            str = @"办理失败";
        }
            break;
        case 5:
        {
            str = @"过期";
        }
            break;
            
        default:
            break;
    }
    self.stateLabel.text = str;
}

@end
