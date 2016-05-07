//
//  InviteFriendsVC.m
//  YouChengTire
//  邀请好友
//  Created by WangZhipeng on 16/1/19.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "InviteFriendsVC.h"
// Controllers
#import "RootTBC.h"
// ViewModels
#import "InviteFriendsVM.h"
// Cells
#import "InviteFriendsCell.h"

static NSString *const kCellIdentifier = @"InviteFriendsCell";

@interface InviteFriendsVC () <
UITableViewDataSource,
UITableViewDelegate,
InviteFriendsCellDelegate
>

@property (strong, nonatomic) InviteFriendsVM *inviteFriendsVM;

@end

@implementation InviteFriendsVC

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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 538;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InviteFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if(!cell) {
//        [tableView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:nil]
//        forCellReuseIdentifier:kCellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(InviteFriendsCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.delegate = self;
}

#pragma mark - InviteFriendsCellDelegate
- (void)inviteFriends {}

#pragma mark - Override
- (void)configureView {
    [self configureNavigationController];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_inviteFriendsVM, title);
}

- (void)configureData {
}

#pragma mark - Private
- (void)configureNavigationController {
    
}

#pragma mark - Custom Accessors

@end
