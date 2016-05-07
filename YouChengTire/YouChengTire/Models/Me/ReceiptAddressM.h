//
//  ReceiptAddressM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@class ReceiptAddressItemM;

@interface ReceiptAddressM : BaseM

@property (nullable, nonatomic, copy) NSArray<ReceiptAddressItemM *> *addressList;

@end

@interface ReceiptAddressItemM : BaseM

/**
 * 编号
 */
@property (nullable, nonatomic, copy) NSString *sId;
/**
 * 姓名
 */
@property (nullable, nonatomic, copy) NSString *name;
/**
 * 电话
 */
@property (nullable, nonatomic, copy) NSString *mobile;
/**
 * 省
 */
@property (nullable, nonatomic, copy) NSString *province;
/**
 * 市
 */
@property (nullable, nonatomic, copy) NSString *city;
/**
 * 区县
 */
@property (nullable, nonatomic, copy) NSString *county;
/**
 * 详细地址
 */
@property (nullable, nonatomic, copy) NSString *detail;
/**
 * 是否设置为默认，1：默认；0：不是默认
 */
@property (nullable, nonatomic, copy) NSString *isDefault;
/**
 *  创建时间
 */
@property (nullable, nonatomic, copy) NSString *createDate;
/**
 *  是否选中（非接口数据）
 */
@property (nullable, nonatomic, strong) NSNumber *isSelectNumber;

@end