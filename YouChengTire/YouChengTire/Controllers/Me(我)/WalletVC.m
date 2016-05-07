//
//  WalletVC.m
//  YouChengTire
//  我的钱包
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "WalletVC.h"
// Controllers
#import "RootTBC.h"
// ViewModels
#import "WalletVM.h"
// Cells
#import "WalletCell.h"

@interface WalletVC ()  <
UITableViewDataSource,
UITableViewDelegate,
WalletCellDelegate
>

@property (nonnull, nonatomic, strong) WalletVM *walletVM;

@property (nullable ,nonatomic, weak) IBOutlet UITableView *firstTableView;
@property (nullable ,nonatomic, weak) IBOutlet UITableView *secondTableView;
@property (nullable ,nonatomic, weak) IBOutlet UITableView *thirdTableView;

@property (nullable ,nonatomic, weak) IBOutlet UIView *firstView;
@property (nullable ,nonatomic, weak) IBOutlet UIView *secondView;
@property (nullable ,nonatomic, weak) IBOutlet UIView *thirdView;

@property (nullable ,nonatomic, weak) IBOutlet UILabel *firstLabel;
@property (nullable ,nonatomic, weak) IBOutlet UILabel *secondLabel;
@property (nullable ,nonatomic, weak) IBOutlet UILabel *thirdLabel;

@end

@implementation WalletVC

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
    [(RootTBC *)ZPRootViewController setTabBarHidden:YES
                                            animated:YES];
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
    [self configureHeaderRefresh];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_walletVM, title);
    
    @weakify(self)
    [RACObserve(_walletVM, tabNumber)
     subscribeNext:^(NSNumber *tabNumber) {
         @strongify(self)
         switch ([tabNumber integerValue]) {
             case 1: {
                 self.firstTableView.hidden = NO;
                 self.secondTableView.hidden = YES;
                 self.thirdTableView.hidden = YES;
                 
                 self.firstView.hidden = NO;
                 self.secondView.hidden = YES;
                 self.thirdView.hidden = YES;
                 
                 self.firstLabel.textColor = RGB(49, 49, 49);
                 self.secondLabel.textColor = RGB(153, 153, 153);
                 self.thirdLabel.textColor = RGB(153, 153, 153);
             }
                 break;
                 
             case 2: {
                 self.firstTableView.hidden = YES;
                 self.secondTableView.hidden = NO;
                 self.thirdTableView.hidden = YES;
                 
                 self.firstView.hidden = YES;
                 self.secondView.hidden = NO;
                 self.thirdView.hidden = YES;
                 
                 self.firstLabel.textColor = RGB(153, 153, 153);
                 self.secondLabel.textColor = RGB(49, 49, 49);
                 self.thirdLabel.textColor = RGB(153, 153, 153);
             }
                 break;
                 
             case 3: {
                 self.firstTableView.hidden = YES;
                 self.secondTableView.hidden = YES;
                 self.thirdTableView.hidden = NO;
                 
                 self.firstView.hidden = YES;
                 self.secondView.hidden = YES;
                 self.thirdView.hidden = NO;
                 
                 self.firstLabel.textColor = RGB(153, 153, 153);
                 self.secondLabel.textColor = RGB(153, 153, 153);
                 self.thirdLabel.textColor = RGB(49, 49, 49);
             }
                 break;
                 
             default:
                 break;
         }
     }];
    
    [self switchFirst:nil];
}

- (void)configureData {}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_firstTableView]) {
        return 1;
    }
    else if ([tableView isEqual:_secondTableView]) {
        return _walletVM.cashTicketMArray.count;
    }
    else {
        return _walletVM.discountTicketMArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_firstTableView]) {
        return 204.f;
    }
    else if ([tableView isEqual:_secondTableView]) {
//        if (indexPath.row == 2) {
//            return 64.f;
//        }
//        else {
            return 86.f;
//        }
    }
    else {
        return 86.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_firstTableView]) {
        return [WalletFirstCell createCell];
    }
    else if ([tableView isEqual:_secondTableView]) {
//        if (indexPath.row == 2) {
//            return [WalletThirdCell createCell];
//        }
//        else {
            return [WalletSecondCell createCell];
//        }
    }
    else {
        return [WalletFourthCell createCell];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(WalletCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_firstTableView]) {
        cell.delegate = self;
        [cell configureCell:_walletVM.pointsM];
    }
    else if ([tableView isEqual:_secondTableView]) {
        [cell configureCell:_walletVM.cashTicketMArray[indexPath.row]];
    }
    else {
        [cell configureCell:_walletVM.cashTicketMArray[indexPath.row]];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {}

#pragma mark - WalletCellDelegate
- (void)enterMall {
    // 进入积分商城
}

#pragma mark - Private
- (void)configureNavigationController {}

- (void)configureHeaderRefresh {
    @weakify(self);
    _firstTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock: ^{
        @strongify(self);
        [self refreshGetPoints];
    }];
    _secondTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock: ^{
        @strongify(self);
        [self refreshGetCashTickets];
    }];
    _thirdTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock: ^{
        @strongify(self);
        [self refreshGetDiscountTickets];
    }];
}

- (void)refreshGetPoints {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_walletVM requestGetPoints:^(id object) {
        @strongify(self)
        [self.firstTableView reloadData];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [_firstTableView.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (void)refreshGetCashTickets {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_walletVM requestGetCashTickets:^(id object) {
        @strongify(self)
        [self.secondTableView reloadData];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [_secondTableView.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (void)refreshGetDiscountTickets {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_walletVM requestGetDiscountTickets:^(id object) {
        @strongify(self)
        [self.thirdTableView reloadData];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [_thirdTableView.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

#pragma mark - Event Response
- (IBAction)switchFirst:(id)sender {
    if([_walletVM switchFirst]) {
        if (!_walletVM.pointsM) {
            [self refreshGetPoints];
        }
    }
}

- (IBAction)switchSecond:(id)sender {
    if([_walletVM switchSecond]) {
        if (!_walletVM.cashTicketMArray) {
            [self refreshGetCashTickets];
        }
    }
}

- (IBAction)switchThird:(id)sender {
    if([_walletVM switchThird]) {
        if (!_walletVM.discountTicketMArray) {
            [self refreshGetDiscountTickets];
        }
    }
}

#pragma mark - Custom Accessors

@end
