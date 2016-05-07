//
//  OrderTicketVM.h
//  YouChengTire
//  订单减免
//  Created by WangZhipeng on 16/4/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseVM.h"

typedef NS_ENUM(NSUInteger, OrderTicketType) {
    OrderCurrencyTicket = 2,
    OrderDiscountTicket = 3
};

@interface OrderTicketVM : BaseVM

@property (nonatomic, assign, readonly) OrderTicketType orderTicketType;
@property (nullable, nonatomic, copy) NSString *belongId;

- (void)requestGetUsableTicketList:(void (^ _Nullable)(id _Nullable object))success
                             error:(void (^ _Nullable)(NSError * _Nullable error))error
                           failure:(void (^ _Nullable)(NSError * _Nullable error))failure
                        completion:(void (^ _Nullable)(void))completion;

@end

@interface OrderCurrencyTicketVM : OrderTicketVM

@end

@interface OrderDiscountTicketVM : OrderTicketVM

@end


