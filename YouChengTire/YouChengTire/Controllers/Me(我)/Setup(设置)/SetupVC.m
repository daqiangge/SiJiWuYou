//
//  SetupVC.m
//  YouChengTire
//  设置
//  Created by WangZhipeng on 16/1/19.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "SetupVC.h"
#import "AppDelegate.h"
// Controllers
#import "RootTBC.h"
// ViewModels
#import "SetupVM.h"
// Cells
#import "SetupCell.h"

@interface SetupVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) SetupVM *setupVM;

@property (strong, nonatomic) NSArray<NSArray *> *cellArray;

@end

@implementation SetupVC

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
    RAC(self, title) = RACObserve(_setupVM, title);
}

- (void)configureData {
    _cellArray = [_setupVM cellArray];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _cellArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 11.9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellArray[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [(SetupCell *)(_cellArray[indexPath.section][indexPath.row]) height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cellArray[indexPath.section][indexPath.row];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SetupCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    SEL normalSelector = NSSelectorFromString(cell.dictionary[@"kMethod"]);
    if ([self respondsToSelector:normalSelector]) {
        ((void (*)(id, SEL))objc_msgSend)(self, normalSelector);
    }
}

#pragma mark - Private
- (void)configureNavigationController {
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}

- (void)personalData {
    if ([UserM getUserM]) {
        [self performSegueWithIdentifier:@"personalDataVC"
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

- (void)changePwd {
    if ([UserM getUserM]) {
        [self performSegueWithIdentifier:@"changePwdVC"
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

- (void)clearCache {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                             message:@"您确定要清除缓存吗？"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction_cancel = [UIAlertAction actionWithTitle:@"取消"
                                                                 style:UIAlertActionStyleDefault
                                                               handler: ^(UIAlertAction *action) {}];
    [alertController addAction:alertAction_cancel];
    UIAlertAction *alertAction_ok = [UIAlertAction actionWithTitle:@"确定"
                                                             style:UIAlertActionStyleDefault
                                                           handler: ^(UIAlertAction *action) {
                                                               kMRCSuccess(@"清理缓存成功");
                                                               [AppDelegate cleanCache];
                                                           }];
    [alertController addAction:alertAction_ok];
    [ZPRootViewController presentViewController:alertController
                                       animated:YES
                                     completion:nil];
}

- (void)aboutUs {
    [self performSegueWithIdentifier:@"aboutUsVC"
                              sender:nil];
}

- (void)encourage {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAppStore]];
}

- (void)logout {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:@"您确定要退出登录吗？"
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *alertAction_ok = [UIAlertAction actionWithTitle:@"确定"
                                                             style:UIAlertActionStyleDestructive
                                                           handler: ^(UIAlertAction *action) {
                                                               UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main"
                                                                                                                bundle:[NSBundle mainBundle]];
                                                               UINavigationController *nc = [mainSB instantiateViewControllerWithIdentifier:@"LoginNC"];
                                                               [ZPRootViewController presentViewController:nc
                                                                                                  animated:YES completion:^{
                                                                                                      [UserM setUserM:nil];
                                                                                                      [self.navigationController popToRootViewControllerAnimated:NO];
                                                                                                  }];
                                                           }];
    [alertController addAction:alertAction_ok];
    UIAlertAction *alertAction_cancel = [UIAlertAction actionWithTitle:@"取消"
                                                                 style:UIAlertActionStyleCancel
                                                               handler: ^(UIAlertAction *action) {}];
    [alertController addAction:alertAction_cancel];
    [ZPRootViewController presentViewController:alertController
                                       animated:YES
                                     completion:nil];
}

#pragma mark - Custom Accessors

@end
