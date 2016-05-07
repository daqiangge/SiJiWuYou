//
//  UserPointM.h
//  YouChengTire
//
//  Created by Baby on 16/4/5.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@interface UserPointM : BaseM
@property (nonatomic, strong) NSArray *pointList;
@end

@interface UserPointItemM : BaseM
@property (nonatomic, copy) NSString * sId;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * contact;
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * brand;
@property (nonatomic, copy) NSString * scope;
@property (nonatomic, copy) NSString * charge;
@property (nonatomic, copy) NSString * lng;
@property (nonatomic, copy) NSString * lat;
@property (nonatomic, copy) NSString * province;
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * county;
@property (nonatomic, copy) NSString * detail;
@property (nonatomic, copy) NSString * distance;
@end
