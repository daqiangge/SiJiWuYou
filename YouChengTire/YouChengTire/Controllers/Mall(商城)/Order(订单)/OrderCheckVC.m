//
//  OrderCheckVC.m
//  YouChengTire
//  订单核对
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderCheckVC.h"
// Vendors
#import "NSString+WPAttributedMarkup.h"
#import "WPAttributedStyleAction.h"
#import "WPHotspotLabel.h"
// Controllers
#import "ReceiptAddressVC.h"
// ViewModels
#import "OrderCheckVM.h"
#import "OrderTicketVM.h"
// Cells
#import "OrderCheckCell.h"
// Models
#import "OrderCheckM.h"
#import "ReceiptAddressM.h"

@interface OrderCheckVC () <
UITableViewDataSource,
UITableViewDelegate,
OrderCheckCellDelegate
>

@property (strong, nonatomic) OrderCheckVM *orderCheckVM;

@property (nonatomic, weak) IBOutlet UILabel *totalLabel;

@end

@implementation OrderCheckVC

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
    if ([segue.identifier isEqualToString:@"receiptVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        [viewController setValue:_orderCheckVM
                          forKey:@"orderCheckVM"];
    }
    else if ([segue.identifier isEqualToString:@"payMethodVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        [viewController setValue:_orderCheckVM
                          forKey:@"orderCheckVM"];
    }
    else if ([segue.identifier isEqualToString:@"installMethodVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        [viewController setValue:_orderCheckVM
                          forKey:@"orderCheckVM"];
    }
    else if ([segue.identifier isEqualToString:@"orderSuccessVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        [viewController setValue:_orderCheckVM.orderId
                          forKey:@"orderId"];
        [viewController setValue:_orderCheckVM.totalPrice
                          forKey:@"totalPrice"];
    }
    else if ([segue.identifier isEqualToString:@"orderTicketVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        NSDictionary *transferParameters = @{
                                             @"kOrderTicketType" : (NSNumber *)sender,
                                             @"kBelongId" : _orderCheckVM.orderCheckM.belongId,
                                             @"kOrderCheckVM" : _orderCheckVM
                                             };
        [viewController setValue:transferParameters
                          forKey:@"transferParameters"];
    }
}

