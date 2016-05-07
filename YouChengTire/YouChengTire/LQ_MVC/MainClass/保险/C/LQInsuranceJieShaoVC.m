//
//  LQInsuranceJieShaoVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/28.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQInsuranceJieShaoVC.h"

@interface LQInsuranceJieShaoVC ()

@end

@implementation LQInsuranceJieShaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"详情";
    
    UIWebView *web = [[UIWebView alloc] init];
    web.backgroundColor = [UIColor whiteColor];
    web.scrollView.showsVerticalScrollIndicator = NO;
    web.scrollView.showsHorizontalScrollIndicator =NO;
    [self.view addSubview:web];
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlStr]];
    [web loadRequest:urlRequest];
    
    web.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
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
