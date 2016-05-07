//
//  OrderAddRemarkVC.m
//  YouChengTire
//  订单添加评论
//  Created by WangZhipeng on 16/4/25.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderAddRemarkVC.h"
// ViewModels
#import "OrderAddRemarkVM.h"
// Cells
#import "OrderAddRemarkCell.h"
// Models
#import "OrderFrameM.h"

@interface OrderAddRemarkVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (nonnull, nonatomic, strong) OrderAddRemarkVM *orderAddRemarkVM;

@property (nonnull, nonatomic, strong) OrderFrameM *orderFrameM;

@end

@implementation OrderAddRemarkVC

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
    RAC(self, title) = RACObserve(_orderAddRemarkVM, title);
    
    _orderAddRemarkVM.masterVC = self;
}

- (void)configureData {}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _orderAddRemarkVM.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = _orderAddRemarkVM.array[indexPath.row];
    if ([@"OrderAddRemarkFirstCell" isEqualToString:data[kCell]]) {
        return 44.f;
    }
    else if ([@"OrderAddRemarkSecondCell" isEqualToString:data[kCell]]) {
        return 76.f;
    }
    else if ([@"OrderAddRemarkThirdCell" isEqualToString:data[kCell]]) {
        return 263.f;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = _orderAddRemarkVM.array[indexPath.row];
    return [tableView dequeueReusableCellWithIdentifier:data[kCell]];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(OrderAddRemarkCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell bindViewModel:_orderAddRemarkVM];
    [cell configureCell:_orderAddRemarkVM.array[indexPath.row]];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {}

#pragma mark - Private
- (void)configureNavigationController {}

- (void)requestSaveComment {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    [_orderAddRemarkVM requestsaveComment:^(id object) {
        kMRCSuccess(@"感谢您，评论成功");
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
    if (!STRING_NOT_EMPTY(_orderAddRemarkVM.score)) {
        kMRCInfo(@"请选择您的服务评价");
        return;
    }
    if (!STRING_NOT_EMPTY(_orderAddRemarkVM.remark)) {
        kMRCInfo(@"请输入您的评价信息");
        return;
    }
    [self requestSaveComment];
}

- (void)setOrderFrameM:(OrderFrameM *)orderFrameM {
    _orderAddRemarkVM.orderFrameM = orderFrameM;
}

@end
