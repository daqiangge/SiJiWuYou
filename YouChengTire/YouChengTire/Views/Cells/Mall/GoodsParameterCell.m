//
//  GoodsParameterCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsParameterCell.h"
// Pods
#import <MWPhotoBrowser/MWPhotoBrowser.h>
// Tools
#import "ZPMarkStarV.h"
// Models
#import "OrderRemarkM.h"
// ViewModels
#import "GoodsParameterVM.h"

@interface GoodsParameterCell () <
MWPhotoBrowserDelegate
>

@property (nullable, nonatomic, weak) IBOutlet UILabel *nameLable;
@property (nullable, nonatomic, weak) IBOutlet UILabel *contentLable;

@property (nullable, nonatomic, weak) IBOutlet UIView *scoreView;

@property (nullable, nonatomic, weak) IBOutlet RemarkPictureItemV *firstV;
@property (nullable, nonatomic, weak) IBOutlet RemarkPictureItemV *secondV;
@property (nullable, nonatomic, weak) IBOutlet RemarkPictureItemV *thirdV;
@property (nullable, nonatomic, weak) IBOutlet RemarkPictureItemV *fourthV;
@property (nullable, nonatomic, weak) IBOutlet RemarkPictureItemV *fifthV;

@property (nullable, nonatomic, strong) NSArray<RemarkPictureItemV *> *remarkPictureItemVArray;
@property (nullable, nonatomic, strong) ZPMarkStarV *markStarV;
@property (nullable, nonatomic, strong) OrderRemarkM *model;
@property (nullable, nonatomic, strong) GoodsParameterVM *viewModel;
@property (nullable, nonatomic, strong) MWPhotoBrowser *browser;
@property (nullable, nonatomic, strong) NSMutableArray *photos;
@property (nullable, nonatomic, strong) NSMutableArray *thumbs;

@end

@implementation GoodsParameterCell

- (void)awakeFromNib {
    // Initialization code
    _markStarV = [[ZPMarkStarV alloc] initWithStarSize:CGSizeMake(14.f, 14.f)
                                                 space:2
                                          numberOfStar:5];
    _markStarV.userInteractionEnabled = NO;
    [_scoreView addSubview:_markStarV];
    [_markStarV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scoreView);
    }];
}

- (void)bindViewModel:(GoodsParameterVM *)viewModel {
    _viewModel = viewModel;
}

- (void)configureCell:(OrderRemarkM *)model {
    _model = model;
    
    _nameLable.text = model.userName;
    _contentLable.text = model.content;
    _markStarV.initScore = [model.score floatValue];
    for (int i = 0; i < model.pictureList.count; i++) {
        if (i == 5) { break; }
        RemarkPictureItemV *remarkPictureItemV = self.remarkPictureItemVArray[i];
        remarkPictureItemV.hidden = NO;
        [remarkPictureItemV.logoImageView yy_setImageWithURL:[NSURL URLWithString:model.pictureList[i].appPath]
                                                 placeholder:nil];
    }
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

#pragma mark - Private

#pragma mark - Event Response
- (IBAction)didSelect:(id)sender {
    UIButton *button = (UIButton *)sender;
    
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
    
    if (!_photos
        && !_thumbs) {
        NSMutableArray *photos = @[].mutableCopy;
        NSMutableArray *thumbs = @[].mutableCopy;
        for (RemarkPictureM *remarkPictureM in _model.pictureList) {
            [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:remarkPictureM.appPath]]];
            [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:remarkPictureM.appPath]]];
        }
        _photos = photos;
        _thumbs = thumbs;
    }
    
    [_browser setCurrentPhotoIndex:button.tag];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:_browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [ZPRootViewController presentViewController:nc
                                       animated:YES
                                     completion:nil];
}

- (NSArray<RemarkPictureItemV *> *)remarkPictureItemVArray {
    if (!_remarkPictureItemVArray) {
        _remarkPictureItemVArray = @[
                                     _firstV,
                                     _secondV,
                                     _thirdV,
                                     _fourthV,
                                     _fifthV
                                     ];
    }
    return _remarkPictureItemVArray;
}

@end

@implementation RemarkPictureItemV

@end
