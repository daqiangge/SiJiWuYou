//
//  LQVisitingInstallDetailsVC.h
//  YouChengTire
//
//  Created by liqiang on 16/4/28.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVC.h"

typedef void(^deleteOrderSuccess)();

@interface LQVisitingInstallDetailsVC : BaseVC

@property (nonatomic, copy) deleteOrderSuccess deleteOrderSuccess;

@property (nonatomic, copy) NSString *orderID;
@end
