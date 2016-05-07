//
//  InstallMethodVC.m
//  YouChengTire
//  安装方式
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "InstallMethodVC.h"
// Pods
#import "UITableView+FDTemplateLayoutCell.h"
// ViewModels
#import "InstallMethodVM.h"
#import "OrderCheckVM.h"
// Cells
#import "InstallMethodCell.h"
// Models
#import "OrderCheckM.h"

static NSString *const kInstallMethodFirstCellIdentifier = @"InstallMethodFirstCell";
static NSString *const kInstallMethodSecondCellIdentifier = @"InstallMethodSecondCell";

@interface InstallMethodVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) InstallMethodVM *installMethodVM;

@property (strong, nonatomic) OrderCheckVM *orderCheckVM;

@end

@implementation InstallMethodVC

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
    RAC(self, title) = RACObserve(_installMethodVM, title);
    
    @weakify(self)
    [RACObserve(_installMethodVM, pickedUpTypeNumber)
     subscribeNext:^(NSNumber *pickedUpTypeNumber) {
         @strongify(self)
         if ([pickedUpTypeNumber integerValue] == 2) {
             if (self.installMethodVM.mArray.count == 1) {
                 [_installMethodVM.mArray addObject:[self.baseTableView dequeueReusableCellWithIdentifier:kInstallMethodSecondCellIdentifier]];
             }
         }
         else {
             if (self.installMethodVM.mArray.count == 2) {
                 [self.installMethodVM.mArray removeLastObject];
             }
         }
         [self.baseTableView reloadData];
     }];
    
}

- (void)configureData {
    _installMethodVM.mArray = @[
                                [self.baseTableView dequeueReusableCellWithIdentifier:kInstallMethodFirstCellIdentifier]
                                ].mutableCopy;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _installMethodVM.mArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [(InstallMethodCell *)_installMethodVM.mArray[indexPath.row] height];
    }
    else {
        return [tableView fd_heightForCellWithIdentifier:kInstallMethodSecondCellIdentifier
                                        cacheByIndexPath:indexPath
                                           configuration: ^(InstallMethodSecondCell *cell) {
                                               
                                           }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _installMethodVM.mArray[indexPath.row];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(InstallMethodCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell bindViewModel:_installMethodVM];
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
    switch ([_installMethodVM.pickedUpTypeNumber integerValue]) {
        case 0: {
            _orderCheckVM.setup = @"上门安装";
        }
            break;
            
        case 1: {
            _orderCheckVM.setup = @"自行安装";
        }
            break;
            
        case 2: {
            _orderCheckVM.setup = @"定点自提";
        }
            break;
            
        default:
            break;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setOrderCheckVM:(OrderCheckVM *)orderCheckVM {
    _orderCheckVM = orderCheckVM;
    
    if ([orderCheckVM.setup isEqualToString:@"上门安装"]) {
        _installMethodVM.pickedUpTypeNumber = @0;
    }
    else if ([orderCheckVM.setup isEqualToString:@"自行安装"]) {
        _installMethodVM.pickedUpTypeNumber = @1;
    }
    else {
        _installMethodVM.pickedUpTypeNumber = @2;
    }
    _installMethodVM.belongAddress = _orderCheckVM.orderCheckM.belongAddress;
}

@end
