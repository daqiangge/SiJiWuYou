//
//  ForgetPWVC.m
//  YouChengTire
//  找回密码
//  Created by WangZhipeng on 15/12/23.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "ForgetPWVC.h"
// ViewModels
#import "ForgetPWVM.h"
// Cells
#import "ForgetPWCell.h"

static NSString *const kCellIdentifier = @"ForgetPWCell";

@interface ForgetPWVC () <
UITableViewDataSource,
UITableViewDelegate,
ForgetPWCellDelegate
>

@property (strong, nonatomic) ForgetPWVM *forgetPWVM;

@end

@implementation ForgetPWVC

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
- (void)configureView {}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_forgetPWVM, title);
    
    _forgetPWVM.loadingSuperV = self.navigationController.view;
}

- (void)configureData {
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 294;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForgetPWCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if(!cell) {
        [tableView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:nil]
        forCellReuseIdentifier:kCellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ForgetPWCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.delegate = self;
    [cell bindViewModel:_forgetPWVM];
}

#pragma mark - ForgetPWCellDelegate
- (void)forgetPW {
    [self requestUpdatePasswordByMobile];
}

#pragma mark - Private
- (void)requestUpdatePasswordByMobile {
    [MBProgressHUD showHUDAddedTo:self.navigationController.view
                         animated:NO];
    @weakify(self)
    [_forgetPWVM requestUpdatePasswordByMobile:^(id object) {
        @strongify(self)
        kMRCSuccess(@"设置新密码成功，请重新登录");
        [self.navigationController popViewControllerAnimated:YES];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:self.navigationController.view
                             animated:YES];
    }];
}

#pragma mark - Custom Accessors

@end
