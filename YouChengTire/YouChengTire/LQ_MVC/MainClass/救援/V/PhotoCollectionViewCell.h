//
//  PhotoCollectionViewCell.h
//  YouChengTire
//
//  Created by liqiang on 16/4/20.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PhotoCollectionViewCell_W (kScreenWidth - 30 - 3*15)/4
#define PhotoCollectionViewCell_H (kScreenWidth - 30 - 3*15)/4

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) UIImageView *imageView;

@end
