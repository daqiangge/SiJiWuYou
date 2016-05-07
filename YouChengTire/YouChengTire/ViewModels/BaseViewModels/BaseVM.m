//
//  BaseVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/9.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@interface BaseVM ()

@end

@implementation BaseVM

- (instancetype)init {
    if(self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {}

/**
 * 创建AppKey
 */
+ (NSString *)createAppKey:(NSDictionary *)dictionary {
    NSArray *valueArray = dictionary.allValues;
    valueArray = [valueArray sortedArrayUsingSelector:@selector(compare:)];
    UserM *userM = [UserM getUserM];
    NSMutableString *compare = @"".mutableCopy;
    for (NSString *string in valueArray) {
        [compare appendString:string];
    }
    [compare appendString:userM.userKey];
    return [NSString stringWithFormat:@"%@%@", userM.userKey, [compare encryptSHA1]];
}

@end
