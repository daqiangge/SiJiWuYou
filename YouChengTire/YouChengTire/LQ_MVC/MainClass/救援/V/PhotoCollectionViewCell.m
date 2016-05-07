//
//  PhotoCollectionViewCell.m
//  YouChengTire
//
//  Created by liqiang on 16/4/20.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self drawView];
    }
    
    return self;
}

- (void)drawView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, PhotoCollectionViewCell_W, PhotoCollectionViewCell_H)];
    [imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    imageView.contentMode =  UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    imageView.clipsToBounds  = YES;
    [self addSubview:imageView];
    self.imageView = imageView;
}

@end
