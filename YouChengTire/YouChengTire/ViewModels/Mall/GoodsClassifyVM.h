//
//  GoodsClassifyVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/15.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@interface GoodsClassifyVM : BaseVM

- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion;

@end
