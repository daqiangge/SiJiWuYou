//
//  MeVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "MeVM.h"
// Cells
#import "MeCell.h"

@implementation MeVM

#pragma mark - Override
- (void)initialize {
    [super initialize];
    self.title = @"我";
}

#pragma mark - Public
- (NSArray *)cellArray {
    
    MeFirstCell *cell_01 = [MeFirstCell createCell];
    UserM *userM = [UserM getUserM];
    if (userM) {
        cell_01.dictionary = @{
                               @"kUserDetailsM" : userM.userDetailsM
                               };
    }
    else {
        cell_01.dictionary = @{
                               @"kMethod" : @"login"
                               };
    }

    MeSecondCell *cell_02 = [MeSecondCell createCell];
    cell_02.dictionary = @{};
    
    MeThirdCell *cell_03 = [MeThirdCell createCell];
    cell_03.dictionary = @{
                           @"kTitle" : @"我的钱包",
                           @"kLogoImage" : @"me_cell_other_01",
                           @"kMethod" : @"myWallet"
                           };
    
    MeFourthCell *cell_04 = [MeFourthCell createCell];
    cell_04.dictionary = @{
                           @"kTitle" : @"车辆管理",
                           @"kLogoImage" : @"me_cell_other_02",
                           @"kMethod" : @"vehicleManager"
                           };
    
    MeFourthCell *cell_05 = [MeFourthCell createCell];
    cell_05.dictionary = @{
                           @"kTitle" : @"收货地址",
                           @"kLogoImage" : @"me_cell_other_03",
                           @"kMethod" : @"receiptAddress"
                           };
    
    /**
     *  WangZhipeng 隐藏邀请好友 Start 20160430
    MeFourthCell *cell_06 = [MeFourthCell createCell];
    cell_06.dictionary = @{
                           @"kTitle" : @"邀请好友",
                           @"kLogoImage" : @"me_cell_other_04",
                           @"kMethod" : @"inviteFriends"
                           };
     *  WangZhipeng 隐藏邀请好友 End 20160430
     */
    
    NSArray *sectionArray_01 = @[
                                 cell_01,
                                 cell_02,
                                 cell_03,
                                 cell_04,
                                 cell_05
//                                 cell_06
                                 ];
    
    MeFifthCell *cell_07 = [MeFifthCell createCell];
    cell_07.dictionary = @{
                           @"kTitle" : @"客服中心",
                           @"kLogoImage" : @"me_cell_other_05",
                           @"kMethod" : @"callCenter"
                           };
    
    MeFourthCell *cell_08 = [MeFourthCell createCell];
    cell_08.dictionary = @{
                           @"kTitle" : @"意见反馈",
                           @"kLogoImage" : @"me_cell_other_06",
                           @"kMethod" : @"feedback"
                           };
    
    
    NSArray *sectionArray_02 = @[
                                 cell_07,
                                 cell_08
                                 ];
    
    return @[
             sectionArray_01,
             sectionArray_02
             ];
    
}

@end
