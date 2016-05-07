//
//  SetupVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "SetupVM.h"
// Cells
#import "SetupCell.h"

@implementation SetupVM

#pragma mark - Override
- (void)initialize {
    [super initialize];
    self.title = @"设置";
}

#pragma mark - Public
- (NSArray *)cellArray {
    
    SetupFirstCell *cell_01 = [SetupFirstCell createCell];
    cell_01.dictionary = @{
                           @"kTitle" : @"个人资料",
                           @"kLogoImage" : @"setup_cell_logo01",
                           @"kMethod" : @"personalData"
                           };
    
    SetupFirstCell *cell_02 = [SetupFirstCell createCell];
    cell_02.dictionary = @{
                           @"kTitle" : @"修改密码",
                           @"kLogoImage" : @"setup_cell_logo02",
                           @"kMethod" : @"changePwd"
                           };
    
    NSArray *sectionArray_01 = @[
                                 cell_01,
                                 cell_02
                                 ];
    
    SetupFirstCell *cell_03 = [SetupFirstCell createCell];
    cell_03.dictionary = @{
                           @"kTitle" : @"清除缓存",
                           @"kLogoImage" : @"setup_cell_logo03",
                           @"kMethod" : @"clearCache"
                           };
    
    NSArray *sectionArray_02 = @[
                                 cell_03
                                 ];
    
    SetupFirstCell *cell_04 = [SetupFirstCell createCell];
    cell_04.dictionary = @{
                           @"kTitle" : @"关于我们",
                           @"kLogoImage" : @"setup_cell_logo04",
                           @"kMethod" : @"aboutUs"
                           };
    
    SetupFirstCell *cell_05 = [SetupFirstCell createCell];
    cell_05.dictionary = @{
                           @"kTitle" : @"鼓励一下吧",
                           @"kLogoImage" : @"setup_cell_logo05",
                           @"kMethod" : @"encourage"
                           };
    
    NSArray *sectionArray_03 = @[
                                 cell_04,
                                 cell_05
                                 ];
    
    SetupSecondCell *cell_06 = [SetupSecondCell createCell];
    cell_06.dictionary = @{
                           @"kTitle" : @"退出登录",
                           @"kMethod" : @"logout"
                           };
    
    NSArray *sectionArray_04 = @[
                                 cell_06
                                 ];
    
    if ([UserM getUserM]) {
        return @[
                 sectionArray_01,
                 sectionArray_02,
                 sectionArray_03,
                 sectionArray_04
                 ];
    }
    else {
        return @[
                 sectionArray_01,
                 sectionArray_02,
                 sectionArray_03
                 ];
    }
}

@end
