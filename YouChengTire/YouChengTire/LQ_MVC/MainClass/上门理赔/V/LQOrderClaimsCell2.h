//
//  LQOrderClaimsCell2.h
//  YouChengTire
//
//  Created by liqiang on 16/4/25.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^textFieldDidChange)(NSString *str);

@interface LQOrderClaimsCell2 : UITableViewCell

@property (nonatomic, copy) textFieldDidChange textFieldDidChange;

@property (nonatomic, copy) NSString *huaWenStr;
+ (LQOrderClaimsCell2 *)cellWithTableView:(UITableView *)tableView;
@end
