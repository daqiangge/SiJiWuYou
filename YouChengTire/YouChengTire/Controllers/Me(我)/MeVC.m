//
//  MeVC.m
//  YouChengTire
//  我
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "MeVC.h"
//
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
// Tools
#import "ZPHTTPSessionManager.h"
// Controllers
#import "RootTBC.h"
#import "VisitingServiceVC.h"
#import "LQInsuranceListVC.h"
#import "LQJiFengDingDanListVC.h"
#import "LQFaHuoListVC.h"
// ViewModels
#import "MeVM.h"
// Controllers
#import "LoginVC.h"
#import "MyRescueVC.h"
// Cells
#import "MeCell.h"

@interface MeVC () <
UITableViewDataSource,
UITableViewDelegate,
MeCellDelegate
>

@property (strong, nonatomic) MeVM *meVM;

@property (strong, nonatomic) NSArray<NSArray *> *cellArray;

@end

@implementation MeVC

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

#pragma mark - Override
- (void)configureView {
    [self configureNavigationController];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_meVM, title);
}

- (void)configureData {
    _cellArray = [_meVM cellArray];
    [self.baseTableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _cellArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 11.9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellArray[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [(MeCell *)(_cellArray[indexPath.section][indexPath.row]) height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cellArray[indexPath.section][indexPath.row];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(MeCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.delegate = self;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    SEL normalSelector = NSSelectorFromString(cell.dictionary[@"kMethod"]);
    if ([self respondsToSelector:normalSelector]) {
        ((void (*)(id, SEL))objc_msgSend)(self, normalSelector);
    }
}

#pragma mark - MeCellDelegate
- (void)didSelectSecondCell:(id)sender {
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 0: {
            // 购物车
            if ([UserM getUserM]) {
                [self performSegueWithIdentifier:@"cartVC"
                                          sender:nil];
            }
            else {
                [self performSegueWithIdentifier:@"loginVC"
                                          sender:nil];
            }
        }
            break;
            
        case 1: {
            // 购物订单
            if ([UserM getUserM]) {
                [self performSegueWithIdentifier:@"orderFrameVC"
                                          sender:nil];
            }
            else {
                [self performSegueWithIdentifier:@"loginVC"
                                          sender:nil];
            }
        }
            break;
            
        case 2: {
            // 救援订单
            UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Rescue" bundle:[NSBundle mainBundle]];
            MyRescueVC * vc = [sb instantiateViewControllerWithIdentifier:@"MYRESCUEVC_SBID"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 3: {
            // 积分订单LQJiFengDingDanListVC.h
            // 购物订单
            if ([UserM getUserM]) {
                LQJiFengDingDanListVC *vc = [[LQJiFengDingDanListVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else {
                [self performSegueWithIdentifier:@"loginVC"
                                          sender:nil];
            }
        }
            break;
            
        case 4: {
            // 上门服务
            UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Service"
                                                          bundle:[NSBundle mainBundle]];
            VisitingServiceVC * vc = [sb instantiateViewControllerWithIdentifier:@"VisitingServiceVC_SBID"];
            [self.navigationController pushViewController:vc
                                                 animated:YES];
        }
            break;
            
        case 5: {
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
                    LQFaHuoListVC *vc = [[LQFaHuoListVC alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }else{
                [self performSegueWithIdentifier:@"loginVC"
                                          sender:nil];
            }
        }
            break;
            
        case 6: {
            // 保险
            if ([UserM getUserM]) {
                LQInsuranceListVC *vc = [[LQInsuranceListVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else {
                [self performSegueWithIdentifier:@"loginVC"
                                          sender:nil];
            }
        }
            break;
            
        case 7: {
            // 添加卯点
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Private
- (void)configureNavigationController {
    
    UIButton *leftButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, 40, 40)];
        [button setImage:GETIMAGE(@"me_icon_left")
                forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(openLeftMenu:)
         forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.navigationItem setLeftBarButtonItems:@[[[UIBarButtonItem alloc] initWithCustomView:leftButton]]];
    
    /**
     *  WangZhipeng 隐藏消息模块 Start 20160420
    UIButton *rightButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, 40, 40)];
        [button setImage:GETIMAGE(@"me_icon_right")
                forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(openRightMenu:)
         forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.navigationItem setRightBarButtonItems:@[[[UIBarButtonItem alloc] initWithCustomView:rightButton]]];
     *  WangZhipeng 隐藏消息模块 End 20160430
     */
    
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}

- (void)openLeftMenu:(id)sender {
    [self performSegueWithIdentifier:@"setupVC"
                              sender:nil];
}

- (void)openRightMenu:(id)sender {
    if ([UserM getUserM]) {
        [self performSegueWithIdentifier:@"messageVC"
                                  sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"loginVC"
                                  sender:nil];
    }
}

- (void)login {
    [self performSegueWithIdentifier:@"loginVC"
                              sender:nil];
}

- (void)myWallet {
    if ([UserM getUserM]) {
        [self performSegueWithIdentifier:@"walletVC"
                                  sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"loginVC"
                                  sender:nil];
    }
}

- (void)vehicleManager {
    if ([UserM getUserM]) {
        [self performSegueWithIdentifier:@"vehicleManagerVC"
                                  sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"loginVC"
                                  sender:nil];
    }
}

- (void)receiptAddress {
    if ([UserM getUserM]) {
        [self performSegueWithIdentifier:@"receiptAddressVC"
                                  sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"loginVC"
                                  sender:nil];
    }
}

- (void)inviteFriends {
    if ([UserM getUserM]) {
        [self performSegueWithIdentifier:@"inviteFriendsVC"
                                  sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"loginVC"
                                  sender:nil];
    }
}

- (void)callCenter {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"客服中心"
                                          message:@"工作时间: 8:30~21:00"
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"呼叫"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [[UIApplication sharedApplication]
                                                            openURL:[NSURL URLWithString:@"tel:400-820-9686"]];
                                                       }];
    [alertController addAction:callAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

- (void)feedback {
    if ([UserM getUserM]) {
        [self performSegueWithIdentifier:@"feedbackVC"
                                  sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"loginVC"
                                  sender:nil];
    }
}

#pragma mark - Custom Accessors
//    NSDictionary *dictionary = @{
//                                 @"mobile" : @"18955529166",
//                                 @"password" : [self getSha1String:@"18955529166"],
//                                 @"verificationCode" : @"111111",
//                                 @"inviteCode" : @""
//                                 };
//
//    [ZPHTTP wPost:@"app/sys/user/save"
//       parameters:dictionary
//          success:^(id responseObject) {
//
//    } failure:^(NSError *error) {
//
//    }];

@end
