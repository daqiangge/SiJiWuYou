//
//  FindGoodsInfoVC.m
//  YouChengTire
//  找货详情
//  Created by WangZhipeng on 16/2/28.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "FindGoodsInfoVC.h"
// ViewModels
#import "FindGoodsInfoVM.h"
// Cells
#import "FindGoodsInfoCell.h"
#import "LQModelGoods.h"

static NSString *const kCellIdentifier = @"FindGoodsInfoCell";

@interface FindGoodsInfoVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) FindGoodsInfoVM *findGoodsInfoVM;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) LQModelGoods *model;

@end

@implementation FindGoodsInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self request];
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
    RAC(self, title) = RACObserve(_findGoodsInfoVM, title);
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
                                       configuration: ^(FindGoodsInfoCell *cell) {
                                           
                                       }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(FindGoodsInfoCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.model = self.model;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark -
#pragma mark ================= 网络请求 =================
- (void)request
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self._id forKey:@"id"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [ZPHTTP wPost:@"/app/prd/goods/getGoods" parameters:params success:^(id responseObject) {
        
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            self.model = [LQModelGoods mj_objectWithKeyValues:[[responseObject valueForKey:@"data"] valueForKey:@"goods"]];
            [self.tableView reloadData];
        }
        else
        {
            NSInteger errnoInteger = [responseObject[@"msgCode"] integerValue];
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : responseObject[@"msg"] };
            NSError *uError = [NSError errorWithDomain:@"ZPCustom"
                                                  code:errnoInteger
                                              userInfo:userInfo];
            kMRCError(uError.localizedDescription);
        }
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    }];
}

@end
