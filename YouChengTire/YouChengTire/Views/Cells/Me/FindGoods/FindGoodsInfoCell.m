//
//  FindGoodsInfoCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/5.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "FindGoodsInfoCell.h"

@interface FindGoodsInfoCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *startAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *endAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation FindGoodsInfoCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 */

- (void)setModel:(LQModelGoods *)model
{
    _model = model;
    
    self.nameLabel.text = model.name;
    self.startAddressLabel.text = model.startPoint;
    self.endAddressLabel.text = model.endPoint;
//    self.nameLabel.text = model.contacts;
    self.phoneLabel.text = model.mobile;
    self.detailLabel.text  = model.content;
}

@end
