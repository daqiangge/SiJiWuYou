//
//  ReceiptVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/23.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

@interface ReceiptVM : BaseVM

/**
 *  0 : 不开发票
 *  1 : 普通发票
 *  2 : 专用发票
 */
@property (strong, nonatomic) NSNumber *receiptTypeNumber;

@property (nonatomic, strong, readonly) NSDictionary *receiptDictionary;

@property (nonatomic, strong) NSString *sId;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *blank;
@property (nonatomic, strong) NSString *blankNumber;

- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion;

- (void)requestSaveReceipt:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion;

@end

