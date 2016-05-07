//
//  MyAnnotation.m
//  YouChengTire
//
//  Created by Baby on 16/3/9.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

-(id)initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle
                subTitle:(NSString *)paramSubitle
{
    self = [super init];
    if(self != nil)
    {
        _coordinate = paramCoordinates;
        _title = paramTitle;
        _subtitle = paramSubitle;
    }
    return self;
}

@end
