//
//  OrderFrameVC.m
//  YouChengTire
//  订单框架
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderFrameVC.h"
// ViewControllers
#import "RootTBC.h"
// ViewModels
#import "OrderFrameVM.h"
#import "OrderDetailsVM.h"
// Cells
#import "OrderFrameCell.h"
// Models
#import "OrderFrameM.h"

@interface OrderFrameVC ()

@property (strong, nonatomic) OrderFrameVM *orderFrameVM;

@property (weak, nonatomic) IBOutlet UITableView *firstTableView;
@property (weak, nonatomic) IBOutlet UITableView *secondTableView;
@property (weak, nonatomic) IBOutlet UITableView *thirdTableView;

@property (weak, nonatomic) IBOutlet UITableView *fifthTableView;

@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UIView *fourthView;
@property (weak, nonatomic) IBOutlet UIView *fifthView;

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourthLabel;
@property (weak, nonatomic) IBOutlet UILabel *fifthLabel;

@property (strong, nonatomic) NSArray<UITableView *> *tableViewArray;
@property (strong, nonatomic) NSArray<UIView *> *viewArray;
@property (strong, nonatomic) NSArray<UILabel *> *lableArray;

@end

@implementation OrderFrameVC

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
    if ([segue.identifier isEqualToString:@"orderDetailsVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        [viewController setValue:(NSString *)sender
                          forKey:@"orderId"];
    }
    else if ([segue.identifier isEqualToString:@"orderPayVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        OrderFrameM *model = (OrderFrameM *)sender;
        [viewController setValue:model.sId
                          forKey:@"orderId"];
        [viewController setValue:model.totalPrice
                          forKey:@"totalPrice"];
        [viewController setValue:self
                          forKey:@"masterVC"];
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
    
    _tableViewArray = @[
                        _firstTableView,
                        _secondTableView,
                        _thirdTableView,
                        _fourthTableView,
                        _fifthTableView
                        ];
    
    _lableArray = @[
                    _firstLabel,
                    _secondLabel,
                    _thirdLabel,
                    _fourthLabel,
                    _fifthLabel
                    ];
    
    _viewArray = @[
                   _firstView,
                   _secondView,
                   _thirdView,
                   _fourthView,
                   _fifthView
                   ];
    
    [self configureCell];
    [self configureHeaderRefresh];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_orderFrameVM, title);
    
    _orderFrameVM.masterVC = self;
    
    @weakify(self)
    [RACObserve(_orderFrameVM, tabNumber)
     subscribeNext:^(NSNumber *tabNumber) {
         @strongify(self)
         for (NSInteger i = 0; i < 5; i++) {
             BOOL tempBool = YES;
             UIColor *tempColor = RGB(153, 153, 153);
             if ([tabNumber integerValue] == i) {
                 tempBool = NO;
                 tempColor = RGB(49, 49, 49);
             }
             self.tableViewArray[i].hidden = tempBool;
             self.viewArray[i].hidden = tempBool;
             self.lableArray[i].textColor = tempColor;
         }
         [self requestRefreshData];
     }];
}

