//
//  LQInsuranceDetailVC.h
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVC.h"

typedef void(^deleteOrderSuccess)();

@interface LQInsuranceDetailVC : BaseVC

@property (nonatomic, copy) deleteOrderSuccess deleteOrderSuccess;

@property (nonatomic, copy) NSString *_id;

@end
