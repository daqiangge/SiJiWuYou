//
//  DeliverGoodsInfoVC.m
//  YouChengTire
//  发货详情
//  Created by WangZhipeng on 16/2/28.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "DeliverGoodsInfoVC.h"
// Pods
#import "UITableView+FDTemplateLayoutCell.h"
// ViewModels
#import "DeliverGoodsInfoVM.h"
// Cells
#import "DeliverGoodsInfoCell.h"

static NSString *const kCellIdentifier = @"DeliverGoodsInfoCell";

@interface DeliverGoodsInfoVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) DeliverGoodsInfoVM *deliverGoodsInfoVM;

@end

@implementation DeliverGoodsInfoVC

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
- (void)configureView {}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_deliverGoodsInfoVM, title);
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
    return [tableView fd_heightForCellWithIdentifier:kCellIdentifier
                                    cacheByIndexPath:indexPath
                                       configuration: ^(DeliverGoodsInfoCell *cell) {
                                           
                                       }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(DeliverGoodsInfoCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
