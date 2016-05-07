//
//  EditAddressVM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/10.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"
// Models
#import "receiptAddressM.h"

@interface EditAddressVM : BaseVM

@property (nonatomic, strong) ReceiptAddressItemM *receiptAddressItemM;

@property (nonatomic, weak) UIViewController *viewController;

/**
 * 编辑收货地址
 */
- (void)requestEditAddress:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion;

@end
