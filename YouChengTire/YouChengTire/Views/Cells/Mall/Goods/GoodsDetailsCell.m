//
//  GoodsDetailsCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsDetailsCell.h"
// Pods
#import "SDCycleScrollView.h"
#import <MWPhotoBrowser/MWPhotoBrowser.h>
// Vendors
#import "NSString+WPAttributedMarkup.h"
#import "WPAttributedStyleAction.h"
#import "WPHotspotLabel.h"
// Tools
#import "ZPMarkStarV.h"
// Models
#import "GoodsDetailsM.h"
// ViewModels
#import "GoodsDetailsVM.h"

@implementation GoodsDetailsCell

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface GoodsDetailsFirstCell () <
SDCycleScrollViewDelegate,
MWPhotoBrowserDelegate
>

@property (nonatomic, weak) IBOutlet SDCycleScrollView *bannerView;

@property (nonatomic, strong) GoodsDetailsVM *viewModel;
@property (nonatomic, strong) NSArray<NSString *> *appImageList;

@property (nonatomic, strong) MWPhotoBrowser *browser;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;

@end

@implementation GoodsDetailsFirstCell

- (void)bindViewModel:(id)viewModel {
    _viewModel = viewModel;
}

- (void)configureCell:(NSDictionary *)model {
    GoodsDetailsProductM *goodsDetailsProductM = model[kModel];
    //    [_logoImageView yy_setImageWithURL:[NSURL URLWithString:goodsDetailsProductM.appPhoto]
    //                           placeholder:nil];
    _appImageList = goodsDetailsProductM.appImageList;
    self.bannerView.imageURLStringsGroup = _appImageList;
    self.bannerView.placeholderImage= GETIMAGE(@"mall_goods_define");
    self.bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.bannerView.autoScroll = NO;
    self.bannerView.delegate = self;
    self.bannerView.currentPageDotColor = RGB(238, 72, 72); // 自定义分页控件小圆标颜色
    //    self.bannerView.placeholderImage = [UIImage imageNamed:@"placeholder"];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    //    if (!_browser) {
    _browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    _browser.displayActionButton = YES;
    _browser.displayNavArrows = YES;
    _browser.displaySelectionButtons = NO;
    _browser.alwaysShowControls = NO;
    _browser.zoomPhotosToFill = YES;
    _browser.enableGrid = YES;
    _browser.startOnGrid = NO;
    _browser.enableSwipeToDismiss = NO;
    _browser.autoPlayOnAppear = NO;
    //    }
    
    if (!_photos
        && !_thumbs) {
        NSMutableArray *photos = @[].mutableCopy;
        NSMutableArray *thumbs = @[].mutableCopy;
        for (NSString *string in _appImageList) {
            [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:string]]];
            [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:string]]];
        }
        _photos = photos;
        _thumbs = thumbs;
    }
    
    [_browser setCurrentPhotoIndex:index];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:_browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [_viewModel.masterVC presentViewController:nc
                                      animated:YES
                                    completion:nil];
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface GoodsDetailsSecondCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLable;

@end

@implementation GoodsDetailsSecondCell

- (void)configureCell:(NSDictionary *)model {
    GoodsDetailsProductM *goodsDetailsProductM = model[kModel];
    //    _titleLable.text = [NSString stringWithFormat:@"%@ %@ %@",
    //                        goodsDetailsProductM.brand,
    //                        goodsDetailsProductM.name,
    //                        goodsDetailsProductM.uDescription];
    _titleLable.text = goodsDetailsProductM.name;
}

@end

/*****************************************************************************************
 * 三
 *****************************************************************************************/
@interface GoodsDetailsThirdCell ()

@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UILabel *saleLabel;

@end

@implementation GoodsDetailsThirdCell

- (void)configureCell:(NSDictionary *)model {
    GoodsDetailsProductM *goodsDetailsProductM = model[kModel];
    
    NSDictionary *priceStyle = @{ @"price" :
                                      @[[UIFont systemFontOfSize:12.f],
                                        RGB(153, 153, 153),
                                        @{ NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle) }]
                                  };
    _priceLabel.attributedText = [[NSString stringWithFormat:@"￥ %.2f  <price>￥ %.2f</price>",
                                   [goodsDetailsProductM.price floatValue],
                                   [goodsDetailsProductM.oldPrice floatValue]] attributedStringWithStyleBook:priceStyle];
    NSDictionary *saleStyle = @{ @"sale" : RGB(238, 72, 72) };
    _saleLabel.attributedText = [[NSString stringWithFormat:@"已售<sale>%@</sale>件",
                                  goodsDetailsProductM.saleAmount] attributedStringWithStyleBook:saleStyle];
}

@end

/*****************************************************************************************
 * 四
 *****************************************************************************************/
@interface GoodsDetailsFourthCell ()

@property (nonatomic, weak) IBOutlet UIView *view01;
@property (nonatomic, weak) IBOutlet UIView *view02;
@property (nonatomic, weak) IBOutlet UIView *view03;
@property (nonatomic, weak) IBOutlet UIView *view04;

