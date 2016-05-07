//
//  BaseV.m
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/9.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "BaseV.h"

@implementation BaseV

+ (id)nibItem:(NSString *)nibName {
    Class TypeClass = [self class];
    __autoreleasing id item = nil;
    NSArray *pArr_xib = [[NSBundle mainBundle] loadNibNamed:nibName
                                                      owner:nil
                                                    options:nil];
    for (UIView *v in pArr_xib) {
        if ([v isKindOfClass:TypeClass]) {
            item = v;
            break;
        }
    }
    
    if (item) {
        if ([item respondsToSelector:@selector(selfInitialize)]) {
            [item selfInitialize];
        }
    }
    return item;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self selfInitialize];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self selfInitialize];
    }
    return self;
}

- (void)selfInitialize {}

@end
