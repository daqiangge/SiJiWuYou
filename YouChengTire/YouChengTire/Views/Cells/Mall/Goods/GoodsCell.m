//
//  GoodsCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/15.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsCell.h"
// Models
#import "GoodsM.h"

@interface GoodsCell ()

@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UILabel *saleLabel;

@end

@implementation GoodsCell

- (void)configureCell:(GoodsItemM *)model {
    [_logoImageView yy_setImageWithURL:[NSURL URLWithString:model.appPhoto]
                        placeholder:nil];
    _titleLabel.text = model.name;
    _subtitleLabel.text = model.uDescription;
    _priceLabel.text = [NSString stringWithFormat:@"￥ %.2f", [model.price floatValue]];
    _saleLabel.text = [NSString stringWithFormat:@"月售%@件", model.saleAmount];
}

@end
