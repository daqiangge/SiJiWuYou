//
//  InstallMethodVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/21.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@interface InstallMethodVM : BaseVM
/**
 *  0 : 上门安装
 *  1 : 自行安装
 *  2 : 定点自提
 */
@property (strong, nonatomic) NSNumber *pickedUpTypeNumber;

@property (nonatomic, strong) NSString *belongAddress;

@end
