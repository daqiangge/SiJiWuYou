//
//  NetInfoCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/14.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"
#import "BaseV.h"

@interface NetInfoCell : BaseCell

- (NSString *)sysPointType;

@end

@interface NetInfoItemView : BaseV

@property (nonatomic, strong) SysType *sysType;

@property (nonatomic, weak) IBOutlet UIView *view;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *label;

@property (nonatomic, assign) BOOL isSelect;

@end
