//
//  RescueVC.m
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "RescueVC.h"

@interface RescueVC()

@end

@implementation RescueVC

- (void)viewDidLoad{
    [super viewDidLoad];
}

#pragma mark - Override
- (void)configureView {
    self.title = @"一键救援";
}

- (void)bindViewModel {}

- (void)configureData {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"一键救援"
                                          message:@"工作时间: 8:30~21:00"
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"呼叫"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [[UIApplication sharedApplication]
                                                            openURL:[NSURL URLWithString:@"tel:400-820-9686"]];
                                                       }];
    [alertController addAction:callAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

@end
