//
//  OrderAfterSalesVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/5/1.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"
// Models
#import "OrderFrameM.h"

@class ReceiptAddressItemM;

@interface OrderAfterSalesVM : BaseVM

@property (nonnull, nonatomic, strong) OrderFrameM *orderFrameM;

@property (nullable, nonatomic, strong) NSString *remark;
@property (nullable, nonatomic, strong, readonly) RACSignal *validPlaceholderSignal;
@property (nullable, nonatomic, strong) NSString *serviceDate;
@property (nullable, nonatomic, strong, readonly) NSDateFormatter *dateFormatter;
@property (nullable, nonatomic, strong) ReceiptAddressItemM *serviceAddress;
@property (nullable, nonatomic, strong) NSMutableArray<UIImage *> *imageMutableArray;

- (void)requestSaveClaim:(void (^ _Nullable)(id _Nullable object))success
                   error:(void (^ _Nullable)(NSError * _Nullable error))error
                 failure:(void (^ _Nullable)(NSError * _Nullable error))failure
              completion:(void (^ _Nullable)(void))completion;

@end
