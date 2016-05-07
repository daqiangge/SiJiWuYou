//
//  PeccancyCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/3.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "PeccancyCell.h"

@interface PeccancyCell ()

@property (nonatomic, copy) BlockQuery query;
@property (nonatomic, copy) BlockRecord record;

@end

@implementation PeccancyCell

#pragma mark - Static Public
+ (CGFloat)height { return 336.f; }

#pragma mark - Event Response
- (IBAction)query:(id)sender {
    _query();
}

- (IBAction)record:(id)sender {
    _record();
}

#pragma mark - Custom Accessors
- (void)setQuery:(BlockQuery)query {
    _query = query;
}

- (void)setRecord:(BlockRecord)record {
    _record = record;
}

@end
