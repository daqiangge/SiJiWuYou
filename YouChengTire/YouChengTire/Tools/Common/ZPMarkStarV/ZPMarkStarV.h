//
//  ZPMarkStarV.h
//  StarDemo
//
//  Created by WangZhipeng on 16/4/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BlockScore)(NSNumber *data);

@interface ZPMarkStarV : UIView

/**
 *  初始化分数
 */
@property (nonatomic, assign) CGFloat initScore;
/**
 *  支持分数为小数
 */
@property (nonatomic, assign) BOOL supportDecimal; //是否支持触摸选择小数(默认为NO)
/**
 *  初始化
 *
 *  @param size   星星图片的大小
 *  @param space  星星图片的间隔
 *  @param number 星星图片的大小
 *
 *  @return ZPMarkStarV
 */
- (instancetype)initWithStarSize:(CGSize)size
                           space:(CGFloat)space
                    numberOfStar:(NSInteger)number;

- (void)setScore:(BlockScore)Score;

@end
