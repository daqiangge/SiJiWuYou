//
//  FeedbackCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/4.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"

@protocol FeedbackCellDelegate <NSObject>

- (void)feedback;

@end

@interface FeedbackCell : BaseCell

@property (weak, nonatomic) id<FeedbackCellDelegate> delegate;

@end
