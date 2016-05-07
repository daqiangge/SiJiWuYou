//
//  PublishRescueVC.h
//  YouChengTire
//
//  Created by duwen on 16/4/4.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVC.h"

@interface PublishRescueVC : BaseVC

@property (nonatomic, copy) NSString *rescueID;

/**
 *  经纬度
 */
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *lat;


@end
