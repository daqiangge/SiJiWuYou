//
//  GoodsDetailsVC.m
//  YouChengTire
//  商品详情
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsDetailsVC.h"
// ViewModels
#import "GoodsDetailsVM.h"
// Cells
#import "GoodsDetailsCell.h"
// Models
#import "GoodsDetailsM.h"

@interface GoodsDetailsVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) GoodsDetailsVM *goodsDetailsVM;

@end

@implementation GoodsDetailsVC

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
    if ([segue.identifier isEqualToString:@"goodsParameterVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        [viewController setValue:_goodsDetailsVM.product.appPictureDescUrl
                          forKey:@"appPictureDescUrl"];
        [viewController setValue:_goodsDetailsVM.product.parametersUrl
                          forKey:@"parametersUrl"];
        [viewController setValue:_goodsDetailsVM.product.sId
                          forKey:@"parentId"];
        [viewController setValue:(NSNumber *)sender
                          forKey:@"tabNumber"];
    }
    else if ([segue.identifier isEqualToString:@"orderCheckVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        [viewController setValue:_goodsDetailsVM.sId
                          forKey:@"productId"];
        [viewController setValue:_goodsDetailsVM.productCount
                          forKey:@"productCount"];
        [viewController setValue:_goodsDetailsVM.orderCheckM
                          forKey:@"orderCheckM"];
    }
}

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
    
    _goodsDetailsVM.masterVC = self;
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
    RAC(self, title) = RACObserve(_goodsDetailsVM, title);
}

- (void)configureData {
    if (!_goodsDetailsVM.array) {
        [self requestRefreshData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _goodsDetailsVM.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)_goodsDetailsVM.array[section]).count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = ((NSArray *)_goodsDetailsVM.array[indexPath.section])[indexPath.row];
    if ([data[kCell] isEqualToString:@"GoodsDetailsFirstCell"]) {
        if (kDeviceIsiPhone6Plus) {
            return 414;
        }
        else if (kDeviceIsiPhone6
                 || kDeviceIsiPhone6PlusEnlarge) {
            return 375;
        }
        else if (kDeviceIsiPhone5) {
            return 320;
        }
        else{
            return 320;
        }
    }
    else if ([data[kCell] isEqualToString:@"GoodsDetailsSecondCell"]) {
        return [tableView fd_heightForCellWithIdentifier:@"GoodsDetailsSecondCell"
                                        cacheByIndexPath:indexPath
                                           configuration: ^(GoodsDetailsSecondCell *cell) {
                                               // TODO
                                           }];
    }
    else if ([data[kCell] isEqualToString:@"GoodsDetailsThirdCell"]) {
        return 44.f;
    }
    else if ([data[kCell] isEqualToString:@"GoodsDetailsFourthCell"]) {
        return 44.f;
    }
    else if ([data[kCell] isEqualToString:@"GoodsDetailsFifthCell"]) {
        return 44.f;
    }
    else if ([data[kCell] isEqualToString:@"GoodsDetailsSixthCell"]) {
        return 44.f;
    }
    else if ([data[kCell] isEqualToString:@"GoodsDetailsSeventhCell"]) {
        return 114.f;
    }
    else if ([data[kCell] isEqualToString:@"GoodsDetailsEighthCell"]) {
        return 44.f;
    }
    else if ([data[kCell] isEqualToString:@"GoodsDetailsNinthCell"]) {
        return 108.f;
    }
    else if ([data[kCell] isEqualToString:@"GoodsDetailsTenthCell"]) {
        return 44.f;
    }
    else {
        return 0.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = ((NSArray *)_goodsDetailsVM.array[indexPath.section])[indexPath.row];
    return [tableView dequeueReusableCellWithIdentifier:data[kCell]];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(GoodsDetailsCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell bindViewModel:_goodsDetailsVM];
    [cell configureCell:((NSArray *)_goodsDetailsVM.array[indexPath.section])[indexPath.row]];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = ((NSArray *)_goodsDetailsVM.array[indexPath.section])[indexPath.row];
    SEL normalSelector = NSSelectorFromString(data[@"kMethod"]);
    if ([self respondsToSelector:normalSelector]) {
        ((void (*)(id, SEL))objc_msgSend)(self, normalSelector);
    }
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

- (void)requestRefreshData {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_goodsDetailsVM requestRefreshData:^(id object) {
        @strongify(self)
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

- (void)requestSubmitOrder {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_goodsDetailsVM requestSubmitOrder:^(id object) {
        @strongify(self)
        [self performSegueWithIdentifier:@"orderCheckVC"
                                  sender:nil];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (void)requestSaveCart {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    [_goodsDetailsVM requestSaveCart:^(id object) {
        kMRCSuccess(@"购物车添加商品成功");
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
 *  用户评论
 */
- (void)userComment {
    [self performSegueWithIdentifier:@"goodsParameterVC"
                              sender:@(3)];
}

/**
 *  图文详情
 */
- (void)graphicDetails {
    [self performSegueWithIdentifier:@"goodsParameterVC"
                              sender:@(1)];
}

/**
 *  产品参数
 */
- (void)productParameters {
    [self performSegueWithIdentifier:@"goodsParameterVC"
                              sender:@(2)];
}

#pragma mark - Event Response
- (IBAction)buyNow:(id)sender {
    if ([UserM getUserM]) {
        [self requestSubmitOrder];
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

- (IBAction)saveCart:(id)sender {
    if ([UserM getUserM]) {
        [self requestSaveCart];
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

- (IBAction)telephoneConsultation:(id)sender {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"客服中心"
                                          message:@"工作时间: 8:30~21:00"
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"呼叫"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [[UIApplication sharedApplication]
                                                            openURL:[NSURL URLWithString:@"tel:400-820-9686"]];
                                                       }];
    [alertController addAction:callAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

- (IBAction)onlineService:(id)sender {}

#pragma mark - Custom Accessors
- (void)setSId:(NSString *)sId {
    _goodsDetailsVM.sId = sId;
}

@end
