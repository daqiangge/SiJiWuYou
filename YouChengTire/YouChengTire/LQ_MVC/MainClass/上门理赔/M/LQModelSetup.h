//
//  LQModelSetup.h
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LQModelOrder.h"

@interface LQModelSetup : NSObject

@property (nonatomic, copy) NSString *belongId;
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *setupDate;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) LQModelOrder *order;

@end
