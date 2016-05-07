//
//  FeedbackVC.m
//  YouChengTire
//  用户反馈
//  Created by WangZhipeng on 16/1/19.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "FeedbackVC.h"
// Controllers
#import "RootTBC.h"
// ViewModels
#import "FeedbackVM.h"
// Cells
#import "FeedbackCell.h"

static NSString *const kCellIdentifier = @"FeedbackCell";

@interface FeedbackVC () <
UITableViewDataSource,
UITableViewDelegate,
FeedbackCellDelegate
>

@property (strong, nonatomic) FeedbackVM *feedbackVM;

@end

@implementation FeedbackVC

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
    RAC(self, title) = RACObserve(_feedbackVM, title);
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
    return 263;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedbackCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if(!cell) {
//        [tableView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:nil]
//        forCellReuseIdentifier:kCellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(FeedbackCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.delegate = self;
    [cell bindViewModel:_feedbackVM];
}

#pragma mark - FeedbackCellDelegate
- (void)feedback {
    [self requestSaveFeedback];
}

#pragma mark - Private
- (void)configureNavigationController {
    
}

#pragma mark - Private
- (void)requestSaveFeedback {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_feedbackVM requestSaveFeedback:^(id object) {
        @strongify(self)
        kMRCSuccess(@"感谢您的建议反馈");
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

#pragma mark - Custom Accessors

@end
