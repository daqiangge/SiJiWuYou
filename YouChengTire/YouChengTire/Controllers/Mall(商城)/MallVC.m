//
//  MallVC.m
//  YouChengTire
//  商城
//  Created by WangZhipeng on 16/1/19.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "MallVC.h"
// Controllers
#import "RootTBC.h"
// ViewModels
#import "MallVM.h"
// Cells
#import "MallCell.h"

@interface MallVC () <
UITableViewDataSource,
UITableViewDelegate,
MallCellDelegate
>

@property (strong, nonatomic) MallVM *mallVM;

@end

@implementation MallVC

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
    if ([segue.identifier isEqualToString:@"goodsVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        [viewController setValue:(NSString *)sender
                          forKey:@"type"];
    }
    else if ([segue.identifier isEqualToString:@"goodsDetailsVC"]) {
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
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_mallVM, title);
    
    _mallVM.masterVC = self;
}

- (void)configureData {
    if (!_mallVM.array) {
        [self requestRefreshData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mallVM.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = _mallVM.array[indexPath.row];
    if ([data[@"kType"] isEqualToString:@"first"]) {
        return 92.f;
    }
    else if ([data[@"kType"] isEqualToString:@"second"]) {
        return 204.f;
    }
    else if ([data[@"kType"] isEqualToString:@"third"]) {
        return 28.f;
    }
    else {
        //        if (kDevice_Is_iPhone6Plus) {
        //            return 414/2;
        //        }
        //        else if (kDevice_Is_iPhone6
        //                 || kDevice_Is_iPhone6PlusEnlarge) {
        //            return 375/2;
        //        }
        //        else {
        //            return 320/2;
        //        }
        return 160.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = _mallVM.array[indexPath.row];
    if ([data[@"kType"] isEqualToString:@"first"]) {
        return [MallFirstCell createCell];
    }
    else if ([data[@"kType"] isEqualToString:@"second"]) {
        return [MallSecondCell createCell];
    }
    else if ([data[@"kType"] isEqualToString:@"third"]) {
        return [MallThirdCell createCell];
    }
    else {
        return [MallFourthCell createCell];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(MallCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.delegate = self;
    [cell bindViewModel:_mallVM];
    [cell configureCell:_mallVM.array[indexPath.row]];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = _mallVM.array[indexPath.row];
    if ([data[@"kType"] isEqualToString:@"first"]) {
        
    }
    else if ([data[@"kType"] isEqualToString:@"second"]) {
        [self performSegueWithIdentifier:@"goodsClassifyVC"
                                  sender:nil];
    }
    else if ([data[@"kType"] isEqualToString:@"third"]) {
        
    }
    else {
        //        [self performSegueWithIdentifier:@"goodsVC"
        //                                  sender:nil];
    }
}

#pragma mark - MallCellDelegate
- (void)didSelectType:(NSString *)type {
    [self performSegueWithIdentifier:@"goodsVC"
                              sender:type];
}

- (void)didSelectSId:(NSString *)sId {
    [self performSegueWithIdentifier:@"goodsDetailsVC"
                              sender:sId];
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
    [_mallVM requestRefreshData:^(id object) {
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

#pragma mark - Custom Accessors

@end
