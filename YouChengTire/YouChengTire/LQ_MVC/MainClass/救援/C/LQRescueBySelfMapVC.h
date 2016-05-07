//
//  LQRescueBySelfMapVC.h
//  YouChengTire
//
//  Created by liqiang on 16/4/21.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVC.h"

@interface LQRescueBySelfMapVC : BaseVC

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
