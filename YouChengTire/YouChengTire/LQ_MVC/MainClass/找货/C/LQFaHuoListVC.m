//
//  LQFaHuoListVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQFaHuoListVC.h"
#import "LQFahuoListCell.h"
#import "RootTBC.h"
#import "LQModelGoods.h"
#import "LQFaHuoVC.h"
#import "LQFaHuoDetailVC.h"

@interface LQFaHuoListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *goodsArray;
@end

@implementation LQFaHuoListVC

- (NSMutableArray *)goodsArray
{
    if (!_goodsArray) {
        _goodsArray = [NSMutableArray array];
    }
    
    return _goodsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 发货收货
    UserM *userM = [UserM getUserM];
    // 服务网点（发货）
    if ([@"3" isEqualToString:userM.userDetailsM.userType]) {
        self.title = @"发货";
    }
    // 网络客户、网络车队（找货）
    else {
        self.title = @"找货";
    }
    
    self.view.backgroundColor = COLOR_LightGray;
    
    [self drawView];
    [self request];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [(RootTBC *)ZPRootViewController setTabBarHidden:YES
                                            animated:YES];
}

- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-120) style:UITableViewStyleGrouped];
//    tableView.backgroundColor = [UIColor redColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, kScreenHeight-50-64, kScreenWidth-30, 40)];
    [commitBtn setTitle:@"添加货源" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    commitBtn.backgroundColor = [UIColor redColor];
    [commitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
    
}

- (void)commit
{
    LQFaHuoVC *vc = [[LQFaHuoVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    __weak typeof(self) weakSelf = self;
    vc.saveGoodsSuccess = ^(){
        [weakSelf request];
    };
}

#pragma mark -
#pragma mark ================= 网络请求 =================
- (void)request
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [ZPHTTP wPost:@"app/prd/goods/getGoodsListForPoint" parameters:params success:^(id responseObject) {
        
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            self.goodsArray = [NSMutableArray arrayWithArray:[LQModelGoods mj_objectArrayWithKeyValuesArray:[[responseObject valueForKey:@"data"] valueForKey:@"goodsList"]]];
            [self.tableView reloadData];
        }
        else
        {
            NSInteger errnoInteger = [responseObject[@"msgCode"] integerValue];
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : responseObject[@"msg"] };
            NSError *uError = [NSError errorWithDomain:@"ZPCustom"
                                                  code:errnoInteger
                                              userInfo:userInfo];
            kMRCError(uError.localizedDescription);
        }
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    }];
}

#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.goodsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQFahuoListCell *cell = [LQFahuoListCell cellWithTableView:tableView];
    cell.model = self.goodsArray[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQModelGoods *model = self.goodsArray[indexPath.section];
    LQFaHuoDetailVC *vc = [[LQFaHuoDetailVC alloc] init];
    vc._id = model._id;
    [self.navigationController pushViewController:vc animated:YES];
    
    __weak typeof(self) weakSelf = self;
    vc.deleteGoodsSuccess = ^(){
        [weakSelf request];
    };
    
}

@end
