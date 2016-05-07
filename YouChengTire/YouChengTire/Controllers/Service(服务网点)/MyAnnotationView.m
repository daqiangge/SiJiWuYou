//
//  MyAnnotationView.m
//  YouChengTire
//
//  Created by Baby on 16/3/9.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "MyAnnotationView.h"

@implementation MyAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBounds:CGRectMake(0.f, 0.f, 32.f, 32.f)];
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        _annotationImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _annotationImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_annotationImageView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAnnotation)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)clickAnnotation{
    if (_delegate && [_delegate respondsToSelector:@selector(showMsgWithAnonotation:)]) {
        [_delegate showMsgWithAnonotation:_customAnnotation];
    }
}

@end
