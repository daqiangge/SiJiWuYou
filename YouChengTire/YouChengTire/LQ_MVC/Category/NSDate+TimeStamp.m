//
//  NSDate+TimeStamp.m
//  WaterMan
//
//  Created by liqiang on 15/12/3.
//  Copyright © 2015年 baichun. All rights reserved.
//

#import "NSDate+TimeStamp.h"

@implementation NSDate (TimeStamp)

+(NSDateComponents *)getDateComponents:(NSDate *)curTime{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps =[calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:curTime];
    return comps;
}

+ (NSString *)dateWithTimeStamp:(long long)timeStamp dateFormat:(NSString *)dateFormat
{
    NSDate *detaildate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:timeStamp];
    return [self dateStringWithTimeDate:detaildate dateFormat:dateFormat];
}

+ (NSString *)dateStringWithTimeDate:(NSDate *)timeDate dateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:dateFormat];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: timeDate];
    
    return currentDateStr;

}

+(NSString *)getDateTimeFormmatterStr:(NSString *)timeFormatStr date:(NSDate *)dateCompare{
    if (timeFormatStr &&![timeFormatStr isEqualToString:@""]) {
    }else{
        timeFormatStr=@"yyyy-MM-dd HH:mm:ss";
    }
    return [self dateStringWithTimeDate:dateCompare dateFormat:timeFormatStr];

}
/*获取yyyy.MM.dd hh:mm:ss格式的时间*/
+(NSString *)getTimeFormmatterStr:(NSString *)timeFormatStr time:(NSInteger)time{

    if (timeFormatStr &&![timeFormatStr isEqualToString:@""]) {
    }else{
        timeFormatStr=@"yyyy-MM-dd HH:mm:ss";
    }
    return [self dateWithTimeStamp:time dateFormat:timeFormatStr];
}

+(NSString *)getTimeFormmatterYMD:(NSInteger)time{
 
    return [self dateWithTimeStamp:time dateFormat:@"yyyy-MM-dd"];
}

+(NSString *)getTimeFormmatterYMD:(NSInteger)time timeFormmatterStr:(NSString *)timeFormatStr
{
    return [self dateWithTimeStamp:time dateFormat:timeFormatStr];
}

+(NSDate *)getDataWithTime:(int)timeValue{
    NSTimeInterval createTimeDouble=(double)timeValue;
  return [NSDate dateWithTimeIntervalSince1970:createTimeDouble];
}

+ (int)getDayWithDate:(NSDate *)t
{
    NSDateComponents *comps =[self getDateComponents:t];
    return (int)comps.day;

}

+ (int)getMonthWithDate:(NSDate *)t
{
    NSDateComponents *comps =[self getDateComponents:t];
    return (int)comps.month;
}

+ (int)getYearWithDate:(NSDate *)t
{
    NSDateComponents *comps =[self getDateComponents:t];
    return (int)comps.year;
}

+(NSDate *)getSpeicalWithday:(NSDate *)curTime dayBetween:(int)day monthBetween:(int)month  yearBetween:(int)year{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps =[calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:curTime];
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];
    return [calendar dateByAddingComponents:comps toDate:curTime options:0];
    
}

@end
