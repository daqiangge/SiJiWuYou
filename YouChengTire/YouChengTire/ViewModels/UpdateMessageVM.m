//
//  UpdateMessageVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "UpdateMessageVM.h"
// Models
#import "UpdateMessageM.h"

@implementation UpdateMessageVM

#pragma mark - Public
+ (void)requestUpdateMessage:(void (^)(id object))success
                       error:(void (^)(NSError *error))error
                     failure:(void (^)(NSError *error))failure
                  completion:(void (^)(void))completion {
    NSDictionary *parameters = @{
                                 @"type" : @"1"
                                 };
    [ZPHTTP wPost:@"/app/sys/init/getUpdateMessage"
       parameters:parameters
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  NSDictionary *data = object[@"data"];
                  UpdateMessageM *updateMessageM = [UpdateMessageM yy_modelWithDictionary:data[@"update"]];
                  // 服务版本号
                  float serviceVersionFloat = [updateMessageM.versionCode floatValue] * 100;
                  // 当前版本号
                  NSString *currentVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
                  float currentVersionFloat = [currentVersion floatValue] * 100;
                  if ([updateMessageM.isForced boolValue]
                      && serviceVersionFloat >= currentVersionFloat) {
                      MAIN(^{
                          UIAlertController *alertController = [UIAlertController alertControllerWithTitle:updateMessageM.updateTips
                                                                                                   message:updateMessageM.changeLog
                                                                                            preferredStyle:UIAlertControllerStyleAlert];
                          UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"立即更新"
                                                                                 style:UIAlertActionStyleDefault
                                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAppStore]];
                                                                               }];
                          [alertController addAction:updateAction];
                          [ZPRootViewController presentViewController:alertController
                                                             animated:YES
                                                           completion:nil];
                      });
                  }
                  success(nil);
                  completion();
              }
              else {
                  NSInteger errnoInteger = [object[@"msgCode"] integerValue];
                  NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : object[@"msg"] };
                  NSError *uError = [NSError errorWithDomain:@"ZPCustom"
                                                        code:errnoInteger
                                                    userInfo:userInfo];
                  error(uError);
                  completion();
              }
          } failure:^(NSError *error) {
              failure(error);
              completion();
          }];
}

@end
