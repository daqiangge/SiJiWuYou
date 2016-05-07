//
//  PeccancyVC.m
//  YouChengTire
//  违章查询
//  Created by WangZhipeng on 16/2/28.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "PeccancyVC.h"
// Controllers
#import "RootTBC.h"
// ViewModels
#import "PeccancyVM.h"
// Cells
#import "PeccancyCell.h"

static NSString *const kCellIdentifier = @"PeccancyCell";

@interface PeccancyVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) PeccancyVM *peccancyVM;

@end

@implementation PeccancyVC

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
    RAC(self, title) = RACObserve(_peccancyVM, title);
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
    return [PeccancyCell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(PeccancyCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [cell setQuery:^{
        [self performSegueWithIdentifier:@"peccancyResultVC"
                                  sender:nil];
    }];
    
    [cell setRecord:^{
        [self performSegueWithIdentifier:@"peccancyHistoryVC"
                                  sender:nil];
    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Private
- (void)configureNavigationController {
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}

@end
