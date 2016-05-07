//
//  LQInsuranceListVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQInsuranceListVC.h"
#import "LQInsuranceListCell.h"
#import "RootTBC.h"
#import "LQModelinsuranceList.h"
#import "LQInsuranceDetailVC.h"

@interface LQInsuranceListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation LQInsuranceListVC

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的保险";
    
    [self drawView];
    [self request];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [(RootTBC *)ZPRootViewController setTabBarHidden:YES
                                            animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
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
    
    [ZPHTTP wPost:@"/app/prd/insurance/getInsuranceList" parameters:params success:^(id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            self.dataArray = [NSMutableArray arrayWithArray:[LQModelinsuranceList mj_objectArrayWithKeyValuesArray:[[responseObject valueForKey:@"data"] valueForKey:@"insuranceList"]]];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQInsuranceListCell *cell = [LQInsuranceListCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQModelinsuranceList*model = self.dataArray[indexPath.row];
    LQInsuranceDetailVC *vc = [[LQInsuranceDetailVC alloc] init];
    vc._id = model._id;
    [self.navigationController pushViewController:vc animated:YES];
    
    __weak typeof(self) weakSelf = self;
    vc.deleteOrderSuccess = ^(){
        [weakSelf request];
    };
}

@end
