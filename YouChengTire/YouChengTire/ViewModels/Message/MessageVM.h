//
//  MessageVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@interface MessageVM : BaseVM

@property (strong, nonatomic, readonly) NSArray<NSDictionary *> *dataArray;

- (void)requestMessage:(void (^)(id object))success
                 error:(void (^)(NSError *error))error
               failure:(void (^)(NSError *error))failure
            completion:(void (^)(void))completion;

@end
