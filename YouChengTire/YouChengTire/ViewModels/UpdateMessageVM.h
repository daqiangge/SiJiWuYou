//
//  UpdateMessageVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@interface UpdateMessageVM : BaseVM

+ (void)requestUpdateMessage:(void (^)(id object))success
                       error:(void (^)(NSError *error))error
                     failure:(void (^)(NSError *error))failure
                  completion:(void (^)(void))completion;

@end
