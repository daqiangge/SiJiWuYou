//
//  ReceiptAddressVC.m
//  YouChengTire
//  收货地址
//  Created by WangZhipeng on 16/1/19.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "ReceiptAddressVC.h"
// Controllers
#import "RootTBC.h"
// ViewModels
#import "ReceiptAddressVM.h"
// Cells
#import "ReceiptAddressCell.h"
// Models
#import "ReceiptAddressM.h"

static NSString *const kReceiptAddressFirstCellIdentifier = @"ReceiptAddressFirstCell";
static NSString *const kReceiptAddressSecondCellIdentifier = @"ReceiptAddressSecondCell";

@interface ReceiptAddressVC () <
UITableViewDataSource,
UITableViewDelegate,
ReceiptAddressCellDelegate
>

@property (nonnull, strong, nonatomic) ReceiptAddressVM *receiptAddressVM;

@property (nullable ,nonatomic, weak) IBOutlet NSLayoutConstraint *buttomLayoutConstraint;
@property (nullable ,nonatomic, weak) IBOutlet UIImageView *selectImageView;
@property (nullable ,nonatomic, weak) IBOutlet UILabel *selectAllLabel;

@end

@implementation ReceiptAddressVC

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
    if ([segue.identifier isEqualToString:@"editAddressVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        if (sender) {
            [viewController setValue:(ReceiptAddressItemM *)sender
                              forKey:@"receiptAddressItemM"];
        }
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
    [self configureCell];
    [self configureHeaderRefresh];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_receiptAddressVM, title);
    
    @weakify(self)
    [RACObserve(_receiptAddressVM, isEditNumber)
     subscribeNext:^(NSNumber *isEditNumber) {
         @strongify(self)
         BOOL isEdit = [isEditNumber boolValue];
         UIBarButtonItem *editBarButtonItem = nil;
         if (isEdit) {
             self.buttomLayoutConstraint.constant = 49.f;
             self.receiptAddressVM.array = [_receiptAddressVM removeLastOne:self.receiptAddressVM.array];
             editBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(openRightMenu:)];
         }
         else {
             self.buttomLayoutConstraint.constant = 0.f;
             self.receiptAddressVM.array = [_receiptAddressVM addLastOne:self.receiptAddressVM.array];
             editBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"管理"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(openRightMenu:)];
         }
         [self.navigationItem setRightBarButtonItems:@[editBarButtonItem]];
         [self.baseTableView reloadData];
     }];
    
    [RACObserve(_receiptAddressVM, isSelectAllNumber)
     subscribeNext:^(NSNumber *isSelectAllNumber) {
         @strongify(self)
         BOOL isSelectAll = [isSelectAllNumber boolValue];
         if (isSelectAll) {
             self.selectImageView.image = GETIMAGE(@"me_option_red_big");
             self.selectAllLabel.text = @"取消";
         }
         else {
             self.selectImageView.image = GETIMAGE(@"me_option_grey_big");
             self.selectAllLabel.text = @"全选";
         }
     }];
}

- (void)configureData {
    //    if (!_receiptAddressVM.array) {
    [self requestRefreshData];
    //    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _receiptAddressVM.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_receiptAddressVM.array[indexPath.section] isEqual:@{}]) {
        return 64.f;
    }
    else {
        return [tableView fd_heightForCellWithIdentifier:kReceiptAddressFirstCellIdentifier
                                           configuration: ^(ReceiptAddressFirstCell *cell) {
                                               [cell configureCell:_receiptAddressVM.array[indexPath.section]];
                                           }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReceiptAddressCell *cell = nil;
    if ([_receiptAddressVM.array[indexPath.section] isEqual:@{}]) {
        cell = [tableView dequeueReusableCellWithIdentifier:kReceiptAddressSecondCellIdentifier];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:kReceiptAddressFirstCellIdentifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ReceiptAddressCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![_receiptAddressVM.array[indexPath.section] isEqual:@{}]) {
        cell.delegate = self;
        [cell bindViewModel:_receiptAddressVM];
        [cell configureCell:_receiptAddressVM.array[indexPath.section]];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_receiptAddressVM.isEditNumber boolValue]) {
        ReceiptAddressFirstCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell selectCell];
    }
    else
    {
        if ([_receiptAddressVM.array[indexPath.section] isEqual:@{}]) {
            [self performSegueWithIdentifier:@"editAddressVC"
                                      sender:nil];
        }
        else {
            if (self.isFromLQOrderClaimsVC
                && self.selectAddress) {
                self.selectAddress(_receiptAddressVM.array[indexPath.section]);
                [self.navigationController popViewControllerAnimated:YES];
            }
            else {
                [self performSegueWithIdentifier:@"editAddressVC"
                                          sender:_receiptAddressVM.array[indexPath.section]];
            }
        }
    }
}

#pragma mark - ReceiptAddressCellDelegate
- (void)refreshSelectAllStatus {
    BOOL isSelectAll = _receiptAddressVM.array.count > 0;
    for (ReceiptAddressItemM *model in _receiptAddressVM.array) {
        if ([model isEqual:@{}]) {
            isSelectAll = NO;
            continue;
        }
        if (![model.isSelectNumber boolValue]) {
            isSelectAll = NO;
            break;
        }
    }
    _receiptAddressVM.isSelectAllNumber = @(isSelectAll);
}

#pragma mark - Private
- (void)configureNavigationController {
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}

- (void)openRightMenu:(id)sender {
    _receiptAddressVM.isEditNumber = @(![_receiptAddressVM.isEditNumber boolValue]);
}

- (void)configureCell {
    [self.baseTableView registerNib:[UINib nibWithNibName:kReceiptAddressFirstCellIdentifier bundle:nil]
             forCellReuseIdentifier:kReceiptAddressFirstCellIdentifier];
}

- (void)configureHeaderRefresh {
    @weakify(self);
    self.baseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock: ^{
        @strongify(self);
        [self requestRefreshData];
    }];
}

- (void)requestRefreshData {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_receiptAddressVM requestRefreshData:^(id object) {
        @strongify(self)
        [self.baseTableView reloadData];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [self.baseTableView.mj_header endRefreshing];
        [self refreshSelectAllStatus];
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (void)requestDeleteAddress {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_receiptAddressVM requestDeleteAddress:^(id object) {
        @strongify(self)
        kMRCSuccess(@"删除成功");
        [self.baseTableView.mj_header beginRefreshing];
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
- (IBAction)selectAll:(id)sender {
    _receiptAddressVM.isSelectAllNumber = @(![_receiptAddressVM.isSelectAllNumber boolValue]);
    for (ReceiptAddressItemM *model in _receiptAddressVM.array) {
        model.isSelectNumber = _receiptAddressVM.isSelectAllNumber;
    }
}

- (IBAction)remove:(id)sender {
    NSMutableArray *mArray = @[].mutableCopy;
    for (ReceiptAddressItemM *model in _receiptAddressVM.array) {
        if ([model.isSelectNumber boolValue]) {
            [mArray addObject:model];
        }
    }
    if (mArray.count == 0) {
        kMRCInfo(@"请选择您要删除的地址");
    }
    else {
        _receiptAddressVM.selectArray = mArray;
        [self requestDeleteAddress];
    }
}

#pragma mark - Custom Accessors

@end
