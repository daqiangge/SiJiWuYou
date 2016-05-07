//
//  RescueBySelfListVC.h
//  YouChengTire
//
//  Created by Baby on 16/3/31.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVC.h"

@interface RescueBySelfListVC : BaseVC

/**
 *  经纬度
 */
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *lat;

/**
 *  救援信息id
 */
@property (nonatomic, copy) NSString *rescueId;

@end
