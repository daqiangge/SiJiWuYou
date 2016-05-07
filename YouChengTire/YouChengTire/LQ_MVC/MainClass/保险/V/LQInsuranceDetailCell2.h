//
//  LQInsuranceDetailCell2.h
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didTapImageView1)(UIImageView *imageview1);
typedef void(^didTapImageView2)(UIImageView *imageview2);

@interface LQInsuranceDetailCell2 : UITableViewCell

@property (nonatomic, copy) didTapImageView1 didTapImageView1;
@property (nonatomic, copy) didTapImageView2 didTapImageView2;

@property (nonatomic, weak) UIImageView *imageView1;
@property (nonatomic, weak) UIImageView *imageView2;
+ (LQInsuranceDetailCell2 *)cellWithTableView:(UITableView *)tableView;

@end
