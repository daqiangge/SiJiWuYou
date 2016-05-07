//
//  GoodsClassifyCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/15.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"

@protocol GoodsClassifyCellDelegate <NSObject>

- (void)didSelectType:(NSString *)type;

@end

@interface GoodsClassifyCell : BaseCell

@property (nonatomic, weak) id<GoodsClassifyCellDelegate> delegate;

@end
