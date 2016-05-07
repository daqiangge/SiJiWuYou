//
//  LQWoDeJiFengVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQWoDeJiFengVC.h"

@interface LQWoDeJiFengVC ()

@property (nonatomic, assign) NSInteger selectBtnIndex;
@property (nonatomic, strong) NSMutableArray  *tabArray;
@property (nonatomic, weak) UIView *selectLineView;
@property (nonatomic, weak) UIView *tabView;
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation LQWoDeJiFengVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的钱包";
    self.view.backgroundColor = COLOR_LightGray;
    
    [self drawView];
}

- (void)drawView
{
    UIView *tabView = [[UIView alloc] init];
    tabView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabView];
    self.tabView = tabView;
    
    tabView.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(40);
    
    self.tabArray = [NSMutableArray arrayWithArray:@[@"积分",@"现金券",@"优惠券"]];
    self.selectBtnIndex = 100;
    int i = 0;
    for (NSString *str in self.tabArray)
    {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:str forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(didClickTabBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = 100 + i;
        [tabView addSubview:btn];
        
        if (i == 0)
        {
            btn.selected = YES;
            
            btn.sd_layout
            .topSpaceToView(tabView,0)
            .leftSpaceToView(tabView,0)
            .bottomSpaceToView(tabView,2)
            .widthRatioToView(tabView,1/(float)(self.tabArray.count));
        }
        else
        {
            btn.selected = NO;
            
            UIButton *lastBtn = [self.view viewWithTag:btn.tag - 1];
            btn.sd_layout
            .topSpaceToView(tabView,0)
            .bottomSpaceToView(tabView,2)
            .leftSpaceToView(lastBtn,0)
            .widthRatioToView(tabView,1/(float)(self.tabArray.count));
        }
        
        i ++;
    }
    
    
    
    UIView *selectLineView = [[UIView alloc] init];
    selectLineView.backgroundColor = [UIColor orangeColor];
    [tabView addSubview:selectLineView];
    self.selectLineView = selectLineView;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    selectLineView.sd_layout
    .leftSpaceToView(tabView,0)
    .bottomSpaceToView(tabView,0)
    .heightIs(2)
    .widthRatioToView(tabView,1/(float)(self.tabArray.count));
    
    scrollView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(self.tabView,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    
    [self drawDetailView];
}

- (void)drawDetailView
{
    UIView *jiFengView = [[UIView alloc] init];
    jiFengView.backgroundColor = self.view.backgroundColor;
    [self.scrollView addSubview:jiFengView];
    
    UIView *labelBGV = [[UIView alloc] init];
    labelBGV.backgroundColor = [UIColor whiteColor];
    [jiFengView addSubview:labelBGV];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = [UIColor blackColor];
    label1.text = @"   可使用积分";
    [labelBGV addSubview:label1];
    
    UILabel *keYongJiFengLabel = [[UILabel alloc] init];
    keYongJiFengLabel.font = [UIFont systemFontOfSize:15];
    keYongJiFengLabel.textColor = [UIColor orangeColor];
    keYongJiFengLabel.text = @"分";
    keYongJiFengLabel.textAlignment = NSTextAlignmentRight;
    [labelBGV addSubview:keYongJiFengLabel];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_LightGray;
    [labelBGV addSubview:lineView];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.font = [UIFont systemFontOfSize:15];
    label2.textColor = [UIColor blackColor];
    label2.text = @"   已过期积分";
    [labelBGV addSubview:label2];
    
    UILabel *guoQiJiFengLabel = [[UILabel alloc] init];
    guoQiJiFengLabel.font = [UIFont systemFontOfSize:15];
    guoQiJiFengLabel.textColor = [UIColor blackColor];
    guoQiJiFengLabel.text = @"分";
    guoQiJiFengLabel.textAlignment = NSTextAlignmentRight;
    [labelBGV addSubview:guoQiJiFengLabel];
    
    jiFengView.sd_layout
    .topSpaceToView(self.scrollView,0)
    .leftSpaceToView(self.scrollView,0)
    .bottomSpaceToView(self.scrollView,0)
    .widthRatioToView(self.scrollView,1);
    
    labelBGV.sd_layout
    .topSpaceToView(jiFengView,10)
    .leftSpaceToView(jiFengView,0)
    .rightSpaceToView(jiFengView,0);
    
    label1.sd_layout
    .topSpaceToView(labelBGV,0)
    .leftSpaceToView(labelBGV,0)
    .widthIs(100)
    .heightIs(40);
    
    keYongJiFengLabel.sd_layout
    .topSpaceToView(labelBGV,0)
    .rightSpaceToView(labelBGV,10)
    .widthIs(200)
    .heightIs(40);
    
    lineView.sd_layout
    .topSpaceToView(label1,0)
    .rightSpaceToView(labelBGV,0)
    .leftSpaceToView(labelBGV,0)
    .heightIs(1);
    
    label2.sd_layout
    .topSpaceToView(lineView,0)
    .leftSpaceToView(labelBGV,0)
    .widthIs(100)
    .heightIs(40);
    
    guoQiJiFengLabel.sd_layout
    .topSpaceToView(lineView,0)
    .rightSpaceToView(labelBGV,10)
    .widthIs(200)
    .heightIs(40);
    
    [labelBGV setupAutoHeightWithBottomView:guoQiJiFengLabel bottomMargin:0];
    
    
    UIView *xianjinquanView = [[UIView alloc] init];
    xianjinquanView.backgroundColor = COLOR_LightGray;
    [self.scrollView addSubview:xianjinquanView];
    
    UIView *youhuiquanView = [[UIView alloc] init];
    youhuiquanView.backgroundColor = COLOR_LightGray;
    [self.scrollView addSubview:youhuiquanView];
    
    xianjinquanView.sd_layout
    .leftSpaceToView(jiFengView,0)
    .topSpaceToView(self.scrollView,0)
    .bottomSpaceToView(self.scrollView,0)
    .widthRatioToView(self.scrollView,1);
    
    youhuiquanView.sd_layout
    .leftSpaceToView(xianjinquanView,0)
    .topSpaceToView(self.scrollView,0)
    .bottomSpaceToView(self.scrollView,0)
    .widthRatioToView(self.scrollView,1);
}

/**
 *  点击了选项卡按钮
 */
- (void)didClickTabBtn:(UIButton *)btn
{
    UIButton *lastBtn = [self.view viewWithTag:self.selectBtnIndex];
    lastBtn.selected = NO;
    btn.selected = YES;
    self.selectBtnIndex = btn.tag;
    
    self.selectLineView.sd_resetLayout
    .leftEqualToView(btn)
    .bottomSpaceToView(self.tabView,0)
    .heightIs(2)
    .widthRatioToView(self.tabView,1/(float)(self.tabArray.count));
    
    self.scrollView.contentOffset = CGPointMake(kScreenWidth * (btn.tag-100), 0);
}

@end
