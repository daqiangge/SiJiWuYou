//
//  LQJiFengDingDanListVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQJiFengDingDanListVC.h"
#import "LQJiFengDingDanListCell.h"
#import "RootTBC.h"
#import "LQModelGiftList.h"
#import "LQJiFengDingFanDetailVC.h"

@interface LQJiFengDingDanListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation LQJiFengDingDanListVC

- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"积分订单";
    
    [self drawView];
    [self request];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [(RootTBC *)ZPRootViewController setTabBarHidden:YES
                                            animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    //    tableView.tableFooterView = [self drawFooterView];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark -
#pragma mark ================= 网络请求 =================
- (void)request
{
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:@"" animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"1" forKey:@"pageNo"];
    [params setValue:@"999999" forKey:@"pageSize"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [ZPHTTP wPost:@"/app/prd/gift/getOrderList" parameters:params success:^(id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            self.dataArray = [NSMutableArray arrayWithArray:[LQModelGiftList mj_objectArrayWithKeyValuesArray:[[responseObject valueForKey:@"data"] valueForKey:@"orderList"]]];
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
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
    }];
}


#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQJiFengDingDanListCell *cell = [LQJiFengDingDanListCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.section];
    return cell;
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 162;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQModelGiftList *model = self.dataArray[indexPath.section];
    LQJiFengDingFanDetailVC *vc = [[LQJiFengDingFanDetailVC alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
