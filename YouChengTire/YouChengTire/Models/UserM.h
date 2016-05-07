//
//  UserM.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseM.h"

@class SysType;
@class UserDetailsM;
@class PointM;

@interface UserM : BaseM

@property (nullable, nonatomic, strong) NSArray<SysType *> *sysUserTypeArray;
@property (nullable, nonatomic, strong) NSArray<SysType *> *sysPointTypeArray;
@property (nullable, nonatomic, strong) NSArray<SysType *> *sysMessageTypeArray;

@property (nullable, nonatomic, copy) NSString *userKey;

@property (nullable, nonatomic, strong) UserDetailsM *userDetailsM;

+ (void)setUserM:(UserM * _Nullable)userM;

+ (UserM * _Nullable)getUserM;

+ (void)logout;

+ (BOOL)isShowGuide;
+ (void)updateVersion;

@end

@interface UserDetailsM : BaseM

/**
 *  用户编号
 */
@property (nullable, nonatomic, copy) NSString *sId;
/**
 * 登录名，用户名
 */
@property (nullable, nonatomic, copy) NSString *loginName;
/**
 * 手机号码
 */
@property (nullable, nonatomic, copy) NSString *mobile;
/**
 * 会员姓名或服务网点简称
 */
@property (nullable, nonatomic, copy) NSString *name;
/**
 * 固定电话
 */
@property (nullable, nonatomic, copy) NSString *phone;
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
@property (nullable, nonatomic, copy) NSString *address;
/**
 * 用户类别，单选，使用“sys_user_type”的键值
 */
@property (nullable, nonatomic, copy) NSString *userType;
/**
 * 邀请码
 */
@property (nullable, nonatomic, copy) NSString *inviteCode;
/**
 * 头像路径
 */
@property (nullable, nonatomic, copy) NSString *appPhoto;
/**
 * 审核状态，1表示审核通过，0表示审核未通过
 */
@property (nullable, nonatomic, copy) NSString *status;
/**
 * 审核不通过的原因
 */
@property (nullable, nonatomic, copy) NSString *remarks;
/**
 * 角色名称
 */
@property (nullable, nonatomic, copy) NSString *roleNames;
/**
 * 未读的消息数量
 */
@property (nullable, nonatomic, copy) NSString *messageCount;
/**
 *  网点信息
 */
@property (nullable, nonatomic, strong) PointM *point;

@end

@interface PointM : BaseM
/**
 *  网点类别，多选，使用“sys_point_type”的键值，使用,拼接
 */
@property (nullable, nonatomic, strong) NSString *type;
/**
 *  网点全名
 */
@property (nullable, nonatomic, strong) NSString *name;
/**
 *  网点联系人
 */
@property (nullable, nonatomic, strong) NSString *contact;
/**
 *  网点联系电话
 */
@property (nullable, nonatomic, strong) NSString *phone;
/**
 *  经营品牌
 */
@property (nullable, nonatomic, strong) NSString *brand;
/**
 *  救援范围
 */
@property (nullable, nonatomic, strong) NSString *scope;
/**
 *  救援价格
 */
@property (nullable, nonatomic, strong) NSString *charge;
/**
 *  经度
 */
@property (nullable, nonatomic, strong) NSString *lng;
/**
 *  纬度
 */
@property (nullable, nonatomic, strong) NSString *lat;
/**
 *  网点位置，使用百度坐标使用“,”拼接
 */
@property (nullable, nonatomic, strong) NSString *position;
/**
 *  省内运费
 */
@property (nullable, nonatomic, strong) NSString *freightPrice;
/**
 *  省内安装费
 */
@property (nullable, nonatomic, strong) NSString *setupPrice;

@end

@interface SysType : BaseM
/**
 *  键
 */
@property (nullable, nonatomic, copy) NSString *label;
/**
 *  值
 */
@property (nullable, nonatomic, copy) NSString *value;
/**
 *  类型
 */
@property (nullable, nonatomic, copy) NSString *type;
/**
 *  排序
 */
@property (nullable, nonatomic, copy) NSString *sort;

@end
