//
//  LoginVC.m
//  YouChengTire
//  登录
//  Created by WangZhipeng on 15/12/9.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "LoginVC.h"
// ViewModels
#import "LoginVM.h"
// Cell
#import "LoginCell.h"

@interface LoginVC () <
UITableViewDataSource,
UITableViewDelegate,
LoginCellDelegate
>

@property (strong, nonatomic) LoginVM *loginVM;

@property (weak, nonatomic) IBOutlet UITableView *firstTableView;
@property (weak, nonatomic) IBOutlet UITableView *secondTableView;

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;

@property (strong, nonatomic) LoginFirstCell *loginFirstCell;
@property (strong, nonatomic) LoginSecondCell *loginSecondCell;

@end

@implementation LoginVC

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
    RAC(self, title) = RACObserve(_loginVM, title);
    
    @weakify(self)
    [RACObserve(_loginVM, isFirstNumber)
     subscribeNext:^(NSNumber *isFirstNumber) {
         @strongify(self)
         BOOL isFirst = [isFirstNumber boolValue];
         self.firstTableView.hidden = !isFirst;
         self.firstView.hidden = !isFirst;
         
         self.secondTableView.hidden = isFirst;
         self.secondView.hidden = isFirst;
         
         if (isFirst) {
             self.firstLabel.textColor = RGB(49, 49, 49);
             self.secondLabel.textColor = RGB(153, 153, 153);
         }
         else {
             self.firstLabel.textColor = RGB(153, 153, 153);
             self.secondLabel.textColor = RGB(49, 49, 49);
         }
     }];
    
    _loginVM.loadingSuperV = self.navigationController.view;
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
    if ([tableView isEqual:_firstTableView]) {
        return [self.loginFirstCell height];
    }
    else {
        return [self.loginSecondCell height];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_firstTableView]) {
        return self.loginFirstCell;
    }
    else {
        return self.loginSecondCell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {}

#pragma mark - LoginCellDelegate
- (void)login {
    [self requestLogin];
}

- (void)uRegister {
    [self performSegueWithIdentifier:@"registerVC"
                              sender:nil];
}

- (void)forgetPwd {
    [self performSegueWithIdentifier:@"forgetPWVC"
                              sender:nil];
}

- (void)loginByMobile {
    [self requestLoginByMobile];
}

#pragma mark - Private
- (void)configureNavigationController {
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(openRightMenu:)];
    [self.navigationItem setRightBarButtonItems:@[cancelBarButtonItem]];
    
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}

- (void)openRightMenu:(id)sender {
    [self dismissViewControllerAnimated:YES
                             completion:^{}];
}

- (void)requestLogin {
    [MBProgressHUD showHUDAddedTo:self.navigationController.view
                         animated:NO];
    @weakify(self)
    [_loginVM requestLogin:^(id object) {
        @strongify(self)
        [self dismissViewControllerAnimated:YES
                                 completion:^{}];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:self.navigationController.view
                             animated:YES];
    }];
}

- (void)requestLoginByMobile {
    [MBProgressHUD showHUDAddedTo:self.navigationController.view
                         animated:NO];
    @weakify(self)
    [_loginVM requestLoginByMobile:^(id object) {
        @strongify(self)
        [self dismissViewControllerAnimated:YES
                                 completion:^{}];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:self.navigationController.view
                             animated:YES];
    }];
}

#pragma mark - Event Response
- (IBAction)switchFirst:(id)sender {
    [_loginVM switchFirst];
}

- (IBAction)switchSecond:(id)sender {
    [_loginVM switchSecond];
}

#pragma mark - Custom Accessors
- (LoginFirstCell *)loginFirstCell {
    if (!_loginFirstCell) {
        _loginFirstCell = [LoginFirstCell createCell];
        _loginFirstCell.delegate = self;
        [_loginFirstCell bindViewModel:_loginVM];
    }
    return _loginFirstCell;
}

- (LoginSecondCell *)loginSecondCell {
    if (!_loginSecondCell) {
        _loginSecondCell = [LoginSecondCell createCell];
        _loginSecondCell.delegate = self;
        [_loginSecondCell bindViewModel:_loginVM];
    }
    return _loginSecondCell;
}

@end
