//
//  ReceiptAddressVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@class ReceiptAddressItemM;

@interface ReceiptAddressVM : BaseVM

@property (nullable, nonatomic, strong) NSNumber *isEditNumber;
@property (nullable, nonatomic, strong) NSNumber *isSelectAllNumber;
@property (nullable, nonatomic, strong) NSArray<ReceiptAddressItemM *> *selectArray;

/**
 * 获取收货地址
 */
- (void)requestRefreshData:(void (^ _Nullable)(id _Nullable object))success
                     error:(void (^ _Nullable)(NSError * _Nullable error))error
                   failure:(void (^ _Nullable)(NSError * _Nullable error))failure
                completion:(void (^ _Nullable)(void))completion;

/**
 * 删除收货地址
 */
- (void)requestDeleteAddress:(void (^ _Nullable)(id _Nullable object))success
                       error:(void (^ _Nullable)(NSError * _Nullable error))error
                     failure:(void (^ _Nullable)(NSError * _Nullable error))failure
                  completion:(void (^ _Nullable)(void))completion;

- (NSArray * _Nullable)addLastOne:(NSArray * _Nullable)dataArray;
- (NSArray * _Nullable)removeLastOne:(NSArray * _Nullable)dataArray;

@end
