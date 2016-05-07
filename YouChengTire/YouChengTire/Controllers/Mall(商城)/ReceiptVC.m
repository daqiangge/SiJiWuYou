//
//  ReceiptVC.m
//  YouChengTire
//  设置开票信息
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "ReceiptVC.h"
// ViewModels
#import "ReceiptVM.h"
#import "OrderCheckVM.h"
// Cells
#import "ReceiptCell.h"

static NSString *const kReceiptFirstCellIdentifier = @"ReceiptFirstCell";
static NSString *const kReceiptSecondCellIdentifier = @"ReceiptSecondCell";
static NSString *const kReceiptThirdCellIdentifier = @"ReceiptThirdCell";

@interface ReceiptVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) ReceiptVM *receiptVM;

@property (strong, nonatomic) OrderCheckVM *orderCheckVM;

@end

@implementation ReceiptVC

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
    RAC(self, title) = RACObserve(_receiptVM, title);
    
    @weakify(self)
    [RACObserve(_receiptVM, receiptTypeNumber)
     subscribeNext:^(NSNumber *receiptTypeNumber) {
         @strongify(self)
         self.receiptVM.mArray = @[].mutableCopy;
         switch ([receiptTypeNumber integerValue]) {
             case 0: {
                 [self.receiptVM.mArray
                  addObject:[self.baseTableView
                             dequeueReusableCellWithIdentifier:kReceiptFirstCellIdentifier]];
             }
                 break;
                 
             case 1: {
                 [self.receiptVM.mArray
                  addObject:[self.baseTableView
                             dequeueReusableCellWithIdentifier:kReceiptFirstCellIdentifier]];
                 [self.receiptVM.mArray
                  addObject:[self.baseTableView
                             dequeueReusableCellWithIdentifier:kReceiptSecondCellIdentifier]];
             }
                 break;
                 
             case 2: {
                 [self.receiptVM.mArray
                  addObject:[self.baseTableView
                             dequeueReusableCellWithIdentifier:kReceiptFirstCellIdentifier]];
                 [self.receiptVM.mArray
                  addObject:[self.baseTableView
                             dequeueReusableCellWithIdentifier:kReceiptSecondCellIdentifier]];
                 [self.receiptVM.mArray
                  addObject:[self.baseTableView
                             dequeueReusableCellWithIdentifier:kReceiptThirdCellIdentifier]];
             }
                 break;
                 
             default:
                 break;
         }
         [self.baseTableView reloadData];
     }];
}

- (void)configureData {
    [self requestRefreshData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _receiptVM.mArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [(ReceiptCell *)_receiptVM.mArray[indexPath.row] height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _receiptVM.mArray[indexPath.row];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ReceiptCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell bindViewModel:_receiptVM];
    [cell configureCell:_receiptVM.receiptDictionary];
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
    switch ([_receiptVM.receiptTypeNumber integerValue]) {
        case 0: {
            _orderCheckVM.receiptId = @"";
            _orderCheckVM.receiptType = @"";
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        case 1: {
            if (_receiptVM.name.length == 0) {
                kMRCInfo(@"发票抬头不能为空");
                return;
            }
            [self requestSaveReceipt];
        }
            break;
            
        case 2: {
            if (_receiptVM.name.length == 0) {
                kMRCInfo(@"发票抬头不能为空");
                return;
            }
            
            if (_receiptVM.number.length == 0) {
                kMRCInfo(@"纳税人识别号不能为空");
                return;
            }
            if (_receiptVM.address.length == 0) {
                kMRCInfo(@"地址不能为空");
                return;
            }
            if (_receiptVM.phone.length == 0) {
                kMRCInfo(@"电话不能为空");
                return;
            }
            if (_receiptVM.blank.length == 0) {
                kMRCInfo(@"开户行不能为空");
                return;
            }
            if (_receiptVM.blankNumber.length == 0) {
                kMRCInfo(@"账号不能为空");
                return;
            }
            [self requestSaveReceipt];
        }
            break;
            
        default:
            break;
    }
}

- (void)requestRefreshData {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_receiptVM requestRefreshData:^(id object) {
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

- (void)requestSaveReceipt {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_receiptVM requestSaveReceipt:^(id object) {
        @strongify(self)
        if ([_receiptVM.receiptTypeNumber integerValue] == 1) {
            if (_receiptVM.receiptDictionary[@"receipt0"]) {
                NSDictionary *receipt0 = _receiptVM.receiptDictionary[@"receipt0"];
                _orderCheckVM.receiptId = receipt0[@"id"];
                _orderCheckVM.receiptType = @"0";
            }
        }
        else {
            if (_receiptVM.receiptDictionary[@"receipt1"]) {
                NSDictionary *receipt1 = _receiptVM.receiptDictionary[@"receipt1"];
                _orderCheckVM.receiptId = receipt1[@"id"];
                _orderCheckVM.receiptType = @"1";
            }
        }

        [self.navigationController popViewControllerAnimated:YES];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (void)setOrderCheckVM:(OrderCheckVM *)orderCheckVM {
    _orderCheckVM = orderCheckVM;
    if ([_orderCheckVM.receiptId isEqualToString:@""]) {
        _receiptVM.receiptTypeNumber = @0;
    }
    else {
        if ([_orderCheckVM.receiptType isEqualToString:@"0"]) {
            _receiptVM.receiptTypeNumber = @1;
        }
        else {
            _receiptVM.receiptTypeNumber = @2;
        }
    }
}

@end
