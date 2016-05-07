//
//  LQOrderClaimsAddressDetailCell.h
//  YouChengTire
//
//  Created by liqiang on 16/4/25.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReceiptAddressM.h"

@interface LQOrderClaimsAddressDetailCell : UITableViewCell

@property (nonatomic, strong) ReceiptAddressItemM *model;

+ (LQOrderClaimsAddressDetailCell *)cellWithTableView:(UITableView *)tableView;
@end
