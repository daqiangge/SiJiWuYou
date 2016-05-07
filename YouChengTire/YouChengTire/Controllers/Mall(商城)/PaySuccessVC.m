//
//  PaySuccessVC.m
//  YouChengTire
//  支付成功
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "PaySuccessVC.h"
// ViewModels
#import "PaySuccessVM.h"
// Cells
#import "PaySuccessCell.h"
// Controllers
#import "MallVC.h"
// Models
#import "OrderPayM.h"

static NSString *const kCellIdentifier = @"PaySuccessCell";

@interface PaySuccessVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) PaySuccessVM *paySuccessVM;

@end

@implementation PaySuccessVC

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
    if ([segue.identifier isEqualToString:@"orderDetailsVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        [viewController setValue:_paySuccessVM.orderPayM.orderId
                          forKey:@"orderId"];
    }
}

#pragma mark - Override
- (void)configureView {
    [self configureNavigationController];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_paySuccessVM, title);
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
                                       configuration: ^(PaySuccessCell *cell) {
                                           [cell configureCell:_paySuccessVM.orderPayM];
                                       }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(PaySuccessCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell configureCell:_paySuccessVM.orderPayM];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {}

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
/**
 *  查看订单
 */
- (IBAction)viewOrders:(id)sender {
    [self performSegueWithIdentifier:@"orderDetailsVC"
                              sender:nil];
}

- (IBAction)callPhone:(id)sender {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"服务热线"
                                          message:@"工作时间: 8:30~21:00"
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"呼叫"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [[UIApplication sharedApplication]
                                                            openURL:[NSURL URLWithString:@"tel:4008209686"]];
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

- (void)setOrderPayM:(OrderPayM *)orderPayM {
    _paySuccessVM.orderPayM = orderPayM;
}

@end
