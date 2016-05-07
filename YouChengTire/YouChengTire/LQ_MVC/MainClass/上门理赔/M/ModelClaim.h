//
//  ModelClaim.h
//  YouChengTire
//
//  Created by liqiang on 16/4/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReceiptAddressM.h"

@interface ModelClaim : NSObject

@property (nonatomic, copy) NSString *brand;
@property (nonatomic, copy) NSString *claimDate;
@property (nonatomic, copy) NSString *_description;
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *pattern;
@property (nonatomic, copy) NSString *standard;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *tireNumber;
@property (nonatomic, copy) NSString *visitStatus;
@property (nonatomic, strong) ReceiptAddressItemM *address;
@property (nonatomic, strong) NSArray *pictureList;

@end
