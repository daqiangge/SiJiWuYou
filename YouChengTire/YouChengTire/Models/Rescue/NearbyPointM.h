//
//  NearbyPointM.h
//  YouChengTire
//
//  Created by Baby on 16/4/5.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@interface NearbyPointM : BaseM
@property (nonatomic, strong) NSArray *pointList;
@end

@interface NearbyPointItemM : BaseM
@property (nonatomic, copy) NSString * sId;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString * province;
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * county;
@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSString * userType;
@property (nonatomic, copy) NSString * distance;
@property (nonatomic, copy) NSString * roleNames;
@property (nonatomic, copy) NSString * appPhoto;

@property (nonatomic, copy) NSString * p_type;
@property (nonatomic, copy) NSString * p_name;
@property (nonatomic, copy) NSString * p_contact;
@property (nonatomic, copy) NSString * p_phone;
@property (nonatomic, copy) NSString * p_brand;
@property (nonatomic, copy) NSString * p_scope;
@property (nonatomic, copy) NSString * p_charge;
@property (nonatomic, copy) NSString * p_position;
@property (nonatomic, copy) NSString * p_lng;
@property (nonatomic, copy) NSString * p_lat;
@property (nonatomic, copy) NSString * p_id;
@end
