//
//  LQHeader.h
//  YouChengTire
//
//  Created by liqiang on 16/4/20.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#ifndef LQHeader_h
#define LQHeader_h

#define Window [[UIApplication sharedApplication].delegate window]

//hex颜色
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]

#define COLOR_LightGray HEXCOLOR(0xEFEFF4)//浅灰（输入提示文字）

#import "MBProgressHUD+LQHUD.h"
#import "IQKeyboardManager.h"
#import "LCActionSheet.h"
#import "BaseVM.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIAlertView+Blocks.h"
#import "LCActionSheet.h"
#import "NSDate+TimeStamp.h"
#import "NSDate+Category.h"

#endif /* LQHeader_h */
