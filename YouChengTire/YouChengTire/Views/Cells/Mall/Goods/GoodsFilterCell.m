//
//  GoodsFilterCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsFilterCell.h"

@interface GoodsFilterCell ()

@property (nullable, nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nullable, nonatomic, weak) IBOutlet UILabel *valueLabel;

@end

@implementation GoodsFilterCell

- (void)configureCell:(NSDictionary *)model {
    _titleLabel.text = model[kTitle];
    _valueLabel.text = model[kValue];
}

@end
