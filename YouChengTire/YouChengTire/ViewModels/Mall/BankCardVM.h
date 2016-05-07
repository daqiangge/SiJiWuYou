//
//  BankCardVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/21.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@interface BankCardVM : BaseVM

@property (strong, nonatomic) NSNumber *isFirstNumber;

- (void)switchFirst;
- (void)switchSecond;

@end
