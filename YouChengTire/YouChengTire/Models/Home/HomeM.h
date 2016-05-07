//
//  HomeM.h
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@class HomePictureM;
@class HomeInfoM;

@interface HomeM : BaseM

@property (nullable, nonatomic, copy) NSArray<HomePictureM *> *pictureList1;
@property (nullable, nonatomic, copy) NSArray<HomePictureM *> *pictureList2;
@property (nullable, nonatomic, copy) NSArray<HomeInfoM *> *infoList;
// 资讯
@property (nullable, nonatomic, copy) NSString *infoMore;
// 社区
@property (nullable, nonatomic, copy) NSString *communityUrl;
// 附近周边
@property (nullable, nonatomic, copy) NSString *nearUrl;

@end

@interface HomePictureM : BaseM

@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *path;
@property (nullable, nonatomic, copy) NSString *sort;
@property (nullable, nonatomic, copy) NSString *target;

@end

@interface HomeInfoM : BaseM

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *photo;
@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSString *sId;
@property (nullable, nonatomic, copy) NSString *isHot;
@property (nullable, nonatomic, copy) NSString *path;

@end
