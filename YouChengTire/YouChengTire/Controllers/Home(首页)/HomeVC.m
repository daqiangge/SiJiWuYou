//
//  HomeVC.m
//  YouChengTire
//  首页
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "HomeVC.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#import "AppDelegate.h"
// Vendors
#import "CityViewController.h"
#import "TOWebViewController.h"
// Controllers
#import "RootTBC.h"
#import "BusinessVC.h"
#import "VipVC.h"
#import "VisitingServiceVC.h"
#import "GoodsVC.h"
#import "IntegraMallVC.h"
#import "ServiceVC.h"
// ViewModels
#import "HomeVM.h"
// Views
#import "HomeBarItemV.h"
// Cells
#import "HomeCell.h"
// Models
#import "ReceiptAddressM.h"

#import "VIP_HelpVC.h"
#import "LQInsuranceVC.h"
#import "LQFaHuoListVC.h"
#import "LQJiFengShangChengVC.h"

@interface HomeVC () <
UITableViewDataSource,
UITableViewDelegate,
HomeCellDelegate
>

@property (strong, nonatomic) HomeVM *homeVM;

@property (strong, nonatomic) NSArray<NSArray *> *cellArray;

@property (nonatomic, strong) HomeBarItemV *homeBarItemV;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark - Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [(RootTBC *)ZPRootViewController setTabBarHidden:NO
                                            animated:NO];
    
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter]
       rac_addObserverForName:@"NotificationLocation"
       object:nil] takeUntil:self.rac_willDeallocSignal]
     subscribeNext:^(NSNotification *notification) {
         @strongify(self);
         self.homeBarItemV.cityLabel.text = [AppDelegate appDelegete].locCity;
     }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _homeVM.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 11.9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)_homeVM.array[section]).count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = ((NSArray *)_homeVM.array[indexPath.section])[indexPath.row];
    if ([@"HomeFirstCell" isEqualToString:dict[kCell]]) {
        return 110.f;
    }
    else if ([@"HomeSecondCell" isEqualToString:dict[kCell]]) {
        return 144.f;
    }
    else if ([@"HomeThirdCell" isEqualToString:dict[kCell]]) {
        return 160.f;
    }
    else if ([@"HomeFourthCell" isEqualToString:dict[kCell]]) {
        return 160.f;
    }
    else if ([@"HomeFifthCell" isEqualToString:dict[kCell]]) {
        return 36.f;
    }
    else if ([@"HomeSixthCell" isEqualToString:dict[kCell]]) {
        return 60.f;
    }
    else {
        return 0.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = ((NSArray *)_homeVM.array[indexPath.section])[indexPath.row];
    if ([@"HomeFirstCell" isEqualToString:dict[kCell]]) {
        return [HomeFirstCell createCell];
    }
    else if ([@"HomeSecondCell" isEqualToString:dict[kCell]]) {
        return [HomeSecondCell createCell];
    }
    else if ([@"HomeThirdCell" isEqualToString:dict[kCell]]) {
        return [HomeThirdCell createCell];
    }
    else if ([@"HomeFourthCell" isEqualToString:dict[kCell]]) {
        return [HomeFourthCell createCell];
    }
    else if ([@"HomeFifthCell" isEqualToString:dict[kCell]]) {
        return [HomeFifthCell createCell];
    }
    else if ([@"HomeSixthCell" isEqualToString:dict[kCell]]) {
        return [HomeSixthCell createCell];
    }
    else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(HomeCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.delegate = self;
    [cell configureCell:((NSArray *)_homeVM.array[indexPath.section])[indexPath.row]];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 2: {
            // 商城推荐 更多
            [self performSegueWithIdentifier:@"mallVC"
                                      sender:nil];
        }
            break;
            
        case 3: {
            // 积分兑换 更多
            IntegraMallVC *vc = [[IntegraMallVC alloc] init];
            [self.navigationController pushViewController:vc
                                                 animated:YES];
        }
            break;
            
        case 4: {
            // 资讯头条 更多
            [self performSegueWithIdentifier:@"informationVC"
                                      sender:nil];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - HomeCellDelegate
- (void)didSelectFirstCell:(id)sender {
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 0: {
            // 救援
            UserM *userM = [UserM getUserM];
            if (userM) {
                if ([@"1" isEqualToString:userM.userDetailsM.userType]
                    || [@"2" isEqualToString:userM.userDetailsM.userType]) {
                    //                    // 会员救援
                    //                    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Rescue"
                    //                                                                  bundle:[NSBundle mainBundle]];
                    //                    VipVC * vc = [sb instantiateViewControllerWithIdentifier:@"VIPVC_SBID"];
                    //                    [self.navigationController pushViewController:vc
                    //                                                         animated:YES];
                    
                    VIP_HelpVC *vc = [[VIP_HelpVC alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else{
                    // 商家救援
                    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Rescue"
                                                                  bundle:[NSBundle mainBundle]];
                    BusinessVC * vc = [sb instantiateViewControllerWithIdentifier:@"BUSINESSVC_SBID"];
                    [self.navigationController pushViewController:vc
                                                         animated:YES];
                }
            }
            else {
                [self performSegueWithIdentifier:@"loginVC"
                                          sender:nil];
            }
        }
            break;
            
        case 1: {
            // 保险
            UserM *userM = [UserM getUserM];
            if (userM)
            {
                LQInsuranceVC *vc = [[LQInsuranceVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                [self performSegueWithIdentifier:@"loginVC"
                                          sender:nil];
            }
            
        }
            break;
            
        case 2: {
            // 上门服务
            if ([UserM getUserM]) {
                UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Service"
                                                              bundle:[NSBundle mainBundle]];
                VisitingServiceVC * vc = [sb instantiateViewControllerWithIdentifier:@"VisitingServiceVC_SBID"];
                [self.navigationController pushViewController:vc
                                                     animated:YES];
            }
            else {
                [self performSegueWithIdentifier:@"loginVC"
                                          sender:nil];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)didSelectSecondCell:(id)sender {
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 0: {
            // 商城
            [self performSegueWithIdentifier:@"mallVC"
                                      sender:nil];
        }
            break;
            
        case 1: {
            // 积分
            IntegraMallVC *vc = [[IntegraMallVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 2: {
            // 违章查询
            [self performSegueWithIdentifier:@"peccancyVC"
                                      sender:nil];
        }
            break;
            
        case 3:
        {
            // 找货
            UserM *userM = [UserM getUserM];
            if (userM)
            {
                if ([@"1" isEqualToString:userM.userDetailsM.userType]
                    || [@"2" isEqualToString:userM.userDetailsM.userType])
                {
                    [self performSegueWithIdentifier:@"findGoodsVC"
                                              sender:nil];
                }
                else
                {
                    // 商家救援
                    LQFaHuoListVC *vc = [[LQFaHuoListVC alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }else{
                [self performSegueWithIdentifier:@"loginVC"
                                          sender:nil];
            }
        }
            break;
            
        case 4: {
            // 服务网点
            UIStoryboard *serviceSB = [UIStoryboard storyboardWithName:@"Service"
                                                                bundle:[NSBundle mainBundle]];
            ServiceVC *serviceVC = [serviceSB instantiateViewControllerWithIdentifier:@"ServiceVC"];
            [self.navigationController pushViewController:serviceVC
                                                 animated:YES];
        }
            break;
            
        case 5: {
            // 资讯
//            [self performSegueWithIdentifier:@"informationVC"
//                                      sender:nil];
            TOWebViewController *webVC = [[TOWebViewController alloc]
                                          initWithURL:[NSURL URLWithString:_homeVM.homeM.infoMore]];
            webVC.title = @"资讯";
            [self.navigationController pushViewController:webVC
                                                 animated:YES];
        }
            break;
            
        case 6: {
            // 社区
            NSString *communityUrl = _homeVM.homeM.communityUrl;
            UserM *userM = [UserM getUserM];
            if ([UserM getUserM]) {
                communityUrl = [NSString stringWithFormat:@"%@?userId=%@",
                                communityUrl,
                                userM.userDetailsM.sId];
            }
            TOWebViewController *webVC = [[TOWebViewController alloc]
                                          initWithURL:[NSURL URLWithString:communityUrl]];
            webVC.title = @"社区";
            [self.navigationController pushViewController:webVC
                                                 animated:YES];
        }
            break;
            
        case 7: {
            // 附近周边
            TOWebViewController *webVC = [[TOWebViewController alloc]
                                          initWithURL:[NSURL URLWithString:_homeVM.homeM.nearUrl]];
            webVC.title = @"附近周边";
            [self.navigationController pushViewController:webVC
                                                 animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)didSelectThirdCell:(id)sender {
    UIStoryboard *mallSB = [UIStoryboard storyboardWithName:@"Mall"
                                                     bundle:[NSBundle mainBundle]];
    GoodsVC * goodsVC = [mallSB instantiateViewControllerWithIdentifier:@"GoodsVC"];
    [goodsVC setValue:(NSString *)sender
               forKey:@"type"];
    [self.navigationController pushViewController:goodsVC
                                         animated:YES];
}

- (void)didSelectFourthCell:(id)sender {
    LQJiFengShangChengVC *vc = [[LQJiFengShangChengVC alloc] init];
    vc.type = (NSString *)sender;
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

#pragma mark - Private
- (void)configureView {
    [self configureNavigationController];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_homeVM, title);
}

- (void)configureData {
    if (!_homeVM.homeM) {
        [self requestRefreshData];
    }else{
        [self.baseTableView reloadData];
    }
}

- (void)configureNavigationController {
    /**
     *  WangZhipeng 隐藏消息模块 Start 20160430
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 40, 40)];
    [rightButton setImage:[UIImage imageNamed:@"home_icon_right"]
                 forState:UIControlStateNormal];
    //    [rightButton setImage:[UIImage imageNamed:@"home_icon_right"]
    //                 forState:UIControlStateHighlighted];
    [rightButton addTarget:self
                    action:@selector(openRightMenu:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItems:@[[[UIBarButtonItem alloc] initWithCustomView:rightButton]]];
     *  WangZhipeng 隐藏消息模块 End 20160430
     */
    
    _homeBarItemV = [HomeBarItemV nibItem:@"HomeBarItemV"];
    _homeBarItemV.cityLabel.text = @"北京";
    [_homeBarItemV.chooseButton addTarget:self
                                   action:@selector(chooseCity:)
                         forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItems:@[[[UIBarButtonItem alloc] initWithCustomView:_homeBarItemV]]];
    
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}

- (void)openRightMenu:(id)sender {
    [self performSegueWithIdentifier:@"messageVC"
                              sender:nil];
}

- (void)chooseCity:(id)sender {
    CityViewController *controller = [[CityViewController alloc] init];
    controller.currentCityString = @"北京";
    if ([AppDelegate appDelegete].locCity) {
        controller.currentCityString = [AppDelegate appDelegete].locCity;
    }
    controller.selectString = ^(NSString *string){
        _homeBarItemV.cityLabel.text = string;
    };
    [self presentViewController:controller
                       animated:YES
                     completion:^{
                         // TODO
                     }];
}

- (void)requestRefreshData {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_homeVM requestRefreshData:^(id object) {
        @strongify(self)
        [self.baseTableView reloadData];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

#pragma mark - Custom Accessors

@end
