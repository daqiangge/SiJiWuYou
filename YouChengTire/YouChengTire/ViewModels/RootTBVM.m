//
//  RootTBVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "RootTBVM.h"

@implementation RootTBVM

- (instancetype)initItemTitle:(NSString *)itemTitle
          itemImageNameSelect:(NSString *)itemImageNameSelect
        ItemimageNameUnSelect:(NSString *)ItemimageNameUnSelect {
    self = [super init];
    if (self) {
        // Custom initialization
        self.itemTitle = itemTitle;
        self.itemImageNameSelect = itemImageNameSelect;
        self.ItemimageNameUnSelect = ItemimageNameUnSelect;
    }
    return self;
}

+ (NSString *)backgroudImageName {
    return @"";
}

+ (NSArray *)arrayRootTBVMs {
    
    RootTBVM *rootTBVM_01 = [[RootTBVM alloc] initItemTitle:@"首页"
                                               itemImageNameSelect:@"root_tab_home_c"
                                             ItemimageNameUnSelect:@"root_tab_home"];
    
    RootTBVM *rootTBVM_02 = [[RootTBVM alloc] initItemTitle:@"一键救援"
                                               itemImageNameSelect:@"root_tab_rescue_c"
                                             ItemimageNameUnSelect:@"root_tab_rescue"];
    
    RootTBVM *rootTBVM_03 = [[RootTBVM alloc] initItemTitle:@"服务网点"
                                               itemImageNameSelect:@"root_tab_service_c"
                                             ItemimageNameUnSelect:@"root_tab_service"];
    
    RootTBVM *rootTBVM_04 = [[RootTBVM alloc] initItemTitle:@"我"
                                               itemImageNameSelect:@"root_tab_me_c"
                                             ItemimageNameUnSelect:@"root_tab_me"];
    
    return @[
             rootTBVM_01,
             rootTBVM_02,
             rootTBVM_03,
             rootTBVM_04
             ];
}

@end
