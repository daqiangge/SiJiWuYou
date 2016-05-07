//
//  PersonalDataVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "PersonalDataVM.h"
// Cells
#import "PersonalDataCell.h"
// Models
#import "UserM.h"

static NSString *const kPersonalDataFirstCellIdentifier = @"PersonalDataFirstCell";
static NSString *const kPersonalDataSecondCellIdentifier = @"PersonalDataSecondCell";
static NSString *const kPersonalDataThirdCellIdentifier = @"PersonalDataThirdCell";
static NSString *const kPersonalDataFourthCellIdentifier = @"PersonalDataFourthCell";

@interface PersonalDataVM ()

@property (nonatomic, strong, readwrite) NSNumber *isReloadDataSuccess;

@end

@implementation PersonalDataVM

#pragma mark - Override
- (void)initialize {
    self.title = @"个人资料";
    
    _userDetailsM = [UserM getUserM].userDetailsM;
    _isReloadDataSuccess = @NO;
}

#pragma mark - Public
- (void)requestgetUser:(void (^)(id object))success
                 error:(void (^)(NSError *error))error
               failure:(void (^)(NSError *error))failure
            completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{}.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    [ZPHTTP wPost:@"/app/sys/user/getUser"
       parameters:parameters
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  UserM *tempUserM = [UserM yy_modelWithDictionary:object[@"data"]];
                  UserM *userM = [UserM getUserM];
                  userM.userDetailsM = tempUserM.userDetailsM;
                  [UserM setUserM:userM];
                  
                  self.userDetailsM = tempUserM.userDetailsM;
                  self.isReloadDataSuccess = @YES;
                  
                  success(nil);
                  completion();
              }
              else {
                  NSInteger errnoInteger = [object[@"msgCode"] integerValue];
                  NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : object[@"msg"] };
                  NSError *uError = [NSError errorWithDomain:@"ZPCustom"
                                                        code:errnoInteger
                                                    userInfo:userInfo];
                  error(uError);
                  completion();
              }
          } failure:^(NSError *error) {
              failure(error);
              completion();
          }];
}

- (void)requestUpdateUser:(void (^)(id object))success
                    error:(void (^)(NSError *error))error
                  failure:(void (^)(NSError *error))failure
               completion:(void (^)(void))completion {
    /**
     @"loginName" : _userDetailsM.loginName,
     @"mobile" : _userDetailsM.mobile,
     @"name" : @"王志鹏",
     @"phone" : @"40004-91360",
     @"province" : @"江苏省",
     @"city" : @"南京市",
     @"county" : @"雨花台区",
     @"address" : @"软件大道180号",
     @"userType" : _userDetailsM.userType,
     @"point.type" : @"40,41,afe851215c8f44a2974fe235193ccc4f",
     @"point.name" : @"ComcSoft",
     @"point.contact" : @"王志鹏",
     @"point.phone" : @"18955529166",
     @"point.brand" : @"Comc",
     @"point.scope" : @"任意范围",
     @"point.charge" : @"1000起",
     @"point.lng" : @"0",
     @"point.lat" : @"0",
     @"point.position" : @"0,0",
     @"point.freightPrice" : @"20",
     @"point.setupPrice" : @"100"
     **/
    NSMutableDictionary *parameters = @{
                                        @"loginName" : _userDetailsM.loginName,
                                        @"mobile" : _userDetailsM.mobile,
                                        @"name" : _userDetailsM.name,
                                        @"phone" : _userDetailsM.phone,
                                        @"province" : _userDetailsM.province,
                                        @"city" : _userDetailsM.city,
                                        @"county" : _userDetailsM.county,
                                        @"address" : _userDetailsM.address,
                                        @"userType" : _userDetailsM.userType,
                                        @"point.type" : _userDetailsM.point.type ? _userDetailsM.point.type : @"",
                                        @"point.name" : _userDetailsM.point.name ? _userDetailsM.point.name : @"",
                                        @"point.contact" : _userDetailsM.point.contact ? _userDetailsM.point.contact : @"",
                                        @"point.phone" : _userDetailsM.point.phone ? _userDetailsM.point.phone : @"",
                                        @"point.brand" : _userDetailsM.point.brand ? _userDetailsM.point.brand : @"",
                                        @"point.scope" : _userDetailsM.point.scope ? _userDetailsM.point.scope : @"",
                                        @"point.charge" : _userDetailsM.point.charge ? _userDetailsM.point.charge : @"",
                                        @"point.lng" : _userDetailsM.point.lng ? _userDetailsM.point.lng : @"",
                                        @"point.lat" : _userDetailsM.point.lat ? _userDetailsM.point.lat : @"",
                                        @"point.position" : _userDetailsM.point.position ? _userDetailsM.point.position : @"",
                                        @"point.freightPrice" : _userDetailsM.point.freightPrice ? _userDetailsM.point.freightPrice : @"",
                                        @"point.setupPrice" : _userDetailsM.point.setupPrice ? _userDetailsM.point.setupPrice : @""
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    [ZPHTTP wPost:@"/app/sys/user/updateUser"
       parameters:parameters
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
//                  UserM *tempUserM = [UserM yy_modelWithDictionary:object[@"data"]];
//                  UserM *userM = [UserM getUserM];
//                  userM.userDetailsM = tempUserM.userDetailsM;
//                  [UserM setUserM:userM];
//                  
//                  self.userDetailsM = tempUserM.userDetailsM;
                  
                  success(nil);
              }
              else {
                  NSInteger errnoInteger = [object[@"msgCode"] integerValue];
                  NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : object[@"msg"] };
                  NSError *uError = [NSError errorWithDomain:@"ZPCustom"
                                                        code:errnoInteger
                                                    userInfo:userInfo];
                  error(uError);
                  completion();
              }
          } failure:^(NSError *error) {
              failure(error);
              completion();
          }];
}

