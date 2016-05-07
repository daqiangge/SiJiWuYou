//
//  OrderClaimsVC.m
//  YouChengTire
//
//  Created by duwen on 16/4/5.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderClaimsVC.h"

@interface OrderClaimsVC ()

@end

@implementation OrderClaimsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请理赔";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
