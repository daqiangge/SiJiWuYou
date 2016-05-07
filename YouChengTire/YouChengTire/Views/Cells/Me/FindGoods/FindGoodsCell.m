//
//  FindGoodsCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/5.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "FindGoodsCell.h"

@interface FindGoodsCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *startAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *endAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *callBtn;

@end

@implementation FindGoodsCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)call:(id)sender
{
    if (self.model)
    {
        
        [[UIApplication sharedApplication]
         openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.model.mobile]]];
    }
}

- (void)setModel:(LQModelGoods *)model
{
    _model = model;
    
    self.titleLabel.text = model.name;
    self.startAddressLabel.text = model.startPoint;
    self.endAddressLabel.text = model.endPoint;
    self.nameLabel.text = model.contacts;
    self.phoneLabel.text = model.mobile;
}

@end
