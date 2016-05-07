//
//  PeccancyCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/3.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"

typedef void(^BlockQuery)();
typedef void(^BlockRecord)();

@interface PeccancyCell : BaseCell

+ (CGFloat)height;

/**
 *  立即查询
 *
 *  @param query query description
 */
- (void)setQuery:(BlockQuery)query;
/**
 *  查看历史记录
 *
 *  @param query query description
 */
- (void)setRecord:(BlockRecord)record;

@end

