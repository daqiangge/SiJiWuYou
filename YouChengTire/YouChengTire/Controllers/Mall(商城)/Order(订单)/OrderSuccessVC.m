//
//  OrderSuccessVC.m
//  YouChengTire
//  订单提交成功
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderSuccessVC.h"
// ViewModels
#import "OrderSuccessVM.h"
// Cells
#import "OrderSuccessCell.h"
// Controllers
#import "MallVC.h"

static NSString *const kCellIdentifier = @"OrderSuccessCell";

@interface OrderSuccessVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) OrderSuccessVM *orderSuccessVM;

@end

@implementation OrderSuccessVC

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
        [viewController setValue:_orderSuccessVM.orderId
                          forKey:@"orderId"];
        [viewController setValue:_orderSuccessVM.totalPrice
                          forKey:@"totalPrice"];
    }
}

#pragma mark - Override
- (void)configureView {
    [self configureNavigationController];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_orderSuccessVM, title);
}

- (void)configureData {}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:kCellIdentifier
                                    cacheByIndexPath:indexPath
                                       configuration: ^(OrderSuccessCell *cell) {
                                           
                                       }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(OrderSuccessCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Private
- (void)configureNavigationController {
    [self.navigationItem setHidesBackButton:YES];
    
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}

#pragma mark - Event Response
/**
 *  立即支付
 */
- (IBAction)payNow:(id)sender {
    [self performSegueWithIdentifier:@"orderPayVC"
                              sender:nil];
}
/**
 *  继续购物
 */
- (IBAction)continueShopping:(id)sender {
    BOOL isPop = YES;
    NSInteger totalCount = self.navigationController.viewControllers.count - 1;
    for (NSInteger i = totalCount; i >= 0; i--) {
        UIViewController *viewController = self.navigationController.viewControllers[i];
        if ([viewController isKindOfClass:MallVC.class]) {
            isPop = NO;
            [self.navigationController popToViewController:viewController
                                                  animated:YES];
        }
    }
    if (isPop) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)setOrderId:(NSString *)orderId {
    _orderSuccessVM.orderId = orderId;
}

- (void)setTotalPrice:(NSString *)totalPrice {
    _orderSuccessVM.totalPrice = totalPrice;
}

@end
