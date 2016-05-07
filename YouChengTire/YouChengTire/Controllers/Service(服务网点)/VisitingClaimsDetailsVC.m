//
//  VisitingClaimsDetailsVC.m
//  YouChengTire
//
//  Created by Baby on 16/4/14.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "VisitingClaimsDetailsVC.h"

@interface VisitingClaimsDetailsVC ()

@end

@implementation VisitingClaimsDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1.0f;
    }
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
