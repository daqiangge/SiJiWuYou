//
//  LQInsuranceSuccessVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/28.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQInsuranceSuccessVC.h"
#import "LQInsuranceListVC.h"

@interface LQInsuranceSuccessVC ()

@end

@implementation LQInsuranceSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)gotoBaoXianListVC:(id)sender {
    LQInsuranceListVC *vc = [[LQInsuranceListVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
