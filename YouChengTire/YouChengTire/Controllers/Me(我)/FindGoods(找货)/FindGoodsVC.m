//
//  FindGoodsVC.m
//  YouChengTire
//  找货
//  Created by WangZhipeng on 16/2/28.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "FindGoodsVC.h"
// Controllers
#import "RootTBC.h"
// ViewModels
#import "FindGoodsVM.h"
// Cells
#import "FindGoodsCell.h"
#import "LQFindGoodsInfoVC.h"
#import "LQFaHuoDetailVC.h"

static NSString *const kCellIdentifier = @"FindGoodsCell";

@interface FindGoodsVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) FindGoodsVM *findGoodsVM;

@property (strong, nonatomic) NSArray<NSDictionary *> *dataArray;

@property (nonatomic, strong) NSMutableArray *goodsArray;

@end

@implementation FindGoodsVC

- (NSMutableArray *)goodsArray
{
    if (!_goodsArray) {
        _goodsArray = [NSMutableArray array];
    }
    
    return _goodsArray;
}

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
    RAC(self, title) = RACObserve(_findGoodsVM, title);
}

- (void)configureData {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    return _dataArray.count;
    return self.goodsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(FindGoodsCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    [cell configureCell:_dataArray[indexPath.row]];
    
    cell.model = self.goodsArray[indexPath.row];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    self.selectIndex = indexPath.row;
//    
//    [self performSegueWithIdentifier:@"findGoodsInfoVC"
//                              sender:nil];
    LQModelGoods *model = self.goodsArray[indexPath.row];
//    LQFindGoodsInfoVC *vc = [[LQFindGoodsInfoVC alloc] init];
//    vc._id = model._id;
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    LQFaHuoDetailVC *vc = [[LQFaHuoDetailVC alloc] init];
    vc._id = model._id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Private
- (void)configureNavigationController {
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}

#pragma mark -
#pragma mark ================= 网络 =================
- (void)request
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [ZPHTTP wPost:@"/app/prd/goods/getGoodsList" parameters:params success:^(id responseObject) {
        
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            self.goodsArray = [NSMutableArray arrayWithArray:[LQModelGoods mj_objectArrayWithKeyValuesArray:[[responseObject valueForKey:@"data"] valueForKey:@"goodsList"]]];
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
