//
//  CartVC.m
//  YouChengTire
//  购物车
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "CartVC.h"
// Vendors
#import "NSString+WPAttributedMarkup.h"
#import "WPAttributedStyleAction.h"
#import "WPHotspotLabel.h"
// ViewControllers
#import "RootTBC.h"
// ViewModels
#import "CartVM.h"
// Cells
#import "CartCell.h"
// Models
#import "CartM.h"

@interface CartVC () <
UITableViewDataSource,
UITableViewDelegate,
CartCellDelegate
>

@property (nonnull, strong, nonatomic) CartVM *cartVM;

@property (nonatomic, weak) IBOutlet UIView *toolEditView;
@property (nonatomic, weak) IBOutlet UIView *toolNormalView;
@property (nonatomic, weak) IBOutlet UIButton *selectAllButton;

@property (nonatomic, weak) IBOutlet UILabel *totalPriceLabel;
@property (nonatomic, weak) IBOutlet UIButton *settlementButton;

@end

@implementation CartVC

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
    if ([segue.identifier isEqualToString:@"orderCheckVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        [viewController setValue:_cartVM.cartProductIds
                          forKey:@"cartProductIds"];
        [viewController setValue:_cartVM.cartPackageIds
                          forKey:@"cartPackageIds"];
        [viewController setValue:_cartVM.orderCheckM
                          forKey:@"orderCheckM"];
    }
}

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
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_cartVM, title);
    
    _cartVM.masterVC = self;
    
    @weakify(self)
    [RACObserve(_cartVM, isEditNumber)
     subscribeNext:^(NSNumber *isEditNumber) {
         @strongify(self)
         [self configureBarButtonItem];
         [self configureToolView];
     }];
    
    [RACObserve(_cartVM, totalPrice)
     subscribeNext:^(NSString *totalPrice) {
         @strongify(self)
         NSDictionary *saleStyle = @{ @"sale" : RGB(238, 72, 72) };
         self.totalPriceLabel.attributedText = [[NSString stringWithFormat:@"合计: <sale>￥%.2f</sale>", [totalPrice floatValue]] attributedStringWithStyleBook:saleStyle];
     }];
    
    [RACObserve(_cartVM, totalCount)
     subscribeNext:^(NSString *totalCount) {
         @strongify(self)
         [self.settlementButton setTitle:[NSString stringWithFormat:@"结算 (%@)", totalCount]
                                forState:UIControlStateNormal];
         
     }];
}

