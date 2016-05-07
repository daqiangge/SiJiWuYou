//
//  ReceiptAddressM.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "ReceiptAddressM.h"

@implementation ReceiptAddressM

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"addressList" : ReceiptAddressItemM.class
             };
}

@end

@implementation ReceiptAddressItemM

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"sId" : @"id",
             @"name" : @"name",
             @"mobile" : @"mobile",
             @"province" : @"province",
             @"city" : @"city",
             @"county" : @"county",
             @"detail" : @"detail",
             @"isDefault" : @"isDefault",
             @"createDate" : @"createDate"
             };
}



+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"sId":@"id"};
}

@end
