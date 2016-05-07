//
//  RootTBVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@interface RootTBVM : BaseVM

@property (strong, nonatomic) NSString *itemTitle;
@property (strong, nonatomic) NSString *itemImageNameSelect;
@property (strong, nonatomic) NSString *ItemimageNameUnSelect;

- (instancetype)initItemTitle:(NSString *)itemTitle
          itemImageNameSelect:(NSString *)itemImageNameSelect
        ItemimageNameUnSelect:(NSString *)ItemimageNameUnSelect;

+ (NSString *)backgroudImageName;

+ (NSArray *)arrayRootTBVMs;

@end
