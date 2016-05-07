//
//  NSDate+TimeStamp.h
//  WaterMan
//
//  Created by liqiang on 15/12/3.
//  Copyright © 2015年 baichun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TimeStamp)

+ (NSString *)dateWithTimeStamp:(long long)timeStamp dateFormat:(NSString *)dateFormat;

+ (NSString *)dateStringWithTimeDate:(NSDate *)timeDate dateFormat:(NSString *)dateFormat;
+(NSDateComponents *)getDateComponents:(NSDate *)curTime;
+(NSString *)getDateTimeFormmatterStr:(NSString *)timeFormatStr date:(NSDate *)dateCompare;

/*获取yyyy.MM.dd hh:mm:ss格式的时间*/
+(NSString *)getTimeFormmatterStr:(NSString *)timeFormatStr time:(NSInteger)time;
+(NSString *)getTimeFormmatterYMD:(NSInteger)time;
+(NSString *)getTimeFormmatterYMD:(NSInteger)time timeFormmatterStr:(NSString *)timeFormatStr;
+(NSDate *)getDataWithTime:(int)timeValue;

+ (int)getDayWithDate:(NSDate *)t;
+ (int)getMonthWithDate:(NSDate *)t;
+ (int)getYearWithDate:(NSDate *)t;
+(NSDate *)getSpeicalWithday:(NSDate *)curTime dayBetween:(int)day monthBetween:(int)month  yearBetween:(int)year;

@end
