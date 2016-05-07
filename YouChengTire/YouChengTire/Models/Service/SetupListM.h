//
//  SetupListM.h
//  YouChengTire
//
//  Created by Baby on 16/4/12.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@interface SetupListM : BaseM
@property (nonatomic, strong) NSArray *setupList;
@end

@class SetupListOrderM;
@interface SetupListItemM : BaseM
@property (nonatomic, copy) NSString *belongId;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *setupDate;
@property (nonatomic, copy) NSString *status;
@property  SetupListOrderM * order;
@end

@class SetupListAdressM;
@interface SetupListOrderM : BaseM
@property (nonatomic, copy) NSString *belongAddress;
@property (nonatomic, copy) NSString *belongId;
@property (nonatomic, copy) NSString *belongName;
@property (nonatomic, copy) NSString *belongPosition;
@property (nonatomic, copy) NSString *codPrice;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *freightPrice;
@property (nonatomic, copy) NSString *sId;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *onlinePrice;
@property (nonatomic, copy) NSString *payment;
@property (nonatomic, copy) NSString *productPrice;
@property (nonatomic, copy) NSString *setup;
@property (nonatomic, copy) NSString *setupPrice;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *totalPrice;
@property SetupListAdressM * address;
@end

@interface SetupListAdressM : BaseM
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *county;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *sId;
@property (nonatomic, copy) NSString *isDefault;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *startDate;
@end



