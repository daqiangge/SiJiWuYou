//
//  EditTireVC.m
//  YouChengTire
//  编辑轮胎
//  Created by WangZhipeng on 16/2/10.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "EditTireVC.h"
// ViewModels
#import "EditTireVM.h"
// Cells
#import "EditTireCell.h"
// Models
#import "VehicleManagerM.h"

static NSString *const kCellIdentifier = @"EditTireCell";

@interface EditTireVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) EditTireVM *editTireVM;

@end

@implementation EditTireVC

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
    RAC(self, title) = RACObserve(_editTireVM, title);
    
    _editTireVM.viewController = self;
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
    return 224;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(EditTireCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell configureCell:_editTireVM.vehicleTireM];
    [cell bindViewModel:_editTireVM];
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
    VehicleTireM *vehicleTireM = _editTireVM.vehicleTireM;
    if (vehicleTireM.series.length == 0) {
        kMRCInfo(@"请您选择系列");
        return;
    }
    if (vehicleTireM.standard.length == 0) {
        kMRCInfo(@"请您选择规格");
        return;
    }
    if (vehicleTireM.brand.length == 0) {
        kMRCInfo(@"请您输入品牌");
        return;
    }
    if (vehicleTireM.pattern.length == 0) {
        kMRCInfo(@"请您输入花纹");
        return;
    }
    
    [self requestEditAddress];
}

- (void)requestEditAddress {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_editTireVM requestEditTire:^(id object) {
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
- (void)setVehicleTireM:(VehicleTireM *)vehicleTireM {
    if (vehicleTireM) {
        _editTireVM.title = @"编辑车辆";
        _editTireVM.vehicleTireM = vehicleTireM;
    }
}

@end
