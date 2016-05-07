//
//  MyAnnotationView.h
//  YouChengTire
//
//  Created by Baby on 16/3/9.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

@protocol MyAnnotationViewDelegate <NSObject>
- (void)showMsgWithAnonotation:(MyAnnotation *)annotation;
@end

@interface MyAnnotationView : MKAnnotationView
@property (nonatomic, assign) id<MyAnnotationViewDelegate> delegate;
@property (nonatomic, strong) MyAnnotation * customAnnotation;
@property (nonatomic, strong) UIImageView *annotationImageView;
@end
