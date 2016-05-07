//
//  LQOrderClaimsCell1.h
//  YouChengTire
//
//  Created by liqiang on 16/4/25.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^textFieldDidChange)(NSString *str);

@interface LQOrderClaimsCell1 : UITableViewCell

@property (nonatomic, copy) textFieldDidChange textFieldDidChange;

@property (nonatomic, copy) NSString *pingPaiStr;
+ (LQOrderClaimsCell1 *)cellWithTableView:(UITableView *)tableView;
@end
