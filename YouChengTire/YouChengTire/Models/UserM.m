//
//  UserM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "UserM.h"

#define kUserM          @"UserM"
#define kCurrentVersion @"CurrentVersion"

@implementation UserM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sysUserTypeArray" : @"sys_user_type",
             @"sysPointTypeArray" : @"sys_point_type",
             @"sysMessageTypeArray" : @"sys_message_type",
             @"userKey" : @"userKey",
             @"userDetailsM" : @"user"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"sysUserTypeArray" : [SysType class],
             @"sysPointTypeArray" : [SysType class],
             @"sysMessageTypeArray" : [SysType class]
             };
}

+ (void)setUserM:(UserM *)userM {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userM];
    [userDefaults setObject:data
                     forKey:kUserM];
    [userDefaults synchronize];
}

+ (UserM *)getUserM {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults
                    objectForKey:kUserM];
    UserM *userM = nil;
    if (data) {
        userM = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return userM;
}

+ (void)logout {
    [UserM setUserM:nil];
}

+ (BOOL)isShowGuide {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *currentVersion = [userDefaults objectForKey:kCurrentVersion];
    return ![currentVersion isEqualToString:[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]];
}

+ (void)updateVersion {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]
                     forKey:kCurrentVersion];
    [userDefaults synchronize];
}

@end

@implementation UserDetailsM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"loginName" : @"loginName",
             @"mobile" : @"mobile",
             @"name" : @"name",
             @"appPhoto" : @"appPhoto",
             @"province" : @"province",
             @"city" : @"city",
             @"county" : @"county",
             @"address" : @"address",
             @"userType" : @"userType",
             @"inviteCode" : @"inviteCode",
             @"photo" : @"photo",
             @"status" : @"status",
             @"remarks" : @"remarks",
             @"roleNames" : @"roleNames",
             @"messageCount" : @"messageCount",
             @"point" : @"point"
             };
}

@end

@implementation PointM

@end

@implementation SysType

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"label" : @"label",
             @"value" : @"value",
             @"type" : @"type",
             @"sort" : @"sort"
             };
}

@end