//
//  RescueM.h
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@interface RescueM : BaseM
@property (nonatomic, strong) NSArray *rescueList;
@end

@interface RescueItemM : BaseM
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * county;
@property (nonatomic, copy) NSString * createDate;
@property (nonatomic, copy) NSString * des;
@property (nonatomic, copy) NSString * detail;
@property (nonatomic, copy) NSString * endDate;
@property (nonatomic, copy) NSString * sId;
@property (nonatomic, copy) NSString * lat;
@property (nonatomic, copy) NSString * lng;
@property (nonatomic, copy) NSString * number;
@property (nonatomic, copy) NSString * paymentStatus;
@property (nonatomic, copy) NSString * paymentType;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * province;
@property (nonatomic, copy) NSString * startDate;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * type;
//@property (nonatomic, copy) NSString * point;
@end
