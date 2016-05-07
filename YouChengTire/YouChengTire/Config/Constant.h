//
//  Constant.h
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/9.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define ZPRootViewController    [[[[UIApplication sharedApplication] delegate] window] rootViewController]
#define ZPRootView              [ZPRootViewController view]

#define kScreenWidth    ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight   ([UIScreen mainScreen].bounds.size.height)

#define kClearColor     [UIColor clearColor]

#define kUserDefault    [NSUserDefaults standardUserDefaults]

#define kIOSVersion             [[[UIDevice currentDevice] systemVersion] floatValue]
#define kCurrentSystemVersion   [[UIDevice currentDevice] systemVersion]
/**
 *  设备屏幕尺寸
 */
#define kDeviceIsiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDeviceIsiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDeviceIsiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDeviceIsiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDeviceIsiPhone6PlusEnlarge ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)

#define RGB(r, g, b)        [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

#define GETIMAGE(name) [UIImage imageNamed:[NSString stringWithFormat:@"%@", name]]

#define GET_VIEW_WIDTH(view)  view.frame.size.width
#define GET_VIEW_HEIGHT(view) view.frame.size.height
#define GET_VIEW_X(view)      view.frame.origin.x
#define GET_VIEW_Y(view)      view.frame.origin.y

#define STRING_NOT_EMPTY(string)              (string && (string.length > 0))
#define ARRAY_NOT_EMPTY(array)                (array && (array.count > 0))

#ifdef ENABLE_ASSERT_STOP
#define APP_ASSERT_STOP                     {LogRed(@"APP_ASSERT_STOP"); NSAssert1(NO, @" \n\n\n===== APP Assert. =====\n%s\n\n\n", __PRETTY_FUNCTION__);}
#define APP_ASSERT(condition)               {NSAssert(condition, @" ! Assert");}
#else
#define APP_ASSERT_STOP                     do {} while (0);
#define APP_ASSERT(condition)               do {} while (0);
#endif

#define kCheckPhoneNumber       @"^1[3|4|5|7|8][0-9]\\d{8}$"
#define kCheckEmail             @"^([a-zA-Z0-9_\\.\\-])+\\@(([a-zA-Z0-9\\-])+\\.)+([a-zA-Z0-9]{2,4})+$"

#define kCell                   @"kCell"
#define kModel                  @"kModel"
#define kTitle                  @"kTitle"
#define kKey                    @"kKey"
#define kValue                  @"kValue"
#define kUrl                    @"kUrl"
#define kMethod                 @"kMethod"
#define kParameter              @"kParameter"
#define kENum                   @"kENum"
#define kType                   @"kType"
#define kArray                  @"kArray"
#define kColor                  @"kColor"

#endif /* Constant_h */
