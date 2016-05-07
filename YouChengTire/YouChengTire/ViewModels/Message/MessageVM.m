//
//  MessageVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "MessageVM.h"

@interface MessageVM ()

@property (strong, nonatomic, readwrite) NSArray<NSDictionary *> *dataArray;

@end

@implementation MessageVM

#pragma mark - Override
- (void)initialize {
    self.title = @"消息";
    _dataArray = [self dataArray];
}

#pragma mark - Public
- (void)requestMessage:(void (^)(id object))success
                 error:(void (^)(NSError *error))error
               failure:(void (^)(NSError *error))failure
            completion:(void (^)(void))completion {
    
}

#pragma mark - Private
- (NSArray *)dataArray {
    NSDictionary *data_01 = @{
                              @"kLogo" : @"me_cell_other_02",
                              @"kTitle" : @"商城",
                              @"kSubtitle" : @"新年新放送，好礼享不停！",
                              @"kDateTime" : @"10:08"
                              };
    NSDictionary *data_02 = @{
                              @"kLogo" : @"me_cell_other_03",
                              @"kTitle" : @"救援",
                              @"kSubtitle" : @"我需要紧急救援，在某某高速爆胎了！",
                              @"kDateTime" : @"2015.12.2"
                              };
    NSDictionary *data_03 = @{
                              @"kLogo" : @"me_cell_other_01",
                              @"kTitle" : @"钱包",
                              @"kSubtitle" : @"我需要紧急救援，在某某高速爆胎了！",
                              @"kDateTime" : @"2015.9.8"
                              };
    NSDictionary *data_04 = @{
                              @"kLogo" : @"me_cell_other_04",
                              @"kTitle" : @"系统",
                              @"kSubtitle" : @"我们的工作人员将在三个工作日内为您安排上门安装服务。",
                              @"kDateTime" : @"2015.8.5"
                              };
    NSDictionary *data_05 = @{
                              @"kLogo" : @"me_cell_other_05",
                              @"kTitle" : @"驰耐得轮胎无锡新区网点",
                              @"kSubtitle" : @"亲，我们将在2个工作日内为你送货上门，请注意查收。",
                              @"kDateTime" : @"2015.6.9"
                              };
    return @[
             data_01,
             data_02,
             data_03,
             data_04,
             data_05
             ];
}

@end
