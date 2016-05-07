//
//  LQModelUser.h
//  YouChengTire
//
//  Created by liqiang on 16/4/23.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LQModelPoint;

@interface LQModelUser : NSObject

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *appPhoto;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *county;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *inviteCode;
@property (nonatomic, copy) NSString *loginName;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *roleNames;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, copy) NSString *validateCode;
@property (nonatomic, strong) LQModelPoint *point;

@end
