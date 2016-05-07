//
//  VisitingInstallVC.m
//  YouChengTire
//
//  Created by duwen on 16/4/4.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "VisitingInstallVC.h"
#import "ServiceCell.h"
#import "ServiceVM.h"
#import "VisitingInstallDetailsVC.h"
#import "LQVisitingInstallDetailsVC.h"

@interface VisitingInstallVC ()<ServiceThirdCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ServiceVM * serviceVM;
@property (nonatomic, assign) NSInteger pageNo;

@property (nonatomic, strong) NSMutableArray * dataSourceArr;
@end

@implementation VisitingInstallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上门安装";
    self.serviceVM = [[ServiceVM alloc] init];
    self.pageNo = 1;
    self.dataSourceArr = [[NSMutableArray alloc] init];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData{
    self.pageNo = 1;
    NSMutableDictionary * params = @{@"pageNo":[NSString stringWithFormat:@"%ld",self.pageNo],@"pageSize":@"10"}.mutableCopy;
    [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [self.serviceVM requestGetSetupList:^(id object) {
        @strongify(self)
        [self.dataSourceArr removeAllObjects];
        [self.dataSourceArr addObjectsFromArray:object[@"setupList"]];
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
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (void)loadMoreData{
    self.pageNo++;
    NSMutableDictionary * params = @{@"pageNo":[NSString stringWithFormat:@"%ld",self.pageNo],@"pageSize":@"10"}.mutableCopy;
    [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [self.serviceVM requestGetSetupList:^(id object) {
        @strongify(self)
        [self.dataSourceArr addObjectsFromArray:object[@"setupList"]];
    } data:params error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        @strongify(self)
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
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
    ServiceThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SERVICE_THIRD_CELL_IDENTIFIER"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ServiceThirdCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * dic = [self.dataSourceArr objectAtIndex:indexPath.section];
    [cell refrashData:dic index:indexPath];
}

# pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 157.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = [self.dataSourceArr objectAtIndex:indexPath.section];
    
//    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Service" bundle:[NSBundle mainBundle]];
//    VisitingInstallDetailsVC * vc = [sb instantiateViewControllerWithIdentifier:@"VisitingInstallDetailsVC"];
//    vc.orderId = orderDic[@"id"];
//    [self.navigationController pushViewController:vc animated:YES];
    
    LQVisitingInstallDetailsVC *vc = [[LQVisitingInstallDetailsVC alloc] init];
    vc.orderID = dic[@"id"];
    [self.navigationController pushViewController:vc animated:YES];
    
    __weak typeof(self) weakSelf = self;
    vc.deleteOrderSuccess = ^(){
        [weakSelf.tableView.mj_header beginRefreshing];
    };
}

- (void)leftBtnClickedWithIndex:(NSIndexPath *)_index{
    // 删除订单
    NSDictionary * dic = [self.dataSourceArr objectAtIndex:_index.section];
    NSDictionary * orderDic = dic[@"order"];
    NSMutableDictionary * params = @{@"id":orderDic[@"id"]}.mutableCopy;
    [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [self.serviceVM requestDeleteSetup:^(id object) {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id  obj = [segue destinationViewController];
    if ([obj isKindOfClass:[VisitingInstallDetailsVC class]]) {
        VisitingInstallDetailsVC * vc = (VisitingInstallDetailsVC *)obj;
//        vc.orderId = RESCUE_FIRST_TYPE;
    }
}


@end
