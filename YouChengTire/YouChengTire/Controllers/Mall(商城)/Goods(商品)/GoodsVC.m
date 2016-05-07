//
//  GoodsVC.m
//  YouChengTire
//  商品
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsVC.h"
// ViewControllers
#import "RootTBC.h"
#import "GoodsFilterVC.h"
// ViewModels
#import "GoodsVM.h"
// Cells
#import "GoodsCell.h"
// Models
#import "GoodsM.h"
// Views
#import "GoodsFilterV.h"

static NSString *const kCellIdentifier = @"GoodsCell";

@interface GoodsVC () <
UITableViewDataSource,
UITableViewDelegate,
GoodsFilterVCDelegate
>

@property (nonnull, nonatomic, strong) GoodsVM *goodsVM;

@property (nonatomic, weak) IBOutlet GoodsTopV *goodsTopRecommendV;
@property (nonatomic, weak) IBOutlet GoodsTopV *goodsTopScoreV;
@property (nonatomic, weak) IBOutlet GoodsTopV *goodsTopSalesV;
@property (nonatomic, weak) IBOutlet GoodsTopV *goodsTopPriceV;

@end

@implementation GoodsVC

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
    if ([segue.identifier isEqualToString:@"goodsDetailsVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        [viewController setValue:(NSString *)sender
                          forKey:@"sId"];
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
    [self configureGoodsFilterV];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_goodsVM, title);
    
    @weakify(self)
    [RACObserve(_goodsVM, goodsSortNumber)
     subscribeNext:^(NSNumber *goodsSortNumber) {
         @strongify(self)
         [self.goodsTopRecommendV initialize];
         [self.goodsTopScoreV initialize];
         [self.goodsTopSalesV initialize];
         [self.goodsTopPriceV initialize];
         switch ([goodsSortNumber integerValue]) {
             case GoodsSortRecommendDesc: {
                 self.goodsTopRecommendV.logoImageView.image = GETIMAGE(@"mall_sort_desc_c");
             }
                 break;
             case GoodsSortScoreDesc: {
                 self.goodsTopScoreV.logoImageView.image = GETIMAGE(@"mall_sort_desc_c");
             }
                 break;
             case GoodsSortSalesDesc: {
                 self.goodsTopSalesV.logoImageView.image = GETIMAGE(@"mall_sort_desc_c");
             }
                 break;
             case GoodsSortPriceAsc: {
                 self.goodsTopPriceV.logoImageView.image = GETIMAGE(@"mall_sort2_asc");
             }
                 break;
             case GoodsSortPriceDesc: {
                 self.goodsTopPriceV.logoImageView.image = GETIMAGE(@"mall_sort2_desc");
             }
                 break;
             default:
                 break;
         }
         [self requestRefreshData];
     }];
}

- (void)configureData {}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _goodsVM.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 108;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(GoodsCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell configureCell:_goodsVM.array[indexPath.row]];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsItemM *goodsItemM = _goodsVM.array[indexPath.row];
    [self performSegueWithIdentifier:@"goodsDetailsVC"
                              sender:goodsItemM.sId];
}

#pragma mark - GoodsFilterVCDelegate
- (void)callBackGoodsFilterM:(GoodsFilterM *)goodsFilter {
    _goodsVM.goodsFilterM = goodsFilter;
    [self requestRefreshData];
}

#pragma mark - Private
- (void)configureNavigationController {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 40, 40)];
    [rightButton setImage:[UIImage imageNamed:@"mall_icon_right"]
                 forState:UIControlStateNormal];
    //    [rightButton setImage:[UIImage imageNamed:@"mall_icon_right"]
    //                 forState:UIControlStateHighlighted];
    [rightButton addTarget:self
                    action:@selector(openRightMenu:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItems:@[[[UIBarButtonItem alloc] initWithCustomView:rightButton]]];
    
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}

