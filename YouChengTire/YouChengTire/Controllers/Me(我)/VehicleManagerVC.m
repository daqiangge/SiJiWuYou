//
//  VehicleManagerVC.m
//  YouChengTire
//  车辆管理
//  Created by WangZhipeng on 16/1/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "VehicleManagerVC.h"
// Controllers
#import "RootTBC.h"
// ViewModels
#import "VehicleManagerVM.h"
// Cells
#import "VehicleManagerCell.h"
// Models
#import "VehicleManagerM.h"

@interface VehicleManagerVC () <
UITableViewDataSource,
UITableViewDelegate,
VehicleManagerCellDelegate
>

@property (strong, nonatomic) VehicleManagerVM *vehicleManagerVM;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstButtomLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondButtomLayoutConstraint;

@property (weak, nonatomic) IBOutlet UITableView *firstTableView;
@property (weak, nonatomic) IBOutlet UITableView *secondTableView;

@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

//@property (strong, nonatomic) NSArray<NSDictionary *> *firstDataArray;
//@property (strong, nonatomic) NSArray<NSDictionary *> *secondDataArray;

@property (nonatomic, weak) IBOutlet UIImageView *selectImageView;
@property (nonatomic, weak) IBOutlet UILabel *selectAllLabel;

@end

@implementation VehicleManagerVC

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
    if ([segue.identifier isEqualToString:@"editVehicleVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        if (sender) {
            [viewController setValue:(VehicleTruckM *)sender
                              forKey:@"vehicleTruckM"];
        }
    }
    else if ([segue.identifier isEqualToString:@"editTireVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        if (sender) {
            [viewController setValue:(VehicleTireM *)sender
                              forKey:@"vehicleTireM"];
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
    [self configureHeaderRefresh];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_vehicleManagerVM, title);
    
    @weakify(self)
    [RACObserve(_vehicleManagerVM, isFirstNumber)
     subscribeNext:^(NSNumber *isFirstNumber) {
         @strongify(self)
         BOOL isFirst = [isFirstNumber boolValue];
         self.firstTableView.hidden = !isFirst;
         self.firstView.hidden = !isFirst;
         
         self.secondTableView.hidden = isFirst;
         self.secondView.hidden = isFirst;
         
         if (isFirst) {
             self.firstLabel.textColor = RGB(49, 49, 49);
             self.secondLabel.textColor = RGB(153, 153, 153);
         }
         else {
             self.firstLabel.textColor = RGB(153, 153, 153);
             self.secondLabel.textColor = RGB(49, 49, 49);
         }
     }];
    
    [RACObserve(_vehicleManagerVM, isEditNumber)
     subscribeNext:^(NSNumber *isEditNumber) {
         @strongify(self)
         BOOL isEdit = [isEditNumber boolValue];
         UIBarButtonItem *editBarButtonItem = nil;
         if (isEdit) {
             self.firstButtomLayoutConstraint.constant = 49.f;
             self.secondButtomLayoutConstraint.constant = 49.f;
             
             self.vehicleManagerVM.truckArray = [_vehicleManagerVM removeLastOne:self.vehicleManagerVM.truckArray];
             self.vehicleManagerVM.tireArray = [_vehicleManagerVM removeLastOne:self.vehicleManagerVM.tireArray];
             
             editBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(openRightMenu:)];
         }
         else {
             self.firstButtomLayoutConstraint.constant = 0.f;
             self.secondButtomLayoutConstraint.constant = 0.f;
             
             self.vehicleManagerVM.truckArray = [_vehicleManagerVM firstAddLastOne:self.vehicleManagerVM.truckArray];
             self.vehicleManagerVM.tireArray = [_vehicleManagerVM secondAddLastOne:self.vehicleManagerVM.tireArray];
             
             editBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"管理"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(openRightMenu:)];
         }
         [self.navigationItem setRightBarButtonItems:@[editBarButtonItem]];
         
         if ([_vehicleManagerVM.isFirstNumber boolValue]) {
             // 车辆
             [_firstTableView reloadData];
         }
         else {
             // 轮胎
             [_secondTableView reloadData];
         }
     }];
    
    [RACObserve(_vehicleManagerVM, isSelectTruckAllNumber)
     subscribeNext:^(NSNumber *isSelectAllNumber) {
         @strongify(self)
         [self configureToolBar:[isSelectAllNumber boolValue]];
     }];
    
    [RACObserve(_vehicleManagerVM, isSelectTireAllNumber)
     subscribeNext:^(NSNumber *isSelectAllNumber) {
         @strongify(self)
         [self configureToolBar:[isSelectAllNumber boolValue]];
     }];
}