- (void)requestUpdateUserWithPhoto:(void (^)(id object))success
                             error:(void (^)(NSError *error))error
                           failure:(void (^)(NSError *error))failure
                        completion:(void (^)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"loginName" : _userDetailsM.loginName,
                                        @"mobile" : _userDetailsM.mobile,
                                        @"name" : _userDetailsM.name,
                                        @"phone" : _userDetailsM.phone,
                                        @"province" : _userDetailsM.province,
                                        @"city" : _userDetailsM.city,
                                        @"county" : _userDetailsM.county,
                                        @"address" : _userDetailsM.address,
                                        @"userType" : _userDetailsM.userType,
                                        @"point.type" : _userDetailsM.point.type ? _userDetailsM.point.type : @"",
                                        @"point.name" : _userDetailsM.point.name ? _userDetailsM.point.name : @"",
                                        @"point.contact" : _userDetailsM.point.contact ? _userDetailsM.point.contact : @"",
                                        @"point.phone" : _userDetailsM.point.phone ? _userDetailsM.point.phone : @"",
                                        @"point.brand" : _userDetailsM.point.brand ? _userDetailsM.point.brand : @"",
                                        @"point.scope" : _userDetailsM.point.scope ? _userDetailsM.point.scope : @"",
                                        @"point.charge" : _userDetailsM.point.charge ? _userDetailsM.point.charge : @"",
                                        @"point.lng" : _userDetailsM.point.lng ? _userDetailsM.point.lng : @"",
                                        @"point.lat" : _userDetailsM.point.lat ? _userDetailsM.point.lat : @"",
                                        @"point.position" : _userDetailsM.point.position ? _userDetailsM.point.position : @"",
                                        @"point.freightPrice" : _userDetailsM.point.freightPrice ? _userDetailsM.point.freightPrice : @"",
                                        @"point.setupPrice" : _userDetailsM.point.setupPrice ? _userDetailsM.point.setupPrice : @""
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    NSDictionary *fileInfoDictionary = nil;
    if (_fileImage) {
        fileInfoDictionary = @{
                               @"kFileData" : UIImageJPEGRepresentation(_fileImage, 0.1),
                               @"kName" : @"file",
                               @"kFileName" : @"file.jpg",
                               @"kMimeType" : @"file"
                               };
    }
    [ZPHTTP wPost:@"/app/sys/user/updateUserWithPhoto"
       parameters:parameters
         fileInfo:fileInfoDictionary
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
//                  UserM *tempUserM = [UserM yy_modelWithDictionary:object[@"data"]];
//                  UserM *userM = [UserM getUserM];
//                  userM.userDetailsM = tempUserM.userDetailsM;
//                  [UserM setUserM:userM];
//                  
//                  self.userDetailsM = tempUserM.userDetailsM;
                  
                  success(nil);
              }
              else {
                  NSInteger errnoInteger = [object[@"msgCode"] integerValue];
                  NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : object[@"msg"] };
                  NSError *uError = [NSError errorWithDomain:@"ZPCustom"
                                                        code:errnoInteger
                                                    userInfo:userInfo];
                  error(uError);
                  completion();
              }
          } failure:^(NSError *error) {
              failure(error);
              completion();
          }];
}

@end
