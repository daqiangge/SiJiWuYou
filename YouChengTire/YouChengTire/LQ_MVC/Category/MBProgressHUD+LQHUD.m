//
//  MBProgressHUD+LQHUD.m
//  WaterMan
//
//  Created by liqiang on 16/1/13.
//  Copyright © 2016年 baichun. All rights reserved.
//

#import "MBProgressHUD+LQHUD.h"

@implementation MBProgressHUD (LQHUD)

+ (void)showErrorHUDAddedToView:(UIView *)view errorStr:(NSString *)errorStr animated:(BOOL)animated showTime:(NSTimeInterval)time
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"失败"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = errorStr;
    
    if (time)
    {
        [hud hide:YES afterDelay:time];
    }
}

+ (void)showErrorHUDAddedToWindowWithErrorStr:(NSString *)errorStr animated:(BOOL)animated showTime:(NSTimeInterval)time
{
    [MBProgressHUD showErrorHUDAddedToView:[[UIApplication sharedApplication].delegate window] errorStr:errorStr animated:animated showTime:time];
}

+ (void)showSuccsessHUDAddedToView:(UIView *)view successStr:(NSString *)successStr animated:(BOOL)animated showTime:(NSTimeInterval)time
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"成功"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = successStr;
    
    if (time)
    {
        [hud hide:YES afterDelay:time];
    }
}

+ (void)showSuccsessHUDAddedToWindowWithSuccessStr:(NSString *)successStr animated:(BOOL)animated showTime:(NSTimeInterval)time
{
    [MBProgressHUD showSuccsessHUDAddedToView:[[UIApplication sharedApplication].delegate window] successStr:successStr animated:animated showTime:time];
}


+ (void)showLoadingHUDAddedToView:(UIView *)view tipStr:(NSString *)tipStr animated:(BOOL)animated
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = tipStr;
}

+ (void)showLoadingHUDAddedToWindowWithTipStr:(NSString *)tipStr animated:(BOOL)animated
{
    [MBProgressHUD showLoadingHUDAddedToView:[[UIApplication sharedApplication].delegate window] tipStr:tipStr animated:animated];
}

+(void)showTipsHiddenFromView:(UIView *)view{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}


+ (void)showTipsHiddenFromWindowWithTipStr
{
    [MBProgressHUD showTipsHiddenFromView:[[UIApplication sharedApplication].delegate window]];
}

@end