- (void)configureData {
    if ([_vehicleManagerVM.isFirstNumber boolValue]) {
        // 车辆
        [self requestGetTrucks];
    }
    else {
        // 轮胎
        [self requestGetTires];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_firstTableView]) {
        return _vehicleManagerVM.truckArray.count;
    }
    else {
        return _vehicleManagerVM.tireArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_firstTableView]) {
        if ([_vehicleManagerVM.truckArray[indexPath.row] isMemberOfClass:VehicleTruckM.class]) {
            return 44.f;
        }
        else {
            return 64.f;
        }
    }
    else {
        if ([_vehicleManagerVM.tireArray[indexPath.row] isMemberOfClass:VehicleTireM.class]) {
            return 44.f;
        }
        else {
            return 64.f;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_firstTableView]) {
        if ([_vehicleManagerVM.truckArray[indexPath.row] isMemberOfClass:VehicleTruckM.class]) {
            return [VehicleManagerFirstCell createCell];
        }
        else {
            return [VehicleManagerSecondCell createCell];
        }
    }
    else {
        if ([_vehicleManagerVM.tireArray[indexPath.row] isMemberOfClass:VehicleTireM.class]) {
            return [VehicleManagerFirstCell createCell];
        }
        else {
            return [VehicleManagerSecondCell createCell];
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(VehicleManagerCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.delegate = self;
    [cell bindViewModel:_vehicleManagerVM];
    if ([tableView isEqual:_firstTableView]) {
        [cell configureCell:_vehicleManagerVM.truckArray[indexPath.row]];
    }
    else {
        [cell configureCell:_vehicleManagerVM.tireArray[indexPath.row]];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_firstTableView]) {
        if ([_vehicleManagerVM.truckArray[indexPath.row] isMemberOfClass:VehicleTruckM.class]) {
            if ([_vehicleManagerVM.isEditNumber boolValue]) {
                VehicleManagerFirstCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                [cell selectCell];
            }
            else {
                
                [self performSegueWithIdentifier:@"editVehicleVC"
                                          sender:_vehicleManagerVM.truckArray[indexPath.row]];
            }
        }
        else {
            [self editVehicleVC];
        }
    }
    else {
        if ([_vehicleManagerVM.tireArray[indexPath.row] isMemberOfClass:VehicleTireM.class]) {
            if ([_vehicleManagerVM.isEditNumber boolValue]) {
                VehicleManagerFirstCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                [cell selectCell];
            }
            else {
                [self performSegueWithIdentifier:@"editTireVC"
                                          sender:_vehicleManagerVM.tireArray[indexPath.row]];
            }
        }
        else {
            [self editTireVC];
        }
    }
}

#pragma mark - VehicleManagerCellDelegate
- (void)refreshSelectAllStatus {
    if ([_vehicleManagerVM.isFirstNumber boolValue]) {
        // 车辆
        BOOL isSelectAll = _vehicleManagerVM.truckArray.count > 0;
        for (VehicleTruckM *model in _vehicleManagerVM.truckArray) {
            if ([model isMemberOfClass:VehicleTruckM.class]) {
                if (![model.isSelectNumber boolValue]) {
                    isSelectAll = NO;
                    break;
                }
            }
            else {
                isSelectAll = NO;
                continue;
            }
        }
        _vehicleManagerVM.isSelectTruckAllNumber = @(isSelectAll);
    }
    else {
        // 轮胎
        BOOL isSelectAll = _vehicleManagerVM.tireArray.count > 0;
        for (VehicleTireM *model in _vehicleManagerVM.tireArray) {
            if ([model isMemberOfClass:VehicleTireM.class]) {
                if (![model.isSelectNumber boolValue]) {
                    isSelectAll = NO;
                    break;
                }
            }
            else {
                isSelectAll = NO;
                continue;
            }
        }
        _vehicleManagerVM.isSelectTireAllNumber = @(isSelectAll);
    }
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
    _vehicleManagerVM.isEditNumber = @(![_vehicleManagerVM.isEditNumber boolValue]);
}

- (void)editVehicleVC {
    [self performSegueWithIdentifier:@"editVehicleVC"
                              sender:nil];
}

- (void)editTireVC {
    [self performSegueWithIdentifier:@"editTireVC"
                              sender:nil];
}

- (void)configureToolBar:(BOOL)isSelectAll {
    if (isSelectAll) {
        self.selectImageView.image = GETIMAGE(@"me_option_red_big");
        self.selectAllLabel.text = @"取消全选";
    }
    else {
        self.selectImageView.image = GETIMAGE(@"me_option_grey_big");
        self.selectAllLabel.text = @"全选";
    }
}

- (void)configureHeaderRefresh {
    @weakify(self);
    self.firstTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock: ^{
        @strongify(self);
        [self requestGetTrucks];
    }];
    
    self.secondTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock: ^{
        @strongify(self);
        [self requestGetTires];
    }];
}

