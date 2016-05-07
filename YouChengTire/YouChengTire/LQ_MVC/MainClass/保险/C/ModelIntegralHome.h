//
//  ModelIntegralHome.h
//  YouChengTire
//
//  Created by liqiang on 16/4/28.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LQModelGift.h"
#import "LQModelIntegralHomeImage.h"
#import "LQModelIntergralHometype.h"

@interface ModelIntegralHome : NSObject

@property (nonatomic, strong) NSArray *giftList;
@property (nonatomic, strong) NSArray *imageList;
@property (nonatomic, strong) NSArray *typeList;

@end
