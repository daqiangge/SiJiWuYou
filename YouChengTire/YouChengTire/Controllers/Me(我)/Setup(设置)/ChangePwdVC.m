//
//  ChangePwdVC.m
//  YouChengTire
//  修改密码
//  Created by WangZhipeng on 16/1/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "ChangePwdVC.h"
// ViewModels
#import "ChangePwdVM.h"
// Cells
#import "ChangePwdCell.h"

static NSString *const kCellIdentifier = @"ChangePwdCell";

@interface ChangePwdVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) ChangePwdVM *changePwdVM;

@end

@implementation ChangePwdVC

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
    RAC(self, title) = RACObserve(_changePwdVM, title);
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
    return 216;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ChangePwdCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell bindViewModel:_changePwdVM];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {}


#pragma mark - Private
- (void)configureNavigationController {}

- (void)requestChangePwd {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_changePwdVM requestChangePwd:^(id object) {
        @strongify(self)
        kMRCSuccess(@"密码修改成功");
        [self.navigationController popViewControllerAnimated:YES];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (IBAction)changePassword:(id)sender {
    if (_changePwdVM.originalPassword.length < 6
        || _changePwdVM.originalPassword.length > 16) {
        kMRCError(@"您输入的原密码有误");
        _changePwdVM.originalPassword = @"";
        return;
    }
    
    if (_changePwdVM.password.length < 6
        || _changePwdVM.password.length > 16) {
        kMRCInfo(@"请输入长度为6~16个字符的新密码");
        _changePwdVM.password = @"";
        _changePwdVM.confirmPassword = @"";
        return;
    }
    
    if (_changePwdVM.confirmPassword.length < 6
        || _changePwdVM.confirmPassword.length > 16) {
        kMRCInfo(@"请输入长度为6~16个字符的确认密码");
        _changePwdVM.password = @"";
        _changePwdVM.confirmPassword = @"";
        return;
    }
    
    if (![_changePwdVM.password isEqualToString:_changePwdVM.confirmPassword]) {
        kMRCError(@"您输入的新密码和确认密码不一致");
        _changePwdVM.password = @"";
        _changePwdVM.confirmPassword = @"";
        return;
    }
    
    [self requestChangePwd];
}

#pragma mark - Custom Accessors

@end