/**
 * 获取车辆
 */
- (void)requestGetTrucks {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_vehicleManagerVM requestGetTrucks:^(id object) {
        @strongify(self)
        [self.firstTableView reloadData];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [self.firstTableView.mj_header endRefreshing];
        [self refreshSelectAllStatus];
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

/**
 * 删除车辆
 */
- (void)requestDeleteTruck {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_vehicleManagerVM requestDeleteTruck:^(id object) {
        @strongify(self)
        kMRCSuccess(@"删除成功");
        [self.firstTableView.mj_header beginRefreshing];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

/**
 * 获取轮胎
 */
- (void)requestGetTires {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_vehicleManagerVM requestGetTires:^(id object) {
        @strongify(self)
        [self.secondTableView reloadData];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [self.secondTableView.mj_header endRefreshing];
        [self refreshSelectAllStatus];
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

/**
 * 删除轮胎
 */
- (void)requestDeleteTire {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_vehicleManagerVM requestDeleteTire:^(id object) {
        @strongify(self)
        kMRCSuccess(@"删除成功");
        [self.secondTableView.mj_header beginRefreshing];
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
- (IBAction)switchFirst:(id)sender {
    [_vehicleManagerVM switchFirst];
    [self configureToolBar:[_vehicleManagerVM.isSelectTruckAllNumber boolValue]];
    
    [self requestGetTrucks];
}

- (IBAction)switchSecond:(id)sender {
    [_vehicleManagerVM switchSecond];
    [self configureToolBar:[_vehicleManagerVM.isSelectTireAllNumber boolValue]];
    
    [self requestGetTires];
}

#pragma mark - Event Response
- (IBAction)selectAll:(id)sender {
    if ([_vehicleManagerVM.isFirstNumber boolValue]) {
        // 车辆
        _vehicleManagerVM.isSelectTruckAllNumber = @(![_vehicleManagerVM.isSelectTruckAllNumber boolValue]);
        for (VehicleTruckM *model in _vehicleManagerVM.truckArray) {
            model.isSelectNumber = _vehicleManagerVM.isSelectTruckAllNumber;
        }
    }
    else {
        // 轮胎
        _vehicleManagerVM.isSelectTireAllNumber = @(![_vehicleManagerVM.isSelectTireAllNumber boolValue]);
        for (VehicleTireM *model in _vehicleManagerVM.tireArray) {
            model.isSelectNumber = _vehicleManagerVM.isSelectTireAllNumber;
        }
    }
}

- (IBAction)remove:(id)sender {
    if ([_vehicleManagerVM.isFirstNumber boolValue]) {
        // 车辆
        NSMutableArray *mArray = @[].mutableCopy;
        for (VehicleTruckM *model in _vehicleManagerVM.truckArray) {
            if ([model.isSelectNumber boolValue]) {
                [mArray addObject:model];
            }
        }
        if (mArray.count == 0) {
            kMRCInfo(@"请选择您要删除的车辆");
        }
        else {
            _vehicleManagerVM.selectTruckArray = mArray;
            [self requestDeleteTruck];
        }
    }
    else {
        // 轮胎
        NSMutableArray *mArray = @[].mutableCopy;
        for (VehicleTireM *model in _vehicleManagerVM.tireArray) {
            if ([model.isSelectNumber boolValue]) {
                [mArray addObject:model];
            }
        }
        if (mArray.count == 0) {
            kMRCInfo(@"请选择您要删除的轮胎");
        }
        else {
            _vehicleManagerVM.selectTireArray = mArray;
            [self requestDeleteTire];
        }
    }
}

@end
