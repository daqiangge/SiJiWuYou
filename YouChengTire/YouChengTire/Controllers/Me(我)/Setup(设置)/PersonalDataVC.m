//
//  PersonalDataVC.m
//  YouChengTire
//  个人资料
//  Created by WangZhipeng on 16/1/19.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "PersonalDataVC.h"
// ViewModels
#import "PersonalDataVM.h"
// Cells
#import "PersonalDataCell.h"

static NSString *const kCellIdentifier = @"PersonalDataCell";

@interface PersonalDataVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) PersonalDataVM *personalDataVM;

@property (strong, nonatomic) NSArray<NSArray *> *cellArray;

@end

@implementation PersonalDataVC

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
    if ([segue.identifier isEqualToString:@"netInfoVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        [viewController setValue:_personalDataVM
                          forKey:@"personalDataVM"];
        [viewController setValue:self
                          forKey:@"previousVC"];
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
    RAC(self, title) = RACObserve(_personalDataVM, title);
    
    _personalDataVM.masterVC = self;
}

- (void)configureData {
    if (![_personalDataVM.isReloadDataSuccess boolValue]) {
        [self requestgetUser];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 398.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(PersonalDataCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell configureCell:_personalDataVM.userDetailsM];
    [cell bindViewModel:_personalDataVM];
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
    
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}

- (void)openRightMenu:(id)sender {
    if (_personalDataVM.fileImage) {
        [self requestUpdateUserWithPhoto];
    }
    else {
        [self requestUpdateUser];
    }
}

- (void)requestgetUser {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    [_personalDataVM requestgetUser:^(id object) {
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

- (void)requestUpdateUser {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    [_personalDataVM requestUpdateUser:^(id object) {
        kMRCSuccess(@"个人资料修改成功");
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
        [self requestgetUser];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (void)requestUpdateUserWithPhoto {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    [_personalDataVM requestUpdateUserWithPhoto:^(id object) {
        kMRCSuccess(@"个人资料修改成功");
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
        [self requestgetUser];
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
