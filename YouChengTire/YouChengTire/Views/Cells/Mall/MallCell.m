//
//  MallCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/12.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "MallCell.h"
// Pods
#import "SDCycleScrollView.h"
// Vendors
#import "TOWebViewController.h"
// Models
#import "MallM.h"
// ViewModels
#import "MallVM.h"

@implementation MallCell

#pragma mark - Static Private
+ (NSArray *)loadNib {
    return [self loadNibNamed:@"MallCell"];
}

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface MallFirstCell () <
SDCycleScrollViewDelegate
>

@property (nonatomic, weak) IBOutlet SDCycleScrollView *bannerView;

@property (nonatomic, strong) NSArray<MallImageItemM *> *array;
@property (nonatomic, strong) MallVM *viewModel;

@end

@implementation MallFirstCell

#pragma mark - Override
+ (instancetype)createCell {
    return [self loadNib][0];
}

- (void)bindViewModel:(MallVM *)viewModel {
    _viewModel = viewModel;
}

- (void)configureCell:(NSDictionary *)model {
    _array = model[@"kArray"];
//    [_topImageView yy_setImageWithURL:[NSURL URLWithString:mallImageItemM[0].path]
//                          placeholder:nil];
    NSMutableArray *mArray = @[].mutableCopy;
    for (MallImageItemM *mallImageItemM in _array) {
        [mArray addObject:mallImageItemM.path];
    }
    self.bannerView.imageURLStringsGroup = mArray;
    self.bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.bannerView.autoScroll = NO;
    self.bannerView.delegate = self;
    self.bannerView.currentPageDotColor = RGB(238, 72, 72); // 自定义分页控件小圆标颜色
//    self.bannerView.placeholderImage = [UIImage imageNamed:@"placeholder"];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    MallImageItemM *mallImageItemM = _array[index];
    if (STRING_NOT_EMPTY(mallImageItemM.target)) {
        TOWebViewController *webViewController = [[TOWebViewController alloc]
                                                  initWithURL:[NSURL URLWithString:mallImageItemM.target]];
        [_viewModel.masterVC.navigationController pushViewController:webViewController
                                                            animated:YES];
    }
}

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface MallSecondCell ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView01;
@property (nonatomic, weak) IBOutlet UIImageView *imageView02;
@property (nonatomic, weak) IBOutlet UIImageView *imageView03;
@property (nonatomic, weak) IBOutlet UIImageView *imageView04;

@property (nonatomic, weak) IBOutlet UILabel *label01;
@property (nonatomic, weak) IBOutlet UILabel *label02;
@property (nonatomic, weak) IBOutlet UILabel *label03;
@property (nonatomic, weak) IBOutlet UILabel *label04;

@property (nonatomic, weak) IBOutlet UILabel *subLabel01;
@property (nonatomic, weak) IBOutlet UILabel *subLabel02;
@property (nonatomic, weak) IBOutlet UILabel *subLabel03;
@property (nonatomic, weak) IBOutlet UILabel *subLabel04;

@property (nonatomic, strong) NSArray<NSArray *> *array;

@property (nonatomic, strong) NSArray<MallShopItemM *> *mallShopItemMArray;

@end

@implementation MallSecondCell

#pragma mark - Override
+ (instancetype)createCell {
    return [self loadNib][1];
}

- (void)configureCell:(NSDictionary *)model {
    _mallShopItemMArray = model[@"kArray"];
    for (NSInteger i = 0; i < self.array.count; i++) {
        NSArray *array = self.array[i];
        UIImageView *imageView = array[0];
        [imageView yy_setImageWithURL:[NSURL URLWithString:_mallShopItemMArray[i].path]
                          placeholder:nil];
        UILabel *lable = array[1];
        lable.text = _mallShopItemMArray[i].title;
        UILabel *subLabel = array[2];
        subLabel.text = _mallShopItemMArray[i].uDescription;
    }
}

- (NSArray<NSArray *> *)array {
    if (!_array) {
        _array = @[
                   @[_imageView01, _label01, _subLabel01],
                   @[_imageView02, _label02, _subLabel02],
                   @[_imageView03, _label03, _subLabel03],
                   @[_imageView04, _label04, _subLabel04],
                   ];
    }
    return _array;
}

#pragma mark - Event Response
- (IBAction)didSelectType:(id)sender {
    UIButton *button = (UIButton *)sender;
    MallShopItemM *mallShopItemM = _mallShopItemMArray[button.tag];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(didSelectType:)]) {
            [self.delegate didSelectType:mallShopItemM.target];
        }
    }
}

@end

/*****************************************************************************************
 * 三
 *****************************************************************************************/
@implementation MallThirdCell

#pragma mark - Override
+ (instancetype)createCell {
    return [self loadNib][2];
}

@end

/*****************************************************************************************
 * 四
 *****************************************************************************************/
@interface MallFourthCell ()

@property (nonatomic, weak) IBOutlet UIView *view01;
@property (nonatomic, weak) IBOutlet UIImageView *imageVie01;
@property (nonatomic, weak) IBOutlet UILabel *nameLable01;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel01;
@property (nonatomic, weak) IBOutlet UILabel *saleLabel01;

@property (nonatomic, weak) IBOutlet UIView *view02;
@property (nonatomic, weak) IBOutlet UIImageView *imageView02;
@property (nonatomic, weak) IBOutlet UILabel *nameLable02;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel02;
@property (nonatomic, weak) IBOutlet UILabel *saleLabel02;

@property (nonatomic, strong) NSArray<MallProductItemM *> *mallPriductItemMArray;

@end

@implementation MallFourthCell

#pragma mark - Override
+ (instancetype)createCell {
    return [self loadNib][3];
}

- (void)configureCell:(NSDictionary *)model {
    _mallPriductItemMArray = model[@"kArray"];
    for (NSInteger i = 0; i < _mallPriductItemMArray.count; i++) {
        MallProductItemM *model = _mallPriductItemMArray[i];
        if (i == 0) {
            _view01.hidden = NO;
            [_imageVie01 yy_setImageWithURL:[NSURL URLWithString:model.appPhoto]
                                placeholder:nil];
            _nameLable01.text = model.name;
            _priceLabel01.text = [NSString stringWithFormat:@"￥%.2f", [model.price floatValue]];
            _saleLabel01.text = [NSString stringWithFormat:@"%@人已购买", model.saleAmount];
        }
        else {
            _view02.hidden = NO;
            [_imageView02 yy_setImageWithURL:[NSURL URLWithString:model.appPhoto]
                                 placeholder:nil];
            _nameLable02.text = model.name;
            _priceLabel02.text = [NSString stringWithFormat:@"￥%.2f", [model.price floatValue]];
            _saleLabel02.text = [NSString stringWithFormat:@"%@人已购买", model.saleAmount];
        }
    }
}

#pragma mark - Event Response
- (IBAction)didSelectSId:(id)sender {
    UIButton *button = (UIButton *)sender;
    MallProductItemM *mallProductItemM = _mallPriductItemMArray[button.tag];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(didSelectSId:)]) {
            [self.delegate didSelectSId:mallProductItemM.sId];
        }
    }
}

@end
