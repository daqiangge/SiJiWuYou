//
//  BaseM.h
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/9.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseM : NSObject <NSCoding, NSCopying>

- (void)encodeWithCoder:(NSCoder *)aCoder;

- (id)initWithCoder:(NSCoder *)aDecoder;

- (id)copyWithZone:(NSZone *)zone;

- (NSUInteger)hash;

- (BOOL)isEqual:(id)object;

@end
