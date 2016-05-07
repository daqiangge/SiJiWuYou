//
//  OrderRemarkM.h
//  YouChengTire
//  订单评论
//  Created by WangZhipeng on 16/4/25.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@class RemarkPictureM;

@interface OrderRemarkM : BaseM

/**
 *  评论人名称
 */
@property (nullable, nonatomic, copy) NSString *userName;
/**
 *  内容
 */
@property (nullable, nonatomic, copy) NSString *content;
/**
 *  评分
 */
@property (nullable, nonatomic, copy) NSString *score;
/**
 *  图片列表
 */
@property (nullable, nonatomic, copy) NSArray<RemarkPictureM *> *pictureList;
/**
 *  子评论
 */
@property (nullable, nonatomic, copy) NSArray<OrderRemarkM *> *childList;

@end

@interface RemarkPictureM : BaseM
/**
 *  图片路径
 */
@property (nullable, nonatomic, copy) NSString *appPath;
/**
 *  编号
 */
@property (nullable, nonatomic, copy) NSString *sId;
/**
 *  编号
 */
@property (nullable, nonatomic, copy) NSString *targetId;
/**
 *  创建时间
 */
@property (nullable, nonatomic, copy) NSString *createDate;

@end
