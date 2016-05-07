//
//  OrderDetailsVC.m
//  YouChengTire
//  订单详情
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderDetailsVC.h"
// ViewModels
#import "OrderDetailsVM.h"
// Cells
#import "OrderDetailsCell.h"
// Models
#import "OrderDetailsM.h"

@interface OrderDetailsVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) OrderDetailsVM *orderDetailsVM;

@property (nonatomic, weak) IBOutlet UIButton *firstButton;
@property (nonatomic, weak) IBOutlet UIButton *secondButton;
@property (nonatomic, weak) IBOutlet UIButton *thirdButton;

@end

@implementation OrderDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"orderPayVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        [viewController setValue:_orderDetailsVM.orderDetailsM.sId
                          forKey:@"orderId"];
        [viewController setValue:_orderDetailsVM.orderDetailsM.totalPrice
                          forKey:@"totalPrice"];
        [viewController setValue:self
                          forKey:@"masterVC"];
    }
}

#pragma mark - Override
- (void)configureView {
    [self configureNavigationController];
    [self configureButton];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_orderDetailsVM, title);
}

- (void)configureData {
    [self requestRefreshData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _orderDetailsVM.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 8.f;
    }
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)_orderDetailsVM.array[section]).count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = ((NSArray *)_orderDetailsVM.array[indexPath.section])[indexPath.row];
    if ([data[@"kType"] isEqualToString:@"first"]) {
        return [tableView fd_heightForCellWithIdentifier:@"OrderDetailsFirstCell"
                                        cacheByIndexPath:indexPath
                                           configuration: ^(OrderDetailsFirstCell *cell) {
                                               [cell configureCell:((NSArray *)_orderDetailsVM.array[indexPath.section])[indexPath.row]];
                                           }];
    }
    else if ([data[@"kType"] isEqualToString:@"second"]) {
        return 44.f;
    }
    else if ([data[@"kType"] isEqualToString:@"third"]) {
        return 76.f;
    }
    else if ([data[@"kType"] isEqualToString:@"fourth"]) {
        return 44.f;
    }
    else if ([data[@"kType"] isEqualToString:@"fifth"]) {
        return [tableView fd_heightForCellWithIdentifier:@"OrderDetailsFifthCell"
                                        cacheByIndexPath:indexPath
                                           configuration: ^(OrderDetailsFifthCell *cell) {
                                               [cell configureCell:((NSArray *)_orderDetailsVM.array[indexPath.section])[indexPath.row]];
                                           }];
    }
    else if ([data[@"kType"] isEqualToString:@"sixth"]) {
        return 176.f;
    }
    else {
        return 0.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = ((NSArray *)_orderDetailsVM.array[indexPath.section])[indexPath.row];
    if ([data[@"kType"] isEqualToString:@"first"]) {
        return [tableView dequeueReusableCellWithIdentifier:@"OrderDetailsFirstCell"];
    }
    else if ([data[@"kType"] isEqualToString:@"second"]) {
        return [tableView dequeueReusableCellWithIdentifier:@"OrderDetailsSecondCell"];
    }
    else if ([data[@"kType"] isEqualToString:@"third"]) {
        return [tableView dequeueReusableCellWithIdentifier:@"OrderDetailsThirdCell"];
    }
    else if ([data[@"kType"] isEqualToString:@"fourth"]) {
        return [tableView dequeueReusableCellWithIdentifier:@"OrderDetailsFourthCell"];
    }
    else if ([data[@"kType"] isEqualToString:@"fifth"]) {
        return [tableView dequeueReusableCellWithIdentifier:@"OrderDetailsFifthCell"];
    }
    else if ([data[@"kType"] isEqualToString:@"sixth"]) {
        return [tableView dequeueReusableCellWithIdentifier:@"OrderDetailsSixthCell"];
    }
    else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(OrderDetailsCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell configureCell:((NSArray *)_orderDetailsVM.array[indexPath.section])[indexPath.row]];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = ((NSArray *)_orderDetailsVM.array[indexPath.section])[indexPath.row];
    SEL normalSelector = NSSelectorFromString(data[@"kMethod"]);
    if ([self respondsToSelector:normalSelector]) {
        ((void (*)(id, SEL))objc_msgSend)(self, normalSelector);
    }
}

#pragma mark - Private
- (void)configureNavigationController {
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}

- (void)configureButton {
    _firstButton.layer.borderWidth = 1;
    _firstButton.layer.cornerRadius = 6;
    _firstButton.layer.borderColor = [UIColor clearColor].CGColor;
    
    _secondButton.layer.borderWidth = 1;
    _secondButton.layer.cornerRadius = 6;
    _secondButton.layer.borderColor = RGB(49, 49, 49).CGColor;
    
    _thirdButton.layer.borderWidth = 1;
    _thirdButton.layer.cornerRadius = 6;
    _thirdButton.layer.borderColor = RGB(49, 49, 49).CGColor;
}

/**
 *  立即支付
 */
- (void)payImmediately {
    [self performSegueWithIdentifier:@"orderPayVC"
                              sender:nil];
}

- (void)requestRefreshData {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_orderDetailsVM requestRefreshData:^(id object) {
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

- (void)setOrderId:(NSString *)orderId {
    _orderDetailsVM.orderId = orderId;
}

@end
