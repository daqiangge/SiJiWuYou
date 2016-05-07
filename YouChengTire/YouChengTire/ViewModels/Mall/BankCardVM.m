//
//  BankCardVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/21.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BankCardVM.h"

@implementation BankCardVM

#pragma mark - Override
- (void)initialize {
    self.title = @"选择银行卡";
    _isFirstNumber = @YES;
}

#pragma mark - Public
- (void)switchFirst {
    if (![_isFirstNumber boolValue]) {
        self.isFirstNumber = @YES;
    }
}

- (void)switchSecond {
    if ([_isFirstNumber boolValue]) {
        self.isFirstNumber = @NO;
    }
}

@end
