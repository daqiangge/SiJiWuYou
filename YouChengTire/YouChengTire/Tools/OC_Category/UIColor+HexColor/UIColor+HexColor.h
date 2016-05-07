//
//  UIColor+HexColor.h
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HEXCOLOR(hex) [UIColor colorWithHexString:hex alpha:1]

@interface UIColor (HexColor)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
