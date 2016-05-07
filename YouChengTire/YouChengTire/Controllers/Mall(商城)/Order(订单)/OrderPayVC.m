//
//  OrderPayVC.m
//  YouChengTire
//  支付订单
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderPayVC.h"
// Vendors
#import <AlipaySDK/AlipaySDK.h>
// ViewModels
#import "OrderPayVM.h"
// Cells
#import "OrderPayCell.h"

static NSString *const kOrderPayFirstCellIdentifier = @"OrderPayFirstCell";
static NSString *const kOrderPaySecondCellIdentifier = @"OrderPaySecondCell";
static NSString *const kOrderPayThirdCellIdentifier = @"OrderPayThirdCell";
static NSString *const kOrderPayFourthCellIdentifier = @"OrderPayFourthCell";

@interface OrderPayVC ()

@property (strong, nonatomic) OrderPayVM *orderPayVM;

@end

@implementation OrderPayVC

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
    if ([segue.identifier isEqualToString:@"paySuccessVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        [viewController setValue:_orderPayVM.orderPayM
                          forKey:@"orderPayM"];
    }
}

#pragma mark - Override
- (void)configureView {
    [self configureNavigationController];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_orderPayVM, title);
}

- (void)configureData {
    [_orderPayVM dataArray];
    
    [self requestRefreshData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _orderPayVM.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = _orderPayVM.array[indexPath.row];
    if ([data[@"kType"] isEqualToString:@"first"]) {
        return 104;
    }
    else if ([data[@"kType"] isEqualToString:@"second"]) {
        return 44;
    }
    else if ([data[@"kType"] isEqualToString:@"third"]) {
        return 44;
    }
    else if ([data[@"kType"] isEqualToString:@"fourth"]) {
        return 60;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = _orderPayVM.array[indexPath.row];
    if ([data[@"kType"] isEqualToString:@"first"]) {
        return [tableView dequeueReusableCellWithIdentifier:kOrderPayFirstCellIdentifier];
    }
    else if ([data[@"kType"] isEqualToString:@"second"]) {
        return [tableView dequeueReusableCellWithIdentifier:kOrderPaySecondCellIdentifier];
    }
    else if ([data[@"kType"] isEqualToString:@"third"]) {
        return [tableView dequeueReusableCellWithIdentifier:kOrderPayThirdCellIdentifier];
    }
    else if ([data[@"kType"] isEqualToString:@"fourth"]) {
        return [tableView dequeueReusableCellWithIdentifier:kOrderPayFourthCellIdentifier];
    }
    else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(OrderPayCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell configureCell:_orderPayVM.array[indexPath.row]];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {}

#pragma mark - Private
- (void)configureNavigationController {
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}

- (void)requestRefreshData {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    [_orderPayVM requestRefreshData:^(id object) {
        
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

#pragma mark - Event Response
/**
 *  确认支付
 */
- (IBAction)confirmPayment:(id)sender {
    NSString *orderString = nil;
    if (_orderPayVM.sign != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       _orderPayVM.orderInfo,
                       _orderPayVM.sign,
                       @"RSA"];
        [[AlipaySDK defaultService]
         payOrder:orderString
         fromScheme:kAppScheme
         callback:^(NSDictionary *resultDic) {
             NSLog(@"reslut = %@",resultDic);
             if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                 if (_orderPayVM.masterVC) {
                     [self.navigationController popToViewController:_orderPayVM.masterVC
                                                           animated:YES];
                 }
                 else {
                     [self performSegueWithIdentifier:@"paySuccessVC"
                                               sender:nil];
                 }
             }
             else {
                 kMRCError(@"抱歉，您的订单支付失败");
             }
         }];
    }
}

- (void)setOrderId:(NSString *)orderId {
    _orderPayVM.orderId = orderId;
}

- (void)setTotalPrice:(NSString *)totalPrice {
    _orderPayVM.totalPrice = totalPrice;
}

- (void)setMasterVC:(UIViewController *)masterVC {
    _orderPayVM.masterVC = masterVC;
}

@end