@property (nonatomic, weak) IBOutlet UILabel *label01;
@property (nonatomic, weak) IBOutlet UILabel *label02;
@property (nonatomic, weak) IBOutlet UILabel *label03;
@property (nonatomic, weak) IBOutlet UILabel *label04;

@property (nonatomic, strong) NSArray<NSArray *> *array;

@end

@implementation GoodsDetailsFourthCell

- (void)configureCell:(NSDictionary *)model {
    NSArray<NSString *> *stringArray = model[kArray];
    for (NSInteger i = 0; i < stringArray.count; i++) {
        if (i == 4) {
            break;
        }
        if (![stringArray[i] isEqualToString:@""]) {
            NSArray *array = self.array[i];
            UIView *view = array[0];
            view.hidden = NO;
            UILabel *label = array[1];
            label.text = stringArray[i];
        }
    }
}

- (NSArray<NSArray *> *)array {
    if (!_array) {
        _array = @[
                   @[_view01, _label01],
                   @[_view01, _label02],
                   @[_view01, _label03],
                   @[_view01, _label04],
                   ];
    }
    return _array;
}

@end

/*****************************************************************************************
 * 五
 *****************************************************************************************/
@interface GoodsDetailsFifthCell ()

@property (nonatomic, weak) IBOutlet UITextField *numberTextField;

@property (nonatomic, strong) GoodsDetailsVM *viewModel;

@end

@implementation GoodsDetailsFifthCell

- (void)bindViewModel:(id)viewModel {
    _viewModel = viewModel;
    
    @weakify(self);
    [[_numberTextField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(NSString *productCount) {
         @strongify(self);
         NSInteger count = [productCount integerValue];
         NSString *number = [NSString stringWithFormat:@"%ld", (long)count];
         if (count > 99) {
             count = 99;
             number = [NSString stringWithFormat:@"%ld", (long)count];
         }
         else if (count < 1) {
             count = 1;
             number = [NSString stringWithFormat:@"%ld", (long)count];
         }
         self.numberTextField.text = number;
         self.viewModel.productCount = number;
     }];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    UIToolbar *keyBoard = [[NSBundle mainBundle] loadNibNamed:@"KeyBoardToolView"
                                                        owner:self
                                                      options:nil][0];
    textField.inputAccessoryView = keyBoard;
    _numberTextField = textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)plus:(id)sender {
    if (![_viewModel.productCount isEqualToString:@"99"]) {
        NSInteger count = [_viewModel.productCount integerValue];
        count = count + 1;
        NSString *productCount = [NSString stringWithFormat:@"%ld", (long)count];
        _numberTextField.text = productCount;
        _viewModel.productCount = productCount;
    }
}

- (IBAction)reduce:(id)sender {
    if (![_viewModel.productCount isEqualToString:@"1"]) {
        NSInteger count = [_viewModel.productCount integerValue];
        count = count - 1;
        NSString *productCount = [NSString stringWithFormat:@"%ld", (long)count];
        _numberTextField.text = productCount;
        _viewModel.productCount = productCount;
    }
}

- (IBAction)touchUpInside_keyBoardExit:(id)sender {
    [_numberTextField resignFirstResponder];
}

@end

/*****************************************************************************************
 * 六
 *****************************************************************************************/
@interface GoodsDetailsSixthCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLable;
@property (nonatomic, weak) IBOutlet UILabel *valueLable;

@end

@implementation GoodsDetailsSixthCell

- (void)configureCell:(NSDictionary *)model {
    _titleLable.text = model[kTitle];
    _valueLable.text = model[kValue];
}

@end

/*****************************************************************************************
 * 七
 *****************************************************************************************/
@implementation GoodsDetailsSeventhCell

@end

/*****************************************************************************************
 * 八
 *****************************************************************************************/
@interface GoodsDetailsEighthCell ()

@property (nullable, nonatomic, weak) IBOutlet UIView *markStarParentV;
@property (nullable, nonatomic, weak) IBOutlet UILabel *commentScoreLabel;
@property (nullable, nonatomic, weak) IBOutlet UILabel *commentCountLabel;

@end

@implementation GoodsDetailsEighthCell

- (void)configureCell:(NSDictionary *)model {
    GoodsDetailsProductM *goodsDetailsProductM = model[kModel];
    // 星星评分
    ZPMarkStarV *markStarV = [[ZPMarkStarV alloc] initWithStarSize:CGSizeMake(14.f, 14.f)
                                                             space:2
                                                      numberOfStar:5];
    markStarV.initScore = 0.f;
    [_markStarParentV addSubview:markStarV];
    [markStarV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_markStarParentV);
    }];
    //
    _commentScoreLabel.text = [NSString stringWithFormat:@"%.2f分", [@"0" floatValue]];
    _commentCountLabel.text = [NSString stringWithFormat:@"%@人评论", goodsDetailsProductM.commentCount];
}

@end

/*****************************************************************************************
 * 九
 *****************************************************************************************/
@implementation GoodsDetailsNinthCell

@end

/*****************************************************************************************
 * 十
 *****************************************************************************************/
@interface GoodsDetailsTenthCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation GoodsDetailsTenthCell

- (void)configureCell:(NSDictionary *)model {
    _title.text = model[kTitle];
}

@end
