//
//  ZPAreasManager.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/4.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2

@interface ZPAreasManager : NSObject

@property (nonatomic, strong) NSDictionary *areaDic;
@property (nonatomic, strong) NSArray *province;
@property (nonatomic, strong) NSArray *city;
@property (nonatomic, strong) NSArray *district;

@property (nonatomic, strong) NSString *selectedProvince;

+ (instancetype)sharedManager;

@end
