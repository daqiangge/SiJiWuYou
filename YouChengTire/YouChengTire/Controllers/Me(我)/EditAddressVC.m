//
//  EditAddressVC.m
//  YouChengTire
//  编辑地址
//  Created by WangZhipeng on 16/2/10.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "EditAddressVC.h"
// ViewModels
#import "EditAddressVM.h"
// Cells
#import "EditAddressCell.h"
// Models
#import "receiptAddressM.h"

static NSString *const kCellIdentifier = @"EditAddressCell";

@interface EditAddressVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) EditAddressVM *editAddressVM;

@end

@implementation EditAddressVC

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
    RAC(self, title) = RACObserve(_editAddressVM, title);
    
    _editAddressVM.viewController = self;
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
    return 232;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(EditAddressCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell configureCell:_editAddressVM.receiptAddressItemM];
    [cell bindViewModel:_editAddressVM];
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
    ReceiptAddressItemM *receiptAddressItemM = _editAddressVM.receiptAddressItemM;
    if (receiptAddressItemM.name.length == 0) {
        kMRCInfo(@"请您输入收货人");
        return;
    }
    if (receiptAddressItemM.mobile.length == 0) {
        kMRCInfo(@"请您输入联系方式");
        return;
    }
    if (receiptAddressItemM.province.length == 0
        || receiptAddressItemM.city.length == 0
        || receiptAddressItemM.county.length == 0) {
        kMRCInfo(@"请您选择省、市、区");
        return;
    }
    if (receiptAddressItemM.detail.length == 0) {
        kMRCInfo(@"请您输入详细地址");
        return;
    }
    
    [self requestEditAddress];
}

- (void)requestEditAddress {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_editAddressVM requestEditAddress:^(id object) {
        @strongify(self)
        kMRCSuccess(@"保存成功");
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

#pragma mark - Custom Accessors
- (void)setReceiptAddressItemM:(ReceiptAddressItemM *)receiptAddressItemM {
    if (receiptAddressItemM) {
        _editAddressVM.title = @"编辑地址";
        _editAddressVM.receiptAddressItemM = receiptAddressItemM;
    }
}

@end
