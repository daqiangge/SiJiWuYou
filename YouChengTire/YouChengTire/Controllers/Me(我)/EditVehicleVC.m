//
//  EditVehicleVC.m
//  YouChengTire
//  编辑车辆
//  Created by WangZhipeng on 16/2/10.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "EditVehicleVC.h"
// ViewModels
#import "EditVehicleVM.h"
// Cells
#import "EditVehicleCell.h"
// Models
#import "VehicleManagerM.h"

static NSString *const kCellIdentifier = @"EditVehicleCell";

@interface EditVehicleVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) EditVehicleVM *editVehicleVM;

@end

@implementation EditVehicleVC

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
    RAC(self, title) = RACObserve(_editVehicleVM, title);
    
    _editVehicleVM.viewController = self;
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
    return 272;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(EditVehicleCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell configureCell:_editVehicleVM.vehicleTruckM];
    [cell bindViewModel:_editVehicleVM];
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
    VehicleTruckM *vehicleTruckM = _editVehicleVM.vehicleTruckM;
    if (vehicleTruckM.brand.length == 0) {
        kMRCInfo(@"请您选择品牌");
        return;
    }
    if (vehicleTruckM.model.length == 0) {
        kMRCInfo(@"请您选择车型");
        return;
    }
    if (vehicleTruckM.drive.length == 0) {
        kMRCInfo(@"请您输入驱动形式");
        return;
    }
    if (vehicleTruckM.number.length == 0) {
        kMRCInfo(@"请您输入车牌号码");
        return;
    }
    if (vehicleTruckM.engine.length == 0) {
        kMRCInfo(@"请您输入发动机号");
        return;
    }
    
    [self requestEditAddress];
}

- (void)requestEditAddress {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_editVehicleVM requestEditTruck:^(id object) {
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
- (void)setVehicleTruckM:(VehicleTruckM *)vehicleTruckM {
    if (vehicleTruckM) {
        _editVehicleVM.title = @"编辑车辆";
        _editVehicleVM.vehicleTruckM = vehicleTruckM;
    }
}

@end
