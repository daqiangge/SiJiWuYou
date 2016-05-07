//
//  PayMethodVC.m
//  YouChengTire
//  支付方式
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "PayMethodVC.h"
// ViewModels
#import "PayMethodVM.h"
#import "OrderCheckVM.h"
// Cells
#import "PayMethodCell.h"

static NSString *const kCellIdentifier = @"PayMethodFirstCell";

@interface PayMethodVC ()

@property (strong, nonatomic) PayMethodVM *payMethodVM;

@property (strong, nonatomic) OrderCheckVM *orderCheckVM;

@end

@implementation PayMethodVC

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

#pragma mark - Override
- (void)configureView {
    [self configureNavigationController];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_payMethodVM, title);
    
//    @weakify(self)
    [RACObserve(_payMethodVM, payMethodTypeNumber)
     subscribeNext:^(NSNumber *payMethodTypeNumber) {
//         @strongify(self)
     }];
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
    return 78.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(PayMethodCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell bindViewModel:_payMethodVM];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {}

#pragma mark - Private
- (void)configureNavigationController {
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(openRightMenu:)];
    [self.navigationItem setRightBarButtonItems:@[editBarButtonItem]];
}

- (void)openRightMenu:(id)sender {
    if ([_payMethodVM.payMethodTypeNumber integerValue] == 0) {
        _orderCheckVM.payment = @"在线支付";
    }
    else {
        _orderCheckVM.payment = @"货到付款";
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setOrderCheckVM:(OrderCheckVM *)orderCheckVM {
    _orderCheckVM = orderCheckVM;
    if ([orderCheckVM.payment isEqualToString:@"在线支付"]) {
        _payMethodVM.payMethodTypeNumber = @0;
    }
    else {
        _payMethodVM.payMethodTypeNumber = @1;
    }
}

@end
