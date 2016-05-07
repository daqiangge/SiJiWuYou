//
//  ZPMarkStarV.m
//  StarDemo
//
//  Created by WangZhipeng on 16/4/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "ZPMarkStarV.h"
// Views
#import "ZPStarV.h"

@interface ZPMarkStarV()

@property (nullable, nonatomic, strong) NSMutableArray *starVArray;
@property (nullable, nonatomic, copy) BlockScore score;

@end

@implementation ZPMarkStarV

#pragma mark - Override
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self handleTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self handleTouches:touches];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self handleTouches:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self handleTouches:touches];
    if (_score) {
        CGFloat percent = 0.f;
        for (ZPStarV *starV in _starVArray) {
            percent = percent + starV.percent;
        }
        _score(@(percent));
    }
}

#pragma mark - Public
- (instancetype)initWithStarSize:(CGSize)size space:(CGFloat)space numberOfStar:(NSInteger)number {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        _starVArray = @[].mutableCopy;
        self.frame = CGRectMake(0,
                                0,
                                size.width * number + (number - 1) * space,
                                size.height);
        for (int i = 0; i < number; i ++) {
            ZPStarV *starV = [[ZPStarV alloc] initWithFrame:CGRectMake((space + size.width) * i,
                                                                       0,
                                                                       size.width,
                                                                       size.height)];
            starV.percent = 1.0;
            starV.backgroundColor = [UIColor clearColor];
            [self addSubview:starV];
            [_starVArray addObject:starV];
        }
    }
    return self;
}

#pragma mark - Private
- (void)handleTouches:(NSSet *)touches{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    ZPStarV *starV = nil;
    for (ZPStarV *tempStarV in _starVArray) {
        if (tempStarV.frame.origin.x <= point.x
            && tempStarV.frame.origin.x + tempStarV.frame.size.width >= point.x) {
            starV = tempStarV;
            break;
        }
    }
    if (!starV) {
        return;
    }
    NSInteger index = [_starVArray indexOfObject:starV];
    for (int i = 0; i < _starVArray.count; i ++) {
        ZPStarV *tempStarV = _starVArray[i];
        if (i < index) {
            tempStarV.percent = 1.0;
        }else if(i > index){
            tempStarV.percent = 0.0;
        }else{
            if(_supportDecimal){
                CGFloat percent = (point.x - starV.frame.origin.x) / starV.frame.size.width;
                starV.percent = percent;
            }else{
                starV.percent = 1.0;
            }
            
        }
    }
}

#pragma mark - Custom Accessors
- (void)setInitScore:(CGFloat)initScore {
    _initScore = initScore;
    if (initScore >= _starVArray.count) {
        _initScore = _starVArray.count;
    }else if(initScore <= 0){
        _initScore = 0;
    }
    NSInteger index = (NSInteger)_initScore;
    ZPStarV *starV = (index == _starVArray.count) ? nil : _starVArray[index];
    for (int i = 0; i < _starVArray.count; i ++) {
        ZPStarV *tempStarV = _starVArray[i];
        if (i < index) {
            tempStarV.percent = 1.0;
        }else if(i > index){
            tempStarV.percent = 0.0;
        }else{
            CGFloat percent = _initScore - index;
            starV.percent = percent;
        }
    }
}

@end