- (void)configureData {
    if (!_cartVM.array) {
        [self requestRefreshData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _cartVM.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray<NSDictionary *> *array = _cartVM.array[section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray<NSDictionary *> *array = _cartVM.array[indexPath.section];
    NSDictionary *dictionary = array[indexPath.row];
    if ([dictionary[@"kCell"] isEqualToString:@"First"]) {
        return 44;
    }
    else {
        return 88;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray<NSDictionary *> *array = _cartVM.array[indexPath.section];
    NSDictionary *dictionary = array[indexPath.row];
    if ([dictionary[@"kCell"] isEqualToString:@"First"]) {
        return [tableView dequeueReusableCellWithIdentifier:@"CartFirstCell"];
    }
    else {
        return [tableView dequeueReusableCellWithIdentifier:@"CartSecondCell"];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(CartCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.delegate = self;
    
    [cell bindViewModel:_cartVM];
    
    NSArray<NSDictionary *> *array = _cartVM.array[indexPath.section];
    NSDictionary *dictionary = array[indexPath.row];
    [cell configureCell:dictionary[@"kModel"]];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {}

#pragma mark - CartCellDelegate
- (void)didSelectSection:(CartCell *)cell isSelect:(NSNumber *)isSelectNumber {
    NSIndexPath *indexPath = [self.baseTableView indexPathForCell:cell];
    NSArray<NSDictionary *> *array = _cartVM.array[indexPath.section];
    for (NSInteger i = 1; i < array.count; i++) {
        NSMutableDictionary *mDictionary = array[i].mutableCopy;
        CartProductM *cartProductM = mDictionary[@"kModel"];
        cartProductM.isSelectNumber = isSelectNumber;
        mDictionary[@"kModel"] = cartProductM;
    }
    [self.baseTableView reloadData];
    
    [self configureButton];
}

- (void)didSelectRow:(CartCell *)cell isSelect:(NSNumber *)isSelectNumber {
    NSIndexPath *indexPath = [self.baseTableView indexPathForCell:cell];
    NSArray<NSDictionary *> *array = _cartVM.array[indexPath.section];
    NSMutableDictionary *mDictionary = array[0].mutableCopy;
    CartM *cartM = mDictionary[@"kModel"];
    if ([isSelectNumber boolValue]) {
        BOOL isSelect = YES;
        for (NSInteger i = 1; i < array.count; i++) {
            NSMutableDictionary *mDictionary = array[i].mutableCopy;
            CartProductM *cartProductM = mDictionary[@"kModel"];
            if (![cartProductM.isSelectNumber boolValue]) {
                isSelect = NO;
                break;
            }
        }
        cartM.isSelectNumber = @(isSelect);
    }
    else {
        cartM.isSelectNumber = isSelectNumber;
    }
    mDictionary[@"kModel"] = cartM;
    [self.baseTableView reloadData];
    
    [self configureButton];
}

#pragma mark - Private
- (void)configureNavigationController {
    
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(openRightMenu:)];
    [self.navigationItem setRightBarButtonItems:@[editBarButtonItem]];
    
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}

- (void)openRightMenu:(id)sender {
    _cartVM.isEditNumber = @(![_cartVM.isEditNumber boolValue]);
}

- (void)configureBarButtonItem {
    NSString *tempTitle = @"";
    if ([_cartVM.isEditNumber boolValue])
        tempTitle = @"完成";
    else
        tempTitle = @"编辑";
    self.navigationItem.rightBarButtonItem.title = tempTitle;
}

- (void)configureToolView {
    _toolEditView.hidden = ![_cartVM.isEditNumber boolValue];
    _toolNormalView.hidden = [_cartVM.isEditNumber boolValue];
}

- (void)configureButton {
    if (_cartVM.isSelectAll) {
        [_selectAllButton setImage:GETIMAGE(@"me_option_red_big")
                          forState:UIControlStateNormal];
        [_selectAllButton setTitle:@"  取消"
                          forState:UIControlStateNormal];
    }
    else {
        [_selectAllButton setImage:GETIMAGE(@"me_option_grey_big")
                          forState:UIControlStateNormal];
        [_selectAllButton setTitle:@"  全选"
                          forState:UIControlStateNormal];
    }
}

//- (void)configureHeaderRefresh {
//    @weakify(self);
//    self.baseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock: ^{
//        @strongify(self);
//        [self requestRefreshData];
//    }];
//}

- (void)requestRefreshData {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    [_cartVM requestRefreshData:^(id object) {
        [self.baseTableView reloadData];
        [self configureButton];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (void)requestDeleteCartProduct {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    [_cartVM requestDeleteCartProduct:^(id object) {
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
        [self requestRefreshData];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (void)requestSubmitOrder {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_cartVM requestSubmitOrder:^(id object) {
        @strongify(self)
        [self performSegueWithIdentifier:@"orderCheckVC"
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

- (IBAction)selectAll:(id)sender {
    BOOL isSelectAll = _cartVM.isSelectAll;
    [_cartVM configureSelectAllButton:!isSelectAll];
    [self configureButton];
    [self.baseTableView reloadData];
}

- (IBAction)selectDelete:(id)sender {
    if (_cartVM.cartProductIdsArray.count == 0
        && _cartVM.cartPackageIdsArray.count == 0) {
        kMRCInfo(@"请选择您想删除的商品");
        return;
    }
    [self requestDeleteCartProduct];
}

- (IBAction)submitOrder:(id)sender {
    if (_cartVM.cartProductIdsArray.count == 0
        && _cartVM.cartPackageIdsArray.count == 0) {
        kMRCInfo(@"请选择您想购买的商品");
        return;
    }
    [self requestSubmitOrder];
}

@end
