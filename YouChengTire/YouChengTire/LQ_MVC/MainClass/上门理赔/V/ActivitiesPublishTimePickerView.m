//
//  ActivitiesPublishTimePickerView.m
//  WaterMan
//
//  Created by liqiang on 16/1/14.
//  Copyright © 2016年 baichun. All rights reserved.
//

#import "ActivitiesPublishTimePickerView.h"

@interface ActivitiesPublishTimePickerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic)  UIDatePicker *datePicker;
@property (strong, nonatomic) UIView *maskView;

@property (nonatomic, weak) UIView *backgroundView;

@end

@implementation ActivitiesPublishTimePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        
        [self drawView];
    }
    
    return self;
}

- (void)drawView
{
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.3;
    [self addSubview:maskView];
    [maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePickerView)]];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 230)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundView];
    self.backgroundView = backgroundView;
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-50, 0, 50, 30)];
    [btn2 setTitle:@"确定" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:82/255. green:106/255. blue:165/255. alpha:1] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(ensure) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn2];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn1.frame)+5, self.frame.size.width, 1)];
    line.backgroundColor = [UIColor colorWithRed:229/255. green:229/255. blue:229/255. alpha:1];
    [backgroundView addSubview:line];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width, 200)];
    [backgroundView addSubview:datePicker];
    self.datePicker = datePicker;
}

- (void)showMyPicker
{
    [self.datePicker setDate:[NSDate date]];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundView.frame = CGRectMake(0, self.frame.size.height-230, self.frame.size.width, 230);
    }];
}

- (void)hidePickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 230);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)setDate:(NSDate *)date
{
    _date = date;
    
    if (date) {
        [self.datePicker setDate:date animated:NO];
    }
}

- (void)setMinDate:(NSDate *)minDate
{
    _minDate = minDate;
    
    if (minDate) {
        self.datePicker.minimumDate = minDate;
        self.datePicker.maximumDate = nil;
    }
}

- (void)setMaxDate:(NSDate *)maxDate
{
    _maxDate = maxDate;
    
    if (maxDate) {
        self.datePicker.maximumDate = maxDate;
        self.datePicker.minimumDate = nil;
    }
}

- (void)returnDateStr:(didEnsureDate)block
{
    self.didEnsureDate = block;
}

- (void)ensure
{
    NSDate *date = self.datePicker.date;
    NSString *dateStr = [NSDate getDateTimeFormmatterStr:@"yyyy-MM-dd" date:date];
    
    if (self.didEnsureDate != nil) {
        self.didEnsureDate(dateStr,date);
    }
    
    [self hidePickerView];
}

@end
