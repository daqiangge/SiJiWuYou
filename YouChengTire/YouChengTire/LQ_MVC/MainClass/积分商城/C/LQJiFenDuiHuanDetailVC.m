//
//  LQJiFenDuiHuanDetailVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQJiFenDuiHuanDetailVC.h"
#import "LQJiFenShengChengDingDanVC.h"

@interface LQJiFenDuiHuanDetailVC ()

@end

@implementation LQJiFenDuiHuanDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"详情";
    
    self.view.backgroundColor = COLOR_LightGray;
    
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawView
{
    UIWebView *web = [[UIWebView alloc] init];
    web.backgroundColor = [UIColor whiteColor];
    web.scrollView.showsVerticalScrollIndicator = NO;
    web.scrollView.showsHorizontalScrollIndicator =NO;
    [self.view addSubview:web];
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.model.detailUrl]];
    [web loadRequest:urlRequest];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"立即兑换" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = HEXCOLOR(0xFCC02D);
    [btn addTarget:self action:@selector(duiHuan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    web.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,60);
    
    btn.sd_layout
    .leftSpaceToView(self.view,15)
    .rightSpaceToView(self.view,15)
    .bottomSpaceToView(self.view,10)
    .heightIs(40);
}

- (void)duiHuan
{
    LQJiFenShengChengDingDanVC *vc = [[LQJiFenShengChengDingDanVC alloc] init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
