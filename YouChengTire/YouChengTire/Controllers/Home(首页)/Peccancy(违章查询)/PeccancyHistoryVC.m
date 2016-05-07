//
//  PeccancyHistoryVC.m
//  YouChengTire
//  违章查询历史
//  Created by WangZhipeng on 16/2/28.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "PeccancyHistoryVC.h"
// Pods
#import "UITableView+FDTemplateLayoutCell.h"
// ViewModels
#import "PeccancyHistoryVM.h"
// Cells
#import "PeccancyHistoryCell.h"

static NSString *const kCellIdentifier = @"PeccancyHistoryCell";

@interface PeccancyHistoryVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) PeccancyHistoryVM *peccancyHistoryVM;

@property (strong, nonatomic) NSArray<NSDictionary *> *dataArray;

@end

@implementation PeccancyHistoryVC

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
    RAC(self, title) = RACObserve(_peccancyHistoryVM, title);
}

- (void)configureData {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    return _dataArray.count;
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:kCellIdentifier
                                    cacheByIndexPath:indexPath
                                       configuration: ^(PeccancyHistoryCell *cell) {
                                           
                                       }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(PeccancyHistoryCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell configureCell:_dataArray[indexPath.row]];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Private
- (void)configureNavigationController {}

@end
