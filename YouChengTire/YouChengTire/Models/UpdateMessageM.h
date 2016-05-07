//
//  UpdateMessageM.h
//  YouChengTire
//  更新信息
//  Created by WangZhipeng on 16/4/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@interface UpdateMessageM : BaseM

@property (nullable, nonatomic, copy) NSString *sId;
@property (nullable, nonatomic, copy) NSString *createDate;
@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *appName;
@property (nullable, nonatomic, copy) NSString *packageName;
@property (nullable, nonatomic, copy) NSString *versionCode;
@property (nullable, nonatomic, copy) NSString *versionName;
@property (nullable, nonatomic, copy) NSString *apkUrl;
@property (nullable, nonatomic, copy) NSString *changeLog;
@property (nullable, nonatomic, copy) NSString *updateTips;
@property (nullable, nonatomic, copy) NSString *isForced;

@end
