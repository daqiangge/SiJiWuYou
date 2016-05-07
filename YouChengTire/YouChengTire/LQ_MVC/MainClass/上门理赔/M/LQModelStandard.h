//
//  LQModelStandard.h
//  YouChengTire
//
//  Created by liqiang on 16/4/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQModelStandard : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *parentIds;
@property (nonatomic, strong) NSArray *childList;

@end
