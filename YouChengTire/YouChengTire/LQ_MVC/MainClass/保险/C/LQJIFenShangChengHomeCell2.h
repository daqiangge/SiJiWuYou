//
//  LQJIFenShangChengHomeCell2.h
//  YouChengTire
//
//  Created by liqiang on 16/4/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickBtn1)();
typedef void(^clickBtn2)();
typedef void(^clickBtn3)();
typedef void(^clickBtn4)();

@interface LQJIFenShangChengHomeCell2 : UITableViewCell

@property (nonatomic, copy) clickBtn1 clickBtn1;
@property (nonatomic, copy) clickBtn2 clickBtn2;
@property (nonatomic, copy) clickBtn3 clickBtn3;
@property (nonatomic, copy) clickBtn4 clickBtn4;

+ (LQJIFenShangChengHomeCell2 *)cellWithTableView:(UITableView *)tableView;

@end
