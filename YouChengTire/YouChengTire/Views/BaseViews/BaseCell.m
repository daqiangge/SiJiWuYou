//
//  BaseCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)createCell { return nil; }

+ (NSArray *)loadNibNamed:(NSString *)name {
    return [[NSBundle mainBundle] loadNibNamed:name
                                         owner:nil
                                       options:nil];
}

+ (instancetype)nibItem:(NSString *)nibName {
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

- (void)configureCell:(id)model {}

- (void)bindViewModel:(id)viewModel{}

- (CGFloat)height { return 0; }

- (void)setDictionary:(NSDictionary *)dictionary {
    _dictionary = dictionary;
}

@end
