//
//  VisitingInstallDetailsVC.m
//  YouChengTire
//
//  Created by Baby on 16/4/14.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "VisitingInstallDetailsVC.h"
#import "ServiceVM.h"

@interface VisitingInstallDetailsVC ()
@property (nonatomic, strong) ServiceVM * serviceVM;
@property (nonatomic, strong) NSDictionary * dataDic;
@end

@implementation VisitingInstallDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.serviceVM = [[ServiceVM alloc] init];
    
    NSMutableDictionary * params = @{@"id":self.orderId}.mutableCopy;
    [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [self.serviceVM requestGetSetup:^(id object) {
        @strongify(self)

    } data:params error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1.0f;
    }
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 1.0;
//}

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

@end
