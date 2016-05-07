//
//  LQModelRescue.h
//  YouChengTire
//
//  Created by liqiang on 16/4/23.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LQModelPoint;
@class LQModelUser;

@interface LQModelRescue : NSObject

@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *county;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *_description;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *paymentStatus;
@property (nonatomic, copy) NSString *paymentType;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) LQModelPoint *point;
@property (nonatomic, strong) LQModelUser *user;
@property (nonatomic, strong) NSArray *pictureList;

@end
