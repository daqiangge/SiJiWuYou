//
//  GoodsFilterVC.m
//  YouChengTire
//  商品筛选
//  Created by WangZhipeng on 16/4/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsFilterVC.h"
// ViewModels
#import "GoodsFilterHeader.h"
#import "GoodsFilterVM.h"
// Views
#import "GoodsFilterV.h"
// Cells
#import "GoodsFilterCell.h"
// Models
#import "GoodsFilterM.h"

static NSString *const kCellIdentifier = @"GoodsFilterCell";

@interface GoodsFilterVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (nonnull, nonatomic, strong) GoodsFilterVM *goodsFilterVM;
@property (nullable, nonatomic, weak) id<GoodsFilterVCDelegate> delegate;

@end

@implementation GoodsFilterVC

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
    if ([segue.identifier isEqualToString:@"goodsFilterDataVC"]) {
        NSDictionary *obj = (NSDictionary *)sender;
        UIViewController *viewController = segue.destinationViewController;
        NSDictionary *tempDict = @{
                                   kENum : obj[kENum],
                                   kModel : _goodsFilterVM.goodsFilterM,
                                   kType : _goodsFilterVM.type
                                   };
        [viewController setValue:tempDict
                          forKey:@"transferParameters"];
    }
}

#pragma mark - Override
- (void)configureView {
    [self configureNavigationController];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_goodsFilterVM, title);
}

- (void)configureData {
    if (_goodsFilterVM.goodsFilterM) {
        [self refreshData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _goodsFilterVM.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 11.9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)_goodsFilterVM.array[section]).count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.baseTableView dequeueReusableCellWithIdentifier:kCellIdentifier];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(GoodsFilterCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell configureCell:((NSArray *)_goodsFilterVM.array[indexPath.section])[indexPath.row]];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *obj = ((NSArray *)_goodsFilterVM.array[indexPath.section])[indexPath.row];
    if ([obj[kENum] integerValue] == GoodsFilterStandardType
        && !_goodsFilterVM.goodsFilterM.standardArray) {
            kMRCInfo(@"请选择系列");
            return;
    }
    [self performSegueWithIdentifier:@"goodsFilterDataVC"
                              sender:obj];
}

#pragma mark - Private
- (void)configureNavigationController {
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(openLeftMenu:)];
    [self.navigationItem setLeftBarButtonItems:@[cancelBarButtonItem]];
    
    UIBarButtonItem *submitBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(openRightMenu:)];
    [self.navigationItem setRightBarButtonItems:@[submitBarButtonItem]];
    
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}

- (void)openLeftMenu:(id)sender {
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(callBackGoodsFilterM:)]) {
            [_delegate callBackGoodsFilterM:[GoodsFilterM new]];
        }
    }
    [[GoodsFilterV sharedManager] closeView];
}

- (void)openRightMenu:(id)sender {
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(callBackGoodsFilterM:)]) {
            [_delegate callBackGoodsFilterM:_goodsFilterVM.goodsFilterM];
        }
    }
    [[GoodsFilterV sharedManager] closeView];
}

- (void)refreshData {
    [_goodsFilterVM initializeData];
    [self.baseTableView reloadData];
}


#pragma mark - Custom Accessors
- (void)setType:(NSString *)type {
    _goodsFilterVM.type = type;
}

- (void)setGoodsFilterM:(GoodsFilterM *)goodsFilterM {
    _goodsFilterVM.goodsFilterM = goodsFilterM;
    [self refreshData];
}

@end
