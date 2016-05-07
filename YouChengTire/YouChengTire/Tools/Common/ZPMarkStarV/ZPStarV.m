//
//  ZPStarV.m
//  StarDemo
//
//  Created by WangZhipeng on 16/4/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "ZPStarV.h"

#define kStarNormalImage        [UIImage imageNamed:@"star"];
#define kStarHighLightImage     [UIImage imageNamed:@"star_c"];

@interface ZPStarV ()

@property (nullable, nonatomic, strong) UIImage *normalImage;
@property (nullable, nonatomic, strong) UIImage *highLightImage;

@end

@implementation ZPStarV

#pragma mark - Override
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];

    if (_percent == 1) {
        [self.highLightImage drawInRect:rect];
        return;
    }
    if (_percent == 0) {
        [self.normalImage drawInRect:rect];
        return;
    }
    CGFloat leftImageWidth = rect.size.width * _percent;
    CGFloat rightImageWidth = rect.size.width - leftImageWidth;
    
    UIImage *leftImage = [self segmentImage:self.highLightImage
                                    percent:_percent
                                   fromLeft:YES];
    UIImage *rightImage = [self segmentImage:self.normalImage
                                     percent:1 - _percent
                                    fromLeft:NO];
    
    [leftImage drawInRect:CGRectMake(0,
                                     0,
                                     leftImageWidth,
                                     rect.size.height)];
    [rightImage drawInRect:CGRectMake(leftImageWidth,
                                      0,
                                      rightImageWidth,
                                      rect.size.height)];
}

#pragma mark - Private
- (UIImage *)segmentImage:(UIImage *)image percent:(CGFloat)percent fromLeft:(BOOL)left {
    CGSize sz = [image size];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width*percent, sz.height), NO, 0);
    if (left) {
        [image drawAtPoint:CGPointMake(0, 0)];
    } else {
        [image drawAtPoint:CGPointMake(-(sz.width - sz.width*percent), 0)];
    }
    UIImage *im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return im;
}

#pragma mark - Custom Accessors
- (UIImage *)normalImage{
    if (!_normalImage) {
        _normalImage = kStarNormalImage;
    }
    return _normalImage;
}

- (UIImage *)highLightImage{
    if (!_highLightImage) {
        _highLightImage = kStarHighLightImage;
    }
    return _highLightImage;
}

- (void)setPercent:(CGFloat)percent{
    _percent = percent;
    [self setNeedsDisplay];
}

@end
