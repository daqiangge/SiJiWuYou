//
//  MBProgressHUD+LQHUD.h
//  WaterMan
//
//  Created by liqiang on 16/1/13.
//  Copyright © 2016年 baichun. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>
#define TIPS_DELAY_TIME_NORMAL    2

@interface MBProgressHUD (LQHUD)

+ (void)showErrorHUDAddedToView:(UIView *)view errorStr:(NSString *)errorStr animated:(BOOL)animated showTime:(NSTimeInterval)time;

+ (void)showErrorHUDAddedToWindowWithErrorStr:(NSString *)errorStr animated:(BOOL)animated showTime:(NSTimeInterval)time;

+ (void)showSuccsessHUDAddedToView:(UIView *)view successStr:(NSString *)successStr animated:(BOOL)animated showTime:(NSTimeInterval)time;

+ (void)showSuccsessHUDAddedToWindowWithSuccessStr:(NSString *)successStr animated:(BOOL)animated showTime:(NSTimeInterval)time;

+ (void)showLoadingHUDAddedToView:(UIView *)view tipStr:(NSString *)tipStr animated:(BOOL)animated;

+ (void)showLoadingHUDAddedToWindowWithTipStr:(NSString *)tipStr animated:(BOOL)animated;
+(void)showTipsHiddenFromView:(UIView *)view;


+ (void)showTipsHiddenFromWindowWithTipStr;
@end
