//
//  LoginCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/3.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"

@protocol LoginCellDelegate <NSObject>

- (void)login;
- (void)uRegister;
- (void)forgetPwd;
- (void)loginByMobile;

@end

@interface LoginCell : BaseCell

@property (weak, nonatomic) id<LoginCellDelegate> delegate;

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface LoginFirstCell : LoginCell

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface LoginSecondCell : LoginCell

@end