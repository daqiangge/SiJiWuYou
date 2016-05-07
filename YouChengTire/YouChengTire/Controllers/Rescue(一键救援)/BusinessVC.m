//
//  BusinessVC.m
//  YouChengTire
//
//  Created by Baby on 16/3/17.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BusinessVC.h"
#import "RescueCell.h"
#import "RescueOrderDetailVC.h"
#import "RootTBC.h"
#import "LQShop_RobOrderDetailVC.h"
#import "RescueVM.h"
#import "RescueM.h"


@interface BusinessVC ()<RescueFirstCellDelegate>
@property (strong, nonatomic) RescueVM * rescueVM;
//@property (nonatomic, strong) RescueM *rescueM;
@property (weak, nonatomic) IBOutlet UITableView *contentTable;
@property (nonatomic, strong) NSMutableArray * dataSourceArr;
@property (nonatomic, assign) NSInteger pageNo;
@end

@implementation BusinessVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [(RootTBC *)ZPRootViewController setTabBarHidden:YES
                                            animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.contentTable.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"救援";
    self.rescueVM = [[RescueVM alloc] init];
    self.dataSourceArr = [[NSMutableArray alloc] init];
    
    self.contentTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.contentTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


- (void)loadNewData{
    self.pageNo = 1;
    NSMutableDictionary * params = @{@"pageNo":[NSString stringWithFormat:@"%ld",self.pageNo],@"pageSize":@"10"}.mutableCopy;
    [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [self.rescueVM requestGetPublishRescueList:^(id object) {
        @strongify(self)
        [self.dataSourceArr removeAllObjects];
        [self.dataSourceArr addObjectsFromArray:((RescueM *)object).rescueList];
    } data:params error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        @strongify(self)
        [self.contentTable.mj_header endRefreshing];
        [self.contentTable reloadData];
        if (self.dataSourceArr.count < 10) {
            self.contentTable.mj_footer = nil;
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
    [self.rescueVM requestGetPublishRescueList:^(id object) {
        @strongify(self)
        [self.dataSourceArr addObjectsFromArray:((RescueM *)object).rescueList];
    } data:params error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        @strongify(self)
        [self.contentTable.mj_footer endRefreshing];
        [self.contentTable reloadData];
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}


# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSourceArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RescueFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RESCUE_FIRST_CELL_IDENTIFIER"];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(RescueFirstCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell refrashData:(RescueItemM *)[self.dataSourceArr objectAtIndex:indexPath.section] idex:indexPath];
}

# pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    RescueItemM * m = [self.dataSourceArr objectAtIndex:indexPath.section];
//    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Rescue" bundle:[NSBundle mainBundle]];
//    RescueOrderDetailVC * vc = [sb instantiateViewControllerWithIdentifier:@"RESCUE_ORDER_DETAIL_SBID"];
//    vc.rescueType = RESCUE_FIRST_TYPE;
//    vc.sid = m.sId;
//    [self.navigationController pushViewController:vc animated:YES];
    
    RescueItemM * m = [self.dataSourceArr objectAtIndex:indexPath.section];
    LQShop_RobOrderDetailVC *vc = [[LQShop_RobOrderDetailVC alloc] init];
    vc.rescueID = m.sId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickButtonWithIndex:(NSIndexPath *)_index{
    RescueItemM * m = [self.dataSourceArr objectAtIndex:_index.section];
    
    NSMutableDictionary * params = @{@"id":m.sId}.mutableCopy;
    [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    [self.rescueVM requestRushRescue:^(id object) {
        kMRCSuccess(object);
    } data:params error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
    
}

#pragma mark - Override
- (void)configureView {
    [self configureNavigationController];
}

#pragma mark - Private
- (void)configureNavigationController {
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