#pragma mark - View Lifecycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter]
       rac_addObserverForName:@"UIKeyboardWillShowNotification"
       object:nil] takeUntil:self.rac_willDeallocSignal]
     subscribeNext:^(NSNotification *notification) {
         @strongify(self);
         CGRect keyboardBounds = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
         self.baseTableView.contentInset = UIEdgeInsetsMake(self.baseTableView.contentInset.top,
                                                            0,
                                                            keyboardBounds.size.height,
                                                            0);
     }];
    
    [[[[NSNotificationCenter defaultCenter]
       rac_addObserverForName:@"UIKeyboardWillHideNotification"
       object:nil] takeUntil:self.rac_willDeallocSignal]
     subscribeNext:^(NSNotification *notification) {
         @strongify(self);
         self.baseTableView.contentInset = UIEdgeInsetsMake(self.baseTableView.contentInset.top,
                                                            0,
                                                            0,
                                                            0);
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

#pragma mark - Override
- (void)configureView {
    [self configureNavigationController];
    [self configureToolbar];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_orderCheckVM, title);
}

- (void)configureData {
    if (_orderCheckVM.orderCheckM) {
        [_orderCheckVM configureCell:_orderCheckVM.orderCheckM];
        [self.baseTableView reloadData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _orderCheckVM.array.count;
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
    return ((NSArray *)_orderCheckVM.array[section]).count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = ((NSArray *)_orderCheckVM.array[indexPath.section])[indexPath.row];
    if ([data[kCell] isEqualToString:@"OrderCheckFirstCell"]) {
        return [tableView fd_heightForCellWithIdentifier:@"OrderCheckFirstCell"
                                        cacheByIndexPath:indexPath
                                           configuration: ^(OrderCheckFirstCell *cell) {
                                               
                                           }];
    }
    else if ([data[kCell] isEqualToString:@"OrderCheckSecondCell"]) {
        return 44.f;
    }
    else if ([data[kCell] isEqualToString:@"OrderCheckThirdCell"]) {
        return [tableView fd_heightForCellWithIdentifier:@"OrderCheckThirdCell"
                                        cacheByIndexPath:indexPath
                                           configuration: ^(OrderCheckThirdCell *cell) {
                                               
                                           }];
    }
    else if ([data[kCell] isEqualToString:@"OrderCheckFourthCell"]) {
        return 44.f;
    }
    else if ([data[kCell] isEqualToString:@"OrderCheckFifthCell"]) {
        return 44.f;
    }
    else if ([data[kCell] isEqualToString:@"OrderCheckSixthCell"]) {
        return 44.f;
    }
    else if ([data[kCell] isEqualToString:@"OrderCheckSeventhCell"]) {
        return 164.f;
    }
    else {
        return 0.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = ((NSArray *)_orderCheckVM.array[indexPath.section])[indexPath.row];
    return [tableView dequeueReusableCellWithIdentifier:data[kCell]];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(OrderCheckCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.delegate = self;
    [cell bindViewModel:_orderCheckVM];
    [cell configureCell:((NSArray *)_orderCheckVM.array[indexPath.section])[indexPath.row]];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = ((NSArray *)_orderCheckVM.array[indexPath.section])[indexPath.row];
    SEL normalSelector = NSSelectorFromString(data[kMethod]);
    if ([self respondsToSelector:normalSelector]) {
        ((void (*)(id, SEL))objc_msgSend)(self, normalSelector);
    }
}

#pragma mark - OrderCheckCellDelegate
- (void)merchantTelephone {
    
}

- (void)refreshPrice {
    //    [self requestRefreshPrice];
}


#pragma mark - Private
- (void)configureNavigationController {
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}

- (void)configureToolbar {
    NSDictionary *saleStyle = @{ @"sale" : RGB(238, 72, 72) };
    _totalLabel.attributedText = [[NSString stringWithFormat:@"共 <sale>%lu</sale> 件，实付款: <sale>￥%.2f</sale>",
                                   (unsigned long)_orderCheckVM.orderCheckM.productList.count,
                                   [_orderCheckVM.orderCheckM.onlinePrice floatValue]] attributedStringWithStyleBook:saleStyle];
}

/**
 *  选择收货地址
 */
- (void)selectAddress {
    UIStoryboard *meSB = [UIStoryboard storyboardWithName:@"Me"
                                                   bundle:nil];
    ReceiptAddressVC *receiptAddressVC = [meSB instantiateViewControllerWithIdentifier:@"ReceiptAddressVC"];
    receiptAddressVC.isFromLQOrderClaimsVC = YES;
    @weakify(self)
    receiptAddressVC.selectAddress = ^(ReceiptAddressItemM *model){
        @strongify(self)
        self.orderCheckVM.orderCheckM.address = model;
        [self.orderCheckVM configureCell:self.orderCheckVM.orderCheckM];
        [self.baseTableView reloadData];
    };
    [self.navigationController pushViewController:receiptAddressVC
                                         animated:YES];
}

/**
 *  支付方式
 */
- (void)payMethod {
    [self performSegueWithIdentifier:@"payMethodVC"
                              sender:nil];
}
/**
 *  安装方式
 */
- (void)installMethod {
    [self performSegueWithIdentifier:@"installMethodVC"
                              sender:nil];
}
/**
 *  开票
 */
- (void)receipt {
    [self performSegueWithIdentifier:@"receiptVC"
                              sender:nil];
}
/**
 *  现金券
 */
- (void)currencyTicket {
    [self performSegueWithIdentifier:@"orderTicketVC"
                              sender:@(OrderCurrencyTicket)];
}
/**
 *  优惠券
 */
- (void)discountTicket {
    [self performSegueWithIdentifier:@"orderTicketVC"
                              sender:@(OrderDiscountTicket)];
}

- (void)requestRefreshPrice {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_orderCheckVM requestRefreshPrice:^(id object) {
        @strongify(self)
        kMRCSuccess(@"价格刷新成功");
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

- (void)requestSaveOrder {
    @weakify(self)
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    [_orderCheckVM requestSaveOrder:^(id object) {
        @strongify(self)
        [self performSegueWithIdentifier:@"orderSuccessVC"
                                  sender:nil];
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
- (IBAction)placeOrder:(id)sender {
    if (!STRING_NOT_EMPTY(_orderCheckVM.orderCheckM.address.sId) ) {
        kMRCInfo(@"请设置您的收货地址");
        return;
    }
    [self requestSaveOrder];
}

#pragma mark - Custom Accessors
- (void)setProductId:(NSString *)productId {
    _orderCheckVM.productId = productId;
}

- (void)setProductCount:(NSString *)productCount {
    _orderCheckVM.productCount = productCount;
}

- (void)setCartProductIds:(NSString *)cartProductIds {
    _orderCheckVM.cartProductIds = cartProductIds;
}

- (void)setCartPackageIds:(NSString *)cartPackageIds {
    _orderCheckVM.cartPackageIds = cartPackageIds;
}

- (void)setOrderCheckM:(OrderCheckM *)orderCheckM {
    _orderCheckVM.orderCheckM = orderCheckM;
}

@end
