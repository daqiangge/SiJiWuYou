//
//  OrderAfterSalesVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/5/1.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderAfterSalesVM.h"
// Models
#import "ReceiptAddressM.h"

@interface OrderAfterSalesVM ()

@property (nullable, nonatomic, strong, readwrite) NSDateFormatter *dateFormatter;

@end

@implementation OrderAfterSalesVM

#pragma mark - Override
- (void)initialize {
    self.title = @"申请售后";
    
    _imageMutableArray = @[].mutableCopy;
    _validPlaceholderSignal = [[RACSignal
                                combineLatest:@[
                                                RACObserve(self, remark)
                                                ]
                                reduce:^(NSString *remark) {
                                    return @(remark.length > 0);
                                    
                                }] distinctUntilChanged];
}

- (void)requestSaveClaim:(void (^ _Nullable)(id _Nullable object))success
                   error:(void (^ _Nullable)(NSError * _Nullable error))error
                 failure:(void (^ _Nullable)(NSError * _Nullable error))failure
              completion:(void (^ _Nullable)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"description" : _remark,
                                        @"addressId" : _serviceAddress.sId,
                                        @"orderId" : _orderFrameM.sId
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    NSMutableArray *fileInfos = @[].mutableCopy;
    for (UIImage *fileImage in _imageMutableArray) {
        NSDictionary *fileInfoDictionary = @{
                                             @"kFileData" : UIImageJPEGRepresentation(fileImage, 0.1),
                                             @"kName" : @"files",
                                             @"kFileName" : @"file.jpg",
                                             @"kMimeType" : @"file"
                                             };
        [fileInfos addObject:fileInfoDictionary];
    }
    [ZPHTTP wPost:@"/app/service/claim/saveClaim"
       parameters:parameters
        fileInfos:fileInfos
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
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

- (void)setOrderFrameM:(OrderFrameM *)orderFrameM {
    _orderFrameM = orderFrameM;
    self.array = [self configureCell:orderFrameM];
}

- (NSArray *)configureCell:(OrderFrameM *)orderFrameM {
    NSMutableArray *mCellArray = @[].mutableCopy;
    NSDictionary *data01 = @{
                             kCell : @"OrderAfterSalesFirstCell",
                             kModel : orderFrameM
                             };
    [mCellArray addObject:data01];
    for (NSDictionary *dictionary in orderFrameM.productList) {
        NSDictionary *data02 = @{
                                 kCell : @"OrderAfterSalesSecondCell",
                                 kModel : dictionary
                                 };
        [mCellArray addObject:data02];
    }
    NSDictionary *data03 = @{
                             kCell : @"OrderAfterSalesThirdCell"
                             };
    [mCellArray addObject:data03];
    return mCellArray;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [NSDateFormatter new];
        [_dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [_dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return _dateFormatter;
}

@end
