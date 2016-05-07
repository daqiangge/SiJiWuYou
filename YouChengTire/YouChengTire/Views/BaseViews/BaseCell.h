//
//  BaseCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell

@property (strong, nonatomic) NSDictionary *dictionary;

+ (instancetype)createCell;

+ (NSArray *)loadNibNamed:(NSString *)name;

+ (instancetype)nibItem:(NSString *)nibName;

- (void)selfInitialize;

- (void)configureCell:(id)model;

- (void)bindViewModel:(id)viewModel;

- (CGFloat)height;

@end
