//
//  LQOrderClaimsCell.h
//  YouChengTire
//
//  Created by liqiang on 16/4/25.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickGuiGeBtn)();
typedef void(^clickXingHaoBtn)();

@interface LQOrderClaimsCell : UITableViewCell

@property (nonatomic, copy) clickGuiGeBtn clickGuiGeBtn;
@property (nonatomic, copy) clickXingHaoBtn clickXingHaoBtn;


@property (nonatomic, copy) NSString *guiGeStr;
@property (nonatomic, copy) NSString *guiGeStr2;

+ (LQOrderClaimsCell *)cellWithTableView:(UITableView *)tableView;

@end
