//
//  RescueBySelfDetailsVC.h
//  YouChengTire
//
//  Created by duwen on 16/4/15.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVC.h"
#import "NearbyPointM.h"

@interface RescueBySelfDetailsVC : BaseVC
@property (nonatomic, strong) NearbyPointItemM * np;

@property (nonatomic, copy) NSString *rescueId;

@end
