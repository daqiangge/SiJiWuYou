//
//  SaveRescueM.h
//  YouChengTire
//
//  Created by Baby on 16/4/6.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@class SaveRescuePointM;
@interface SaveRescueM : BaseM
@property (nonatomic , copy) NSString * sId;
@property (nonatomic , copy) NSString * userId;
@property (nonatomic , copy) NSString * number;
@property (nonatomic , copy) NSString * paymentType;
@property (nonatomic , copy) NSString * type;
@property (nonatomic , copy) NSString * province;
@property (nonatomic , copy) NSString * city;
@property (nonatomic , copy) NSString * county;
@property (nonatomic , copy) NSString * detail;
@property (nonatomic , copy) NSString * lng;
@property (nonatomic , copy) NSString * lat;
@property (nonatomic , copy) NSString * desc;
@property (nonatomic , copy) NSString * price;
@property SaveRescuePointM * saveRescuePointM;
@property NSArray * pictureList;
@end

@interface SaveRescuePointM : BaseM

@property (nonatomic , copy) NSString * sId;
@property (nonatomic , copy) NSString * name;
@property (nonatomic , copy) NSString * contact;
@property (nonatomic , copy) NSString * phone;
@property (nonatomic , copy) NSString * brand;
@property (nonatomic , copy) NSString * scope;
@property (nonatomic , copy) NSString * charge;
@property (nonatomic , copy) NSString * province;
@property (nonatomic , copy) NSString * city;
@property (nonatomic , copy) NSString * county;
@property (nonatomic , copy) NSString * address;
@property (nonatomic , copy) NSString * lng;
@property (nonatomic , copy) NSString * lat;
@property (nonatomic , copy) NSString * distance;
@end

@interface SaveRescuePicM : BaseM
@property (nonatomic , copy) NSString * path;
@property (nonatomic , copy) NSString * targetId;
@end