//
//  GoodsFilterV.m
//  YouChengTire
//  商品筛选
//  Created by WangZhipeng on 16/4/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsFilterV.h"

@interface GoodsFilterV ()

@property (nullable ,nonatomic, weak) IBOutlet UIButton *button;

@end

@implementation GoodsFilterV

#pragma mark - View Lifecycle
- (void)selfInitialize {
    [self configureView];
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
}

- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
}

- (void)willRemoveSubview:(UIView *)subview {
    [super willRemoveSubview:subview];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (self.superview) {
        [self configureData];
        [self mas_makeConstraints: ^(MASConstraintMaker *make) {
            make.top.equalTo(ZPRootView).offset(20);
            make.bottom.equalTo(ZPRootView);
            make.left.equalTo(ZPRootView).offset(kScreenWidth);
            make.width.mas_equalTo(kScreenWidth);
        }];
    }
    else {
        // Pass
    }
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
}


#pragma mark - Static Public
+ (instancetype)sharedManager {
    static GoodsFilterV *goodsFilterV = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        goodsFilterV = [GoodsFilterV nibItem:@"GoodsFilterV"];
    });
    return goodsFilterV;
}

#pragma mark - Public
- (void)showView {
    self.userInteractionEnabled = YES;
    [self mas_updateConstraints: ^(MASConstraintMaker *make) {
        make.top.equalTo(ZPRootView).offset(20);
        make.bottom.equalTo(ZPRootView);
        make.left.equalTo(ZPRootView);
        make.width.mas_equalTo(kScreenWidth);
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }];
    [UIView animateWithDuration:0.35
                     animations:^{
                         [self layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         self.button.alpha = 0.3;
                     }];
}

- (void)closeView {
    self.button.alpha = 0.0;
    [self mas_updateConstraints: ^(MASConstraintMaker *make) {
        make.top.equalTo(ZPRootView).offset(20);
        make.bottom.equalTo(ZPRootView);
        make.left.equalTo(ZPRootView).offset(kScreenWidth);
        make.width.mas_equalTo(kScreenWidth);
    }];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.35
                     animations:^{
                         [self layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         self.userInteractionEnabled = NO;
                         [_nc popToRootViewControllerAnimated:NO];
                     }];
}

#pragma mark - Private
- (void)configureView {
    _button.alpha = 0.0;
    _button.backgroundColor = [UIColor blackColor];
}

- (void)configureData {}

#pragma mark - Event Response
- (IBAction)upInside_close:(id)sender {
//    [self closeView];
}

@end
