//
//  RegisterCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/3.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"

@protocol RegisterCellDelegate <NSObject>

- (void)uRegister;

@end

@interface RegisterCell : BaseCell

@property (weak, nonatomic) id<RegisterCellDelegate> delegate;

@end
