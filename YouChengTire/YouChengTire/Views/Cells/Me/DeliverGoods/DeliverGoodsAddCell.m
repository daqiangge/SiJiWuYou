//
//  DeliverGoodsAddCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/5.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "DeliverGoodsAddCell.h"

@interface DeliverGoodsAddCell ()

@property (weak, nonatomic) IBOutlet UIView *opinionView;

@end

@implementation DeliverGoodsAddCell

- (void)awakeFromNib {
    // Initialization code
    [self configureView];
}

- (void)configureView {
    _opinionView.layer.borderWidth = 1;
    _opinionView.layer.cornerRadius = 6;
    _opinionView.layer.borderColor = RGB(153, 153, 153).CGColor;
}

@end
