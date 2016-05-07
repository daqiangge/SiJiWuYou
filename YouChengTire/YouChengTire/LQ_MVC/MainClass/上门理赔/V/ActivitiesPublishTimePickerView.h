//
//  ActivitiesPublishTimePickerView.h
//  WaterMan
//
//  Created by liqiang on 16/1/14.
//  Copyright © 2016年 baichun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^didEnsureDate)(NSString *dateStr,NSDate *date);

@interface ActivitiesPublishTimePickerView : UIView

@property (nonatomic, copy) didEnsureDate didEnsureDate;

@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;

@property (nonatomic, strong) NSDate *date;

- (void)returnDateStr:(didEnsureDate)block;

- (void)showMyPicker;

@end
