//
//  MyRescueVC.m
//  YouChengTire
//
//  Created by Baby on 16/3/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "MyRescueVC.h"
#import "RescueCell.h"
#import "RootTBC.h"
#import "RescueOrderDetailVC.h"
#import "RescueVM.h"
#import "LQVip_RescueOrderDetailVC.h"
#import "LQRescueBySelfMapVC.h"
#import "LQShop_OrderDetailVC.h"

@interface MyRescueVC ()<RescueSecondCellDelegate>
@property (strong, nonatomic) RescueVM * rescueVM;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * dataSourceArr;
@property (nonatomic, assign) NSInteger pageNo;

@end

@implementation MyRescueVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [(RootTBC *)ZPRootViewController setTabBarHidden:YES
                                            animated:YES];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的救援";
    
    self.rescueVM = [[RescueVM alloc] init];
    self.dataSourceArr = [[NSMutableArray alloc] init];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)loadNewData{
    self.pageNo = 1;
    NSMutableDictionary * params = @{@"pageNo":[NSString stringWithFormat:@"%ld",self.pageNo],@"pageSize":@"10"}.mutableCopy;
    [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [self.rescueVM requestGetRescueList:^(id object) {
        @strongify(self)
        [self.dataSourceArr removeAllObjects];
        [self.dataSourceArr addObjectsFromArray:object[@"rescueList"]];
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
    [self.rescueVM requestGetRescueList:^(id object) {
        @strongify(self)
        [self.dataSourceArr addObjectsFromArray:object[@"rescueList"]];
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
    RescueSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RESCUE_SECOND_CELL_IDENTIFIER"];
    cell.delegate = self;
    return cell;
}

# pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([@"1" isEqualToString:[UserM getUserM].userDetailsM.userType]||[@"2" isEqualToString:[UserM getUserM].userDetailsM.userType]){
        [(RescueSecondCell *)cell refrashDataWithVIP:YES data:[self.dataSourceArr objectAtIndex:indexPath.section] idx:indexPath];
    }else{
        [(RescueSecondCell *)cell refrashDataWithVIP:NO data:[self.dataSourceArr objectAtIndex:indexPath.section] idx:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSDictionary * dic = [self.dataSourceArr objectAtIndex:indexPath.section];
    //    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Rescue" bundle:[NSBundle mainBundle]];
    //    RescueOrderDetailVC * vc = [storyboard instantiateViewControllerWithIdentifier:@"RESCUE_ORDER_DETAIL_SBID"];
    //    vc.rescueType = RESCUE_THIRD_TYPE;
    //    vc.sid = dic[@"id"];
    //    [self.navigationController pushViewController:vc animated:YES];
    
    NSDictionary * dic = [self.dataSourceArr objectAtIndex:indexPath.section];
    switch ([dic[@"status"] integerValue])
    {
        case 1:
        {
            UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
            returnButtonItem.title = @"";
            self.navigationItem.backBarButtonItem = returnButtonItem;
            LQRescueBySelfMapVC *vc = [[LQRescueBySelfMapVC alloc] init];
            vc.lat = [NSString stringWithFormat:@"%@",dic[@"lat"]];
            vc.lng = [NSString stringWithFormat:@"%@",dic[@"lng"]];
            vc.rescueId = dic[@"id"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
            returnButtonItem.title = @"";
            self.navigationItem.backBarButtonItem = returnButtonItem;
            LQRescueBySelfMapVC *vc = [[LQRescueBySelfMapVC alloc] init];
            vc.lat = [NSString stringWithFormat:@"%@",dic[@"lat"]];
            vc.lng = [NSString stringWithFormat:@"%@",dic[@"lng"]];
            vc.rescueId = dic[@"id"];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
        {
            if ([@"1" isEqualToString:[UserM getUserM].userDetailsM.userType]||[@"2" isEqualToString:[UserM getUserM].userDetailsM.userType])
            {
                LQVip_RescueOrderDetailVC *vc = [[LQVip_RescueOrderDetailVC alloc] init];
                vc.rescueID = dic[@"id"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                LQShop_OrderDetailVC *vc = [[LQShop_OrderDetailVC alloc] init];
                vc.rescueID = dic[@"id"];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
    }
    
}

- (void)clickLeftButtonWithIndex:(NSIndexPath *)_index obj:(UIButton *)_btn{
    NSDictionary * dic = [self.dataSourceArr objectAtIndex:_index.section];
    
    // 删除订单
    NSMutableDictionary * params = @{@"id":dic[@"id"]}.mutableCopy;
    [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [self.rescueVM requestDeleteRescue:^(id object) {
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
    
    
    //    if ([@"取消订单" isEqualToString:_btn.titleLabel.text]) {
    //        NSMutableDictionary * params = @{@"id":dic[@"id"]}.mutableCopy;
    //        [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
    //        [MBProgressHUD showHUDAddedTo:ZPRootView
    //                             animated:NO];
    //        @weakify(self)
    //        [self.rescueVM requestCancelRescue:^(id object) {
    //            @strongify(self)
    //            kMRCSuccess(object);
    //            [self.tableView.mj_header beginRefreshing];
    //        } data:params error:^(NSError *error) {
    //            kMRCError(error.localizedDescription);
    //        } failure:^(NSError *error) {
    //            kMRCError(error.localizedDescription);
    //        } completion:^{
    //            [MBProgressHUD hideHUDForView:ZPRootView
    //                                 animated:YES];
    //        }];
    //    }else{
    //        // 删除订单
    //        NSMutableDictionary * params = @{@"id":dic[@"id"]}.mutableCopy;
    //        [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
    //        [MBProgressHUD showHUDAddedTo:ZPRootView
    //                             animated:NO];
    //        @weakify(self)
    //        [self.rescueVM requestDeleteRescue:^(id object) {
    //            @strongify(self)
    //            kMRCSuccess(object);
    //            [self.tableView.mj_header beginRefreshing];
    //        } data:params error:^(NSError *error) {
    //            kMRCError(error.localizedDescription);
    //        } failure:^(NSError *error) {
    //            kMRCError(error.localizedDescription);
    //        } completion:^{
    //            [MBProgressHUD hideHUDForView:ZPRootView
    //                                 animated:YES];
    //        }];
    //    }
}

- (void)clickRightButtonWithIndex:(NSIndexPath *)_index obj:(UIButton *)_btn
{
    NSDictionary * dic = [self.dataSourceArr objectAtIndex:_index.section];
    if ([@"订单评价" isEqualToString:_btn.titleLabel.text])
    {
        
    }
    else
    {
        NSMutableDictionary * params = @{@"id":dic[@"id"]}.mutableCopy;
        [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
        [MBProgressHUD showHUDAddedTo:ZPRootView
                             animated:NO];
        @weakify(self)
        [self.rescueVM requestCancelRescue:^(id object) {
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
