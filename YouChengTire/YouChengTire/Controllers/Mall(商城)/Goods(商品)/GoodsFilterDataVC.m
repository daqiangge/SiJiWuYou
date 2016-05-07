//
//  GoodsFilterDataVC.m
//  YouChengTire
//  商品筛选数据

//  Created by WangZhipeng on 16/4/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsFilterDataVC.h"
// ViewModels
#import "GoodsFilterDataVM.h"
#import "GoodsFilterHeader.h"
// Views
#import "GoodsFilterV.h"
// Cells
#import "GoodsFilterDataCell.h"
// Models
#import "GoodsFilterDataM.h"

static NSString *const kCellIdentifier = @"GoodsFilterDataCell";

@interface GoodsFilterDataVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (nonnull, nonatomic, strong) GoodsFilterDataVM *goodsFilterDataVM;

@end

@implementation GoodsFilterDataVC

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
    RAC(self, title) = RACObserve(_goodsFilterDataVM, title);
}

- (void)configureData {
    [self requestRefreshData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 11.9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _goodsFilterDataVM.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.baseTableView dequeueReusableCellWithIdentifier:@"GoodsFilterDataCell"];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(GoodsFilterDataCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell configureCell:_goodsFilterDataVM.array[indexPath.row]];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsFilterDataM *goodsFilterDataM = _goodsFilterDataVM.array[indexPath.row];
    if (_goodsFilterDataVM.goodsFilterType != GoodsFilterProvinceType) {
        for (GoodsFilterDataM *model in _goodsFilterDataVM.array) {
            model.isSelectNumber = @NO;
        }
        goodsFilterDataM.isSelectNumber = @YES;
    }
    else {
        [_goodsFilterDataVM setGoodsFilterDataM:goodsFilterDataM];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"GoodsFilter"
                                                     bundle:[NSBundle mainBundle]];
        GoodsFilterDataVC *vc = [sb instantiateViewControllerWithIdentifier:@"GoodsFilterDataVC"];
        NSDictionary *tempDict = @{
                                   kENum : @(GoodsFilterCityType),
                                   kModel : _goodsFilterDataVM.goodsFilterM,
                                   kType : _goodsFilterDataVM.type
                                   };
        [vc setValue:tempDict
              forKey:@"transferParameters"];
        [self.navigationController pushViewController:vc
                                             animated:YES];
    }
}

#pragma mark - Private
- (void)configureNavigationController {
    if (_goodsFilterDataVM.goodsFilterType != GoodsFilterProvinceType) {
        UIBarButtonItem *submitBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:self
                                                                               action:@selector(openRightMenu:)];
        [self.navigationItem setRightBarButtonItems:@[submitBarButtonItem]];
    }
    
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}

- (void)openRightMenu:(id)sender {
    GoodsFilterDataM *goodsFilterDataM = nil;
    for (GoodsFilterDataM *model in _goodsFilterDataVM.array) {
        if ([model.isSelectNumber boolValue]) {
            goodsFilterDataM = model;
            break;
        }
    }
    [_goodsFilterDataVM setGoodsFilterDataM:goodsFilterDataM];
    if (_goodsFilterDataVM.goodsFilterType != GoodsFilterCityType) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)requestRefreshData {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    [_goodsFilterDataVM requestRefreshData:^(id object) {
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

- (void)setTransferParameters:(NSDictionary *)transferParameters {
    
    GoodsFilterType goodsFilterType = [transferParameters[kENum] integerValue];
    switch (goodsFilterType) {
        case GoodsFilterProvinceType:
            _goodsFilterDataVM = [GoodsFilterProvinceDataVM new];
            self.navigationItem.rightBarButtonItems = nil;
            break;
            
        case GoodsFilterCityType:
            _goodsFilterDataVM = [GoodsFilterCityDataVM new];
            break;
            
        case GoodsFilterBrandType:
            _goodsFilterDataVM = [GoodsFilterBrandDataVM new];
            break;
            
        case GoodsFilterSeriesType:
            _goodsFilterDataVM = [GoodsFilterSeriesDataVM new];
            break;
            
        case GoodsFilterStandardType:
            _goodsFilterDataVM = [GoodsFilterStandardDataVM new];
            break;
            
        default:
            break;
    }
    _goodsFilterDataVM.type = transferParameters[kType];
    _goodsFilterDataVM.goodsFilterM = transferParameters[kModel];
}


@end
