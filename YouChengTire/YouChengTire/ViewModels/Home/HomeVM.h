//
//  HomeVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"
// Models
#import "HomeM.h"

@interface HomeVM : BaseVM

@property (nullable, nonatomic, strong, readonly) HomeM *homeM;

- (void)requestRefreshData:(void (^ _Nullable)(id _Nullable object))success
                     error:(void (^ _Nullable)(NSError * _Nullable error))error
                   failure:(void (^ _Nullable)(NSError * _Nullable error))failure
                completion:(void (^ _Nullable)(void))completion;

@end
