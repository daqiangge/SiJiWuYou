//
//  LQModelGiftList.h
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LQModelGift.h"
#import "ReceiptAddressM.h"

@interface LQModelGiftList : NSObject

@property (nonatomic, strong) LQModelGift *gift;
@property (nonatomic, strong) ReceiptAddressItemM *address;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *totalPrice;

@end
