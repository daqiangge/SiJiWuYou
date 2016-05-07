//
//  ForgetPWCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/3.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"

@protocol ForgetPWCellDelegate <NSObject>

- (void)forgetPW;

@end

@interface ForgetPWCell : BaseCell

@property (weak, nonatomic) id<ForgetPWCellDelegate> delegate;

@end
