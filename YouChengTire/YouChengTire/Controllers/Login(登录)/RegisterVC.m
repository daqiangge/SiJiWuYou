//
//  RegisterVC.m
//  YouChengTire
//  注册
//  Created by WangZhipeng on 15/12/23.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "RegisterVC.h"
// ViewModels
#import "RegisterVM.h"
// Cells
#import "RegisterCell.h"

static NSString *const kCellIdentifier = @"RegisterCell";

@interface RegisterVC () <
UITableViewDataSource,
UITableViewDelegate,
RegisterCellDelegate
>

@property (strong, nonatomic) RegisterVM *registerVM;

@end

@implementation RegisterVC

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
- (void)configureView {
    [self configureNavigationController];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_registerVM, title);
    
    _registerVM.loadingSuperV = self.navigationController.view;
}

- (void)configureData {}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 346;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RegisterCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if(!cell) {
        [tableView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:nil]
        forCellReuseIdentifier:kCellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(RegisterCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.delegate = self;
    [cell bindViewModel:_registerVM];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {}

#pragma mark - RegisterCellDelegate
- (void)uRegister {
    [self requestSave];
}

#pragma mark - Private
- (void)configureNavigationController {
}

- (void)openRightMenu:(id)sender {
    [self dismissViewControllerAnimated:YES
                             completion:^{}];
}

- (void)requestSave {
    [MBProgressHUD showHUDAddedTo:self.navigationController.view
                         animated:NO];
    @weakify(self)
    [_registerVM requestSave:^(id object) {
        @strongify(self)
        kMRCSuccess(@"恭喜您，账号注册成功");
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