- (void)configureData {}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    switch (tableView.tag) {
        case 0:{
            return _orderFrameVM.fristArray.count;
        }
            break;
            
        case 1:{
            return _orderFrameVM.secondArray.count;
        }
            break;
            
        case 2:{
            return _orderFrameVM.thirdArray.count;
        }
            break;
            
        case 3:{
            return _orderFrameVM.fourthArray.count;
        }
            break;
            
        case 4:{
            return _orderFrameVM.fifthArray.count;
        }
            break;
            
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 8.f;
    }
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (tableView.tag) {
        case 0:{
            return ((NSArray *)_orderFrameVM.fristArray[section]).count;
        }
            break;
            
        case 1:{
            return ((NSArray *)_orderFrameVM.secondArray[section]).count;
        }
            break;
            
        case 2:{
            return ((NSArray *)_orderFrameVM.thirdArray[section]).count;
        }
            break;
            
        case 3:{
            return ((NSArray *)_orderFrameVM.fourthArray[section]).count;
        }
            break;
            
        case 4:{
            return ((NSArray *)_orderFrameVM.fifthArray[section]).count;
        }
            break;
            
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = nil;
    switch (tableView.tag) {
        case 0:{
            data = ((NSArray *)_orderFrameVM.fristArray[indexPath.section])[indexPath.row];
        }
            break;
            
        case 1:{
            data = ((NSArray *)_orderFrameVM.secondArray[indexPath.section])[indexPath.row];
        }
            break;
            
        case 2:{
            data = ((NSArray *)_orderFrameVM.thirdArray[indexPath.section])[indexPath.row];
        }
            break;
            
        case 3:{
            data = ((NSArray *)_orderFrameVM.fourthArray[indexPath.section])[indexPath.row];
        }
            break;
            
        case 4:{
            data = ((NSArray *) _orderFrameVM.fifthArray[indexPath.section])[indexPath.row];
        }
            break;
            
        default:
            break;
    }
    if ([data[@"kType"] isEqualToString:@"first"]) {
        return 44.f;
    }
    else if ([data[@"kType"] isEqualToString:@"second"]) {
        return 88.f;
    }
    if ([data[@"kType"] isEqualToString:@"third"]) {
        return 66.f;
    }
    else {
        return 0.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = nil;
    switch (tableView.tag) {
        case 0:{
            data = ((NSArray *)_orderFrameVM.fristArray[indexPath.section])[indexPath.row];
        }
            break;
            
        case 1:{
            data = ((NSArray *)_orderFrameVM.secondArray[indexPath.section])[indexPath.row];
        }
            break;
            
        case 2:{
            data = ((NSArray *)_orderFrameVM.thirdArray[indexPath.section])[indexPath.row];
        }
            break;
            
        case 3:{
            data = ((NSArray *)_orderFrameVM.fourthArray[indexPath.section])[indexPath.row];
        }
            break;
            
        case 4:{
            data = ((NSArray *) _orderFrameVM.fifthArray[indexPath.section])[indexPath.row];
        }
            break;
            
        default:
            break;
    }
    if ([data[@"kType"] isEqualToString:@"first"]) {
        return [tableView dequeueReusableCellWithIdentifier:@"OrderFrameFirstCell"];
    }
    else if ([data[@"kType"] isEqualToString:@"second"]) {
        return [tableView dequeueReusableCellWithIdentifier:@"OrderFrameSecondCell"];
    }
    if ([data[@"kType"] isEqualToString:@"third"]) {
        return [tableView dequeueReusableCellWithIdentifier:@"OrderFrameThirdCell"];
    }
    else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(OrderFrameCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = nil;
    switch (tableView.tag) {
        case 0:{
            data = ((NSArray *)_orderFrameVM.fristArray[indexPath.section])[indexPath.row];
        }
            break;
            
        case 1:{
            data = ((NSArray *)_orderFrameVM.secondArray[indexPath.section])[indexPath.row];
        }
            break;
            
        case 2:{
            data = ((NSArray *)_orderFrameVM.thirdArray[indexPath.section])[indexPath.row];
        }
            break;
            
        case 3:{
            data = ((NSArray *)_orderFrameVM.fourthArray[indexPath.section])[indexPath.row];
        }
            break;
            
        case 4:{
            data = ((NSArray *) _orderFrameVM.fifthArray[indexPath.section])[indexPath.row];
        }
            break;
            
        default:
            break;
    }
    [cell bindViewModel:_orderFrameVM];
    [cell configureCell:data];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = nil;
    switch (tableView.tag) {
        case 0:{
            data = ((NSArray *)_orderFrameVM.fristArray[indexPath.section])[0];
        }
            break;
            
        case 1:{
            data = ((NSArray *)_orderFrameVM.secondArray[indexPath.section])[0];
        }
            break;
            
        case 2:{
            data = ((NSArray *)_orderFrameVM.thirdArray[indexPath.section])[0];
        }
            break;
            
        case 3:{
            data = ((NSArray *)_orderFrameVM.fourthArray[indexPath.section])[0];
        }
            break;
            
        case 4:{
            data = ((NSArray *) _orderFrameVM.fifthArray[indexPath.section])[0];
        }
            break;
            
        default:
            break;
    }
    OrderFrameM *orderFrameM = data[@"kModel"];
    [self performSegueWithIdentifier:@"orderDetailsVC"
                              sender:orderFrameM.sId];
}

#pragma mark - Private
- (void)configureNavigationController {
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}

- (void)configureCell {
    for (UITableView *tableView in _tableViewArray) {
        [tableView registerNib:[UINib nibWithNibName:@"OrderFrameFirstCell" bundle:nil]
        forCellReuseIdentifier:@"OrderFrameFirstCell"];
        [tableView registerNib:[UINib nibWithNibName:@"OrderFrameSecondCell" bundle:nil]
        forCellReuseIdentifier:@"OrderFrameSecondCell"];
        [tableView registerNib:[UINib nibWithNibName:@"OrderFrameThirdCell" bundle:nil]
        forCellReuseIdentifier:@"OrderFrameThirdCell"];
    }
}

- (void)configureHeaderRefresh {
    @weakify(self);
    self.firstTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock: ^{
        @strongify(self);
        [self requestRefreshData];
    }];
    self.secondTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock: ^{
        @strongify(self);
        [self requestRefreshData];
    }];
    self.thirdTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock: ^{
        @strongify(self);
        [self requestRefreshData];
    }];
    self.fourthTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock: ^{
        @strongify(self);
        [self requestRefreshData];
    }];
    self.fifthTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock: ^{
        @strongify(self);
        [self requestRefreshData];
    }];
}

