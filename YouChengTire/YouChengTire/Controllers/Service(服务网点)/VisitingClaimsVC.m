//
//  VisitingClaimsVC.m
//  YouChengTire
//
//  Created by duwen on 16/4/4.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "VisitingClaimsVC.h"
#import "ServiceCell.h"
#import "MJRefresh.h"
#import "ServiceVM.h"
#import "LQVisitingClaimsDetailsVC.h"

@interface VisitingClaimsVC ()<ServiceFourCellDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ServiceVM * serviceVM;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, strong) NSMutableArray * dataSourceArr;
@end

@implementation VisitingClaimsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上门理赔";
    self.serviceVM = [[ServiceVM alloc] init];
    self.dataSourceArr = [[NSMutableArray alloc] init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData{
    self.pageNo = 1;
    NSMutableDictionary * params = @{@"pageNo":[NSString stringWithFormat:@"%ld",self.pageNo],@"pageSize":@"10"}.mutableCopy;
    [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
    
//    [MBProgressHUD showHUDAddedTo:ZPRootView
//                         animated:NO];
    @weakify(self)
    [self.serviceVM requestGetClaimList:^(id object) {
        @strongify(self)
        [self.dataSourceArr removeAllObjects];
        [self.dataSourceArr addObjectsFromArray:object[@"claimList"]];
    } data:params error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        if (self.dataSourceArr.count < 10) {
            self.tableView.mj_footer = nil;
        }
//        [MBProgressHUD hideHUDForView:ZPRootView
//                             animated:YES];
    }];
}

- (void)loadMoreData{
    self.pageNo++;
    NSMutableDictionary * params = @{@"pageNo":[NSString stringWithFormat:@"%ld",self.pageNo],@"pageSize":@"10"}.mutableCopy;
    [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
//    [MBProgressHUD showHUDAddedTo:ZPRootView
//                         animated:NO];
    @weakify(self)
    [self.serviceVM requestGetClaimList:^(id object) {
        @strongify(self)
        [self.dataSourceArr addObjectsFromArray:object[@"claimList"]];
    } data:params error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        @strongify(self)
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
//        [MBProgressHUD hideHUDForView:ZPRootView
//                             animated:YES];
    }];
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataSourceArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceFourCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SERVICE_FOUR_CELL_IDENTIFIER"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}

# pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 197.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ServiceFourCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * dic = [self.dataSourceArr objectAtIndex:indexPath.section];
    [cell refrashData:dic index:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"--------------->");
    
    NSDictionary * dic = [self.dataSourceArr objectAtIndex:indexPath.section];
    LQVisitingClaimsDetailsVC *vc = [[LQVisitingClaimsDetailsVC alloc] init];
    vc.orderID = dic[@"id"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)leftBtnClickedWithIndex:(NSIndexPath *)_index{
    // 删除订单
    NSDictionary * dic = [self.dataSourceArr objectAtIndex:_index.section];
    NSMutableDictionary * params = @{@"id":dic[@"id"]}.mutableCopy;
    [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [self.serviceVM requestDeleteClaim:^(id object) {
        @strongify(self)
        kMRCSuccess(object);
        [self.tableView.mj_header beginRefreshing];
    } data:params error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (void)rightBtnClickedWithIndex:(NSIndexPath *)_index{
    // 服务
}

@end