- (void)openRightMenu:(id)sender {
    if ([UserM getUserM]) {
        [self performSegueWithIdentifier:@"cartVC"
                                  sender:nil];
    }
    else {
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
        UINavigationController *nc = [mainSB instantiateViewControllerWithIdentifier:@"LoginNC"];
        [ZPRootViewController presentViewController:nc
                                           animated:YES completion:^{
                                               // TODO
                                           }];
    }
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
    [_goodsVM requestRefreshData:^(id object) {
        [self.baseTableView reloadData];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [self.baseTableView.mj_header endRefreshing];
        if (self.goodsVM.isHasNext) {
            [self configureFooterRefresh];
            [self.baseTableView.mj_footer resetNoMoreData];
        }
        else {
            self.baseTableView.mj_footer = nil;
        }
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (void)configureFooterRefresh {
    @weakify(self);
    self.baseTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock: ^{
        @strongify(self);
        [self requestLoadMoreData];
    }];
}

- (void)requestLoadMoreData {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    [_goodsVM requestLoadMoreData:^(id object) {
        [self.baseTableView reloadData];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        if (self.goodsVM.isHasNext) {
            [self.baseTableView.mj_footer endRefreshing];
        }
        else {
            [self.baseTableView.mj_footer endRefreshingWithNoMoreData];
        }
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (void)configureGoodsFilterV {
    [ZPRootView addSubview:[GoodsFilterV sharedManager]];
    UIStoryboard *goodsFilterSB = [UIStoryboard storyboardWithName:@"GoodsFilter"
                                                            bundle:[NSBundle mainBundle]];
    UINavigationController *goodsFilterNC = [goodsFilterSB instantiateViewControllerWithIdentifier:@"GoodsFilterNC"];
    GoodsFilterVC *goodsFilterVC = (GoodsFilterVC *)goodsFilterNC.viewControllers.firstObject;
    [goodsFilterVC setValue:self
                     forKey:@"delegate"];
    [goodsFilterVC setValue:_goodsVM.type
                     forKey:@"type"];
    [[GoodsFilterV sharedManager].masterV addSubview:goodsFilterNC.view];
    [goodsFilterNC.view mas_makeConstraints: ^(MASConstraintMaker *make) {
        make.edges.equalTo([GoodsFilterV sharedManager].masterV);
    }];
    [GoodsFilterV sharedManager].nc = goodsFilterNC;
}

#pragma mark - Event Response
- (IBAction)recommend:(id)sender {
    if ([_goodsVM.goodsSortNumber integerValue] != GoodsSortRecommendDesc)
        _goodsVM.goodsSortNumber = @(GoodsSortRecommendDesc);
}

- (IBAction)score:(id)sender {
    if ([_goodsVM.goodsSortNumber integerValue] != GoodsSortScoreDesc)
        _goodsVM.goodsSortNumber = @(GoodsSortScoreDesc);
}

- (IBAction)sales:(id)sender {
    if ([_goodsVM.goodsSortNumber integerValue] != GoodsSortSalesDesc)
        _goodsVM.goodsSortNumber = @(GoodsSortSalesDesc);
}

- (IBAction)price:(id)sender {
    if ([_goodsVM.goodsSortNumber integerValue] == GoodsSortPriceAsc) {
        _goodsVM.goodsSortNumber = @(GoodsSortPriceDesc);
    }
    else {
        _goodsVM.goodsSortNumber = @(GoodsSortPriceAsc);
    }
}

- (IBAction)screen:(id)sender {
    GoodsFilterVC *goodsFilterVC = (GoodsFilterVC *)[GoodsFilterV sharedManager].nc.viewControllers.firstObject;
    [goodsFilterVC setValue:_goodsVM.goodsFilterM
                     forKey:@"goodsFilterM"];
    [[GoodsFilterV sharedManager] showView];
}

#pragma mark - Custom Accessors
- (void)setType:(NSString *)type {
    _goodsVM.type = type;
}

@end

@implementation GoodsTopV

- (void)initialize {
    switch (self.tag) {
        case 0: {
            _logoImageView.image = GETIMAGE(@"mall_sort_desc");
        }
            break;
            
        case 1: {
            _logoImageView.image = GETIMAGE(@"mall_sort_desc");
        }
            break;
            
        case 2: {
            _logoImageView.image = GETIMAGE(@"mall_sort_desc");
        }
            break;
            
        case 3: {
            _logoImageView.image = GETIMAGE(@"mall_sore2_default");
        }
            break;
            
        default:
            break;
    }
}

@end