- (void)requestRefreshData {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    [_orderFrameVM requestRefreshData:^(id object) {
        switch ([self.orderFrameVM.tabNumber integerValue]) {
            case 0: {
                [self.firstTableView reloadData];
            }
                break;
                
            case 1: {
                [self.secondTableView reloadData];
            }
                break;
                
            case 2: {
                [self.thirdTableView reloadData];
            }
                break;
                
            case 3: {
                [self.fourthTableView reloadData];
            }
                break;
                
            case 4: {
                [self.fifthTableView reloadData];
            }
                break;
                
            default:
                break;
        }
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        switch ([self.orderFrameVM.tabNumber integerValue]) {
            case 0: {
                [self.firstTableView.mj_header endRefreshing];
                if (self.orderFrameVM.fristIsHasNext) {
                    [self configureFooterRefresh];
                    [self.firstTableView.mj_footer resetNoMoreData];
                }
                else {
                    self.firstTableView.mj_footer = nil;
                }
            }
                break;
                
            case 1: {
                [self.secondTableView.mj_header endRefreshing];
                if (self.orderFrameVM.secondIsHasNext) {
                    [self configureFooterRefresh];
                    [self.secondTableView.mj_footer resetNoMoreData];
                }
                else {
                    self.secondTableView.mj_footer = nil;
                }
            }
                break;
                
            case 2: {
                [self.thirdTableView.mj_header endRefreshing];
                if (self.orderFrameVM.thirdIsHasNext) {
                    [self configureFooterRefresh];
                    [self.thirdTableView.mj_footer resetNoMoreData];
                }
                else {
                    self.thirdTableView.mj_footer = nil;
                }
            }
                break;
                
            case 3: {
                [self.fourthTableView.mj_header endRefreshing];
                if (self.orderFrameVM.fourthIsHasNext) {
                    [self configureFooterRefresh];
                    [self.fourthTableView.mj_footer resetNoMoreData];
                }
                else {
                    self.fourthTableView.mj_footer = nil;
                }
            }
                break;
                
            case 4: {
                [self.fifthTableView.mj_header endRefreshing];
                if (self.orderFrameVM.fifthIsHasNext) {
                    [self configureFooterRefresh];
                    [self.fifthTableView.mj_footer resetNoMoreData];
                }
                else {
                    self.fifthTableView.mj_footer = nil;
                }
            }
                break;
                
            default:
                break;
        }
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (void)configureFooterRefresh {
    switch ([self.orderFrameVM.tabNumber integerValue]) {
        case 0: {
            @weakify(self);
            self.firstTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock: ^{
                @strongify(self);
                [self requestLoadMoreData];
            }];
        }
            break;
            
        case 1: {
            @weakify(self);
            self.secondTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock: ^{
                @strongify(self);
                [self requestLoadMoreData];
            }];
        }
            break;
            
        case 2: {
            @weakify(self);
            self.thirdTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock: ^{
                @strongify(self);
                [self requestLoadMoreData];
            }];
        }
            break;
            
        case 3: {
            @weakify(self);
            self.fourthTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock: ^{
                @strongify(self);
                [self requestLoadMoreData];
            }];
        }
            break;
            
        case 4: {
            @weakify(self);
            self.fifthTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock: ^{
                @strongify(self);
                [self requestLoadMoreData];
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)requestLoadMoreData {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    [_orderFrameVM requestLoadMoreData:^(id object) {
        switch ([self.orderFrameVM.tabNumber integerValue]) {
            case 0: {
                [self.firstTableView reloadData];
            }
                break;
                
            case 1: {
                [self.secondTableView reloadData];
            }
                break;
                
            case 2: {
                [self.thirdTableView reloadData];
            }
                break;
                
            case 3: {
                [self.fourthTableView reloadData];
            }
                break;
                
            case 4: {
                [self.fifthTableView reloadData];
            }
                break;
                
            default:
                break;
        }
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        switch ([self.orderFrameVM.tabNumber integerValue]) {
            case 0: {
                if (self.orderFrameVM.fristIsHasNext) {
                    [self.firstTableView.mj_footer endRefreshing];
                }
                else {
                    [self.firstTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
                break;
                
            case 1: {
                if (self.orderFrameVM.secondIsHasNext) {
                    [self.secondTableView.mj_footer endRefreshing];
                }
                else {
                    [self.secondTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
                break;
                
            case 2: {
                if (self.orderFrameVM.thirdIsHasNext) {
                    [self.thirdTableView.mj_footer endRefreshing];
                }
                else {
                    [self.thirdTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
                break;
                
            case 3: {
                if (self.orderFrameVM.fourthIsHasNext) {
                    [self.fourthTableView.mj_footer endRefreshing];
                }
                else {
                    [self.fourthTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
                break;
                
            case 4: {
                if (self.orderFrameVM.fifthIsHasNext) {
                    [self.fifthTableView.mj_footer endRefreshing];
                }
                else {
                    [self.fifthTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
                break;
                
            default:
                break;
        }
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

#pragma mark - Event Response
- (IBAction)switchTab:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (!([_orderFrameVM.tabNumber integerValue] == button.tag)) {
        _orderFrameVM.tabNumber = @(button.tag);
    }
}

@end
