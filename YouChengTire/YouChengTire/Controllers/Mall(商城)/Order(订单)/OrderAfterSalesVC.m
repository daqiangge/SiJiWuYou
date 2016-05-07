//
//  OrderAfterSalesVC.m
//  YouChengTire
//  订单申请售后
//  Created by WangZhipeng on 16/5/1.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderAfterSalesVC.h"
// ViewModels
#import "OrderAfterSalesVM.h"
// Cells
#import "OrderAfterSalesCell.h"

@interface OrderAfterSalesVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (nonnull, nonatomic, strong) OrderAfterSalesVM *orderAfterSalesVM;

@end

@implementation OrderAfterSalesVC

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
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_orderAfterSalesVM, title);
    
    _orderAfterSalesVM.masterVC = self;
}

- (void)configureData {}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _orderAfterSalesVM.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = _orderAfterSalesVM.array[indexPath.row];
    if ([@"OrderAfterSalesFirstCell" isEqualToString:data[kCell]]) {
        return 44.f;
    }
    else if ([@"OrderAfterSalesSecondCell" isEqualToString:data[kCell]]) {
        return 76.f;
    }
    else if ([@"OrderAfterSalesThirdCell" isEqualToString:data[kCell]]) {
        return 453.f;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = _orderAfterSalesVM.array[indexPath.row];
    return [tableView dequeueReusableCellWithIdentifier:data[kCell]];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(OrderAfterSalesCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell bindViewModel:_orderAfterSalesVM];
    [cell configureCell:_orderAfterSalesVM.array[indexPath.row]];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - Private
- (void)configureNavigationController {}

- (void)requestSaveClaim {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    [_orderAfterSalesVM requestSaveClaim:^(id object) {
        kMRCSuccess(@"申请售后成功，请耐心等待");
        [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)submit:(id)sender {
//    if (!STRING_NOT_EMPTY(_orderAfterSalesVM.serviceDate)) {
//        kMRCInfo(@"请选择您的预约上门时间");
//    }
    if (!_orderAfterSalesVM.serviceAddress) {
        kMRCInfo(@"请输入您的上门服务地址");
        return;
    }
    if (!STRING_NOT_EMPTY(_orderAfterSalesVM.remark)) {
        kMRCInfo(@"请输入您的商品情况");
        return;
    }
    if (_orderAfterSalesVM.imageMutableArray.count < 3) {
        kMRCInfo(@"请至少选择三张商品图片");
        return;
    }
    [self requestSaveClaim];
}

- (void)setOrderFrameM:(OrderFrameM *)orderFrameM {
    _orderAfterSalesVM.orderFrameM = orderFrameM;
}

@end

