//
//  GetRescueM.h
//  YouChengTire
//
//  Created by Baby on 16/4/6.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@class GetRescuePointM;
@interface GetRescueM : BaseM
@property NSString * sId;
@property NSString * type;
@property NSString * userId;
@property NSString * province;
@property NSString * city;
@property NSString * county;
@property NSString * lng;
@property NSString * lat;
@property NSString * desc;
@property NSString * price;
@property GetRescuePointM * saveRescuePointM;
@property NSArray * pictureList;
@end

@interface GetRescuePointM : BaseM

@property NSString * sId;
@property NSString * name;
@property NSString * contact;
@property NSString * phone;
@property NSString * brand;
@property NSString * scope;
@property NSString * charge;
@property NSString * lng;
@property NSString * lat;
@property NSString * province;
@property NSString * city;
@property NSString * county;
@property NSString * address;
@property NSString * distance;
@end

@interface GetRescuePicM : BaseM
@property NSString * path;
@property NSString * targetId;
@end