//
//  OrderAddRemarkVM.m
//  YouChengTire
//  商品添加评论
//  Created by WangZhipeng on 16/4/25.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderAddRemarkVM.h"

@implementation OrderAddRemarkVM

#pragma mark - Override
- (void)initialize {
    self.title = @"晒单评价";
    
    _imageMutableArray = @[].mutableCopy;
    _validPlaceholderSignal = [[RACSignal
                                combineLatest:@[
                                                RACObserve(self, remark)
                                                ]
                                reduce:^(NSString *remark) {
                                    return @(remark.length > 0);
                                    
                                }] distinctUntilChanged];
}

- (void)requestsaveComment:(void (^ _Nullable)(id _Nullable object))success
                     error:(void (^ _Nullable)(NSError * _Nullable error))error
                   failure:(void (^ _Nullable)(NSError * _Nullable error))failure
                completion:(void (^ _Nullable)(void))completion {
    NSMutableDictionary *parameters = @{
                                        @"content" : _remark,
                                        @"score" : _score,
                                        @"parentId" : _orderFrameM.sId
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
    [ZPHTTP wPost:@"/app/shop/comment/saveComment"
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

- (void)requestDeleteComment:(void (^ _Nullable)(id _Nullable object))success
                       error:(void (^ _Nullable)(NSError * _Nullable error))error
                     failure:(void (^ _Nullable)(NSError * _Nullable error))failure
                  completion:(void (^ _Nullable)(void))completion {
    NSMutableDictionary *parameters = @{
                                        }.mutableCopy;
    [parameters setObject:[BaseVM createAppKey:parameters]
                   forKey:@"appKey"];
    @weakify(self)
    [ZPHTTP wPost:@"/app/shop/comment/deleteComment"
       parameters:parameters
          success:^(NSDictionary *object) {
              @strongify(self)
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
                             kCell : @"OrderAddRemarkFirstCell",
                             kModel : orderFrameM
                             };
    [mCellArray addObject:data01];
    for (NSDictionary *dictionary in orderFrameM.productList) {
        NSDictionary *data02 = @{
                                 kCell : @"OrderAddRemarkSecondCell",
                                 kModel : dictionary
                                 };
        [mCellArray addObject:data02];
    }
    NSDictionary *data03 = @{
                             kCell : @"OrderAddRemarkThirdCell"
                             };
    [mCellArray addObject:data03];
    return mCellArray;
}

@end
