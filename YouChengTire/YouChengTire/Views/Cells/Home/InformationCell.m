//
//  InformationCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/3.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "InformationCell.h"

@interface InformationCell ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

@implementation InformationCell

#pragma mark - Override
- (void)configureCell:(id)model {
    _logoImageView.image = GETIMAGE(@"home_cell_fifth_01");
    _titleLabel.text = @"车上哪些东西影响舒适性 轮胎减震最直接";
    _subtitleLabel.text = @"不少人心中的好车标准，舒适性可能最重要，毕竟买车是为了享受，而不是为了受罪。驾车是为了给工作和生活带来方便和愉悦。";
}

#pragma mark - Static Public
+ (CGFloat)height { return 50.f; }

@end
