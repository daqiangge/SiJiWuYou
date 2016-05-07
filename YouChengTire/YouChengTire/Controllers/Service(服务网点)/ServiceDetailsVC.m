//
//  ServiceDetailsVC.m
//  YouChengTire
//
//  Created by Baby on 16/2/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "ServiceDetailsVC.h"
#import "RootTBC.h"

@interface ServiceDetailsVC ()

@end


@implementation ServiceDetailsVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [(RootTBC *)ZPRootViewController setTabBarHidden:YES
                                            animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [(RootTBC *)ZPRootViewController setTabBarHidden:NO
                                            animated:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)backButtonClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.0f;
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


#pragma mark -
#pragma mark ================= 网络请求 =================
- (void)requestServiceDetail
{
    
}


@end
