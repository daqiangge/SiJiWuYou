//
//  GoodsClassifyCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/15.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsClassifyCell.h"
// Models
#import "GoodsClassifyM.h"

@interface GoodsClassifyCell ()

@property (nonatomic, weak) IBOutlet UIView *view01;
@property (nonatomic, weak) IBOutlet UIImageView *imageView01;
@property (nonatomic, weak) IBOutlet UILabel *titleLable01;
@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel01;

@property (nonatomic, weak) IBOutlet UIView *view02;
@property (nonatomic, weak) IBOutlet UIImageView *imageView02;
@property (nonatomic, weak) IBOutlet UILabel *titleLable02;
@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel02;

@property (nonatomic, strong) NSArray<GoodsClassifyItemM *> *goodsClassifyMArray;

@end

@implementation GoodsClassifyCell

- (void)configureCell:(NSDictionary *)model {
    _goodsClassifyMArray = model[@"kArray"];
    for (NSInteger i = 0; i < _goodsClassifyMArray.count; i++) {
        GoodsClassifyItemM *model = _goodsClassifyMArray[i];
        if (i == 0) {
            _view01.hidden = NO;
            [_imageView01 yy_setImageWithURL:[NSURL URLWithString:model.path]
                                 placeholder:nil];
            _titleLable01.text = model.title;
            _subtitleLabel01.text = model.uDescription;
        }
        else {
            _view02.hidden = NO;
            [_imageView02 yy_setImageWithURL:[NSURL URLWithString:model.path]
                                 placeholder:nil];
            _titleLable02.text = model.title;
            _subtitleLabel02.text = model.uDescription;
        }
    }
}

#pragma mark - Event Response
- (IBAction)didSelectType:(id)sender {
    UIButton *button = (UIButton *)sender;
    GoodsClassifyItemM *goodsClassifyItemM = _goodsClassifyMArray[button.tag];
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(didSelectType:)]) {
            [_delegate didSelectType:goodsClassifyItemM.type];
        }
    }
}

@end
