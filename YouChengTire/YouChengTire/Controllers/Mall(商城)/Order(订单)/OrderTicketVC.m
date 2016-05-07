//
//  OrderTicketVC.m
//  YouChengTire
//  订单减免
//  Created by WangZhipeng on 16/4/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderTicketVC.h"
// ViewModels
#import "OrderTicketVM.h"
#import "OrderCheckVM.h"
// Cells
#import "OrderTicketCell.h"
// Models
#import "WalletM.h"

@interface OrderTicketVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (nonnull, nonatomic, strong) OrderTicketVM *orderTicketVM;
@property (nonnull, nonatomic, strong) OrderCheckVM *orderCheckVM;

@end

@implementation OrderTicketVC

#pragma mark - Override
- (void)configureView {
    [self configureNavigationController];
    [self configureHeaderRefresh];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_orderTicketVM, title);
}

- (void)configureData {
    if (!_orderTicketVM.array) {
        [self requestGetUsableTicketList];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _orderTicketVM.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (_orderTicketVM.orderTicketType) {
        case OrderCurrencyTicket: {
            return [tableView dequeueReusableCellWithIdentifier:@"OrderCurrencyTicketCell"];
        }
            break;
        case OrderDiscountTicket: {
            return [tableView dequeueReusableCellWithIdentifier:@"OrderDiscountTicketCell"];
        }
            break;
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(OrderTicketCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell configureCell:_orderTicketVM.array[indexPath.row]];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WalletTicketM *walletTicketM = _orderTicketVM.array[indexPath.row];
    switch (_orderTicketVM.orderTicketType) {
        case OrderCurrencyTicket: {
            _orderCheckVM.cashTicketM = walletTicketM;
        }
            break;
        case OrderDiscountTicket: {
            _orderCheckVM.privilegeTicketM = walletTicketM;
        }
            break;
        default:
            break;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private
- (void)configureNavigationController {
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"不使用券"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(cancelTicket:)];
    [self.navigationItem setRightBarButtonItems:@[cancelBarButtonItem]];
}

- (void)cancelTicket:(id)sender {
    switch (_orderTicketVM.orderTicketType) {
        case OrderCurrencyTicket: {
            _orderCheckVM.cashTicketM = nil;
        }
            break;
        case OrderDiscountTicket: {
            _orderCheckVM.privilegeTicketM = nil;
        }
            break;
        default:
            break;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configureHeaderRefresh {
    @weakify(self);
    self.baseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock: ^{
        @strongify(self);
        [self requestGetUsableTicketList];
    }];
}

- (void)requestGetUsableTicketList {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    [_orderTicketVM requestGetUsableTicketList:^(id object) {
        [self.baseTableView reloadData];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [self.baseTableView.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

#pragma mark - Custom Accessors
- (void)setTransferParameters:(NSDictionary *)transferParameters {
    NSNumber *orderTicketType = transferParameters[@"kOrderTicketType"];
    switch ([orderTicketType integerValue]) {
        case OrderCurrencyTicket:
            _orderTicketVM = [OrderCurrencyTicketVM new];
            break;
            
        case OrderDiscountTicket:
            _orderTicketVM = [OrderDiscountTicketVM new];
            break;
            
        default:
            break;
    }
    _orderTicketVM.belongId = transferParameters[@"kBelongId"];
    _orderCheckVM = transferParameters[@"kOrderCheckVM"];
}

@end
