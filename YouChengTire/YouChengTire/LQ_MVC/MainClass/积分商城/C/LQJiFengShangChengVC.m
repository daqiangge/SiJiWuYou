//
//  LQJiFengShangChengVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQJiFengShangChengVC.h"
#import "LQJiFenDuiHuanDetailVC.h"
#import "ModelIntegralHome.h"
#import "LQJIFenShangChengHomeCell3.h"
#import "LQModelGift.h"
#import "LQWoDeJiFengVC.h"
#import "WalletVC.h"
#import "LoginVC.h"

#import "RootTBC.h"

@interface LQJiFengShangChengVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITextField *leftTextField;
@property (nonatomic, weak) UITextField *rightTextField;
@property (nonatomic, weak) UIImageView *leftImageView;
@property (nonatomic, weak) UIImageView *rightImageView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *modelArray;

@property (nonatomic, assign) int orderBy;
@property (nonatomic, assign) int pageNo;

@end

@implementation LQJiFengShangChengVC

// WangZhipeng 当点击首页“积分类型”，隐藏底部Tabbar Start 20160430
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [(RootTBC *)ZPRootViewController setTabBarHidden:YES
                                            animated:YES];
}
// WangZhipeng 当点击首页“积分类型”，隐藏底部Tabbar Start 20160430

- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    
    return _modelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"积分商城";
    self.view.backgroundColor = COLOR_LightGray;
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"我的积分" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarBtn)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    self.orderBy = 0;
    self.pageNo = 1;
    [self drawView];
    [self requestgetGiftList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawView
{
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leftView];
    
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:rightView];
    
    UITextField *leftTextField = [[UITextField alloc] init];
    leftTextField.text = @"推荐";
    leftTextField.enabled = false;
    leftTextField.font = [UIFont systemFontOfSize:12];
    leftTextField.textColor = [UIColor redColor];
    [leftView addSubview:leftTextField];
    self.leftTextField = leftTextField;
    
    UITextField *rightTextField = [[UITextField alloc] init];
    rightTextField.text = @"积分";
    rightTextField.enabled = false;
    rightTextField.font = [UIFont systemFontOfSize:12];
    rightTextField.textColor = [UIColor lightGrayColor];
    [rightView addSubview:rightTextField];
    self.rightTextField = rightTextField;
    
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 12)];
    leftImageView.image = [UIImage imageNamed:@"mall_sort_desc_c"];
    self.leftImageView = leftImageView;
    leftTextField.rightView = leftImageView;
    leftTextField.rightViewMode = UITextFieldViewModeAlways;
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
    rightImageView.image = [UIImage imageNamed:@"mall_sore2_default"];
    self.rightImageView = rightImageView;
    rightTextField.rightView = rightImageView;
    rightTextField.rightViewMode = UITextFieldViewModeAlways;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefersh)];
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];
    
    leftView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .widthIs(kScreenWidth/2)
    .heightIs(30);
    
    rightView.sd_layout
    .leftSpaceToView(leftView,1)
    .topSpaceToView(self.view,0)
    .widthIs(kScreenWidth/2)
    .heightIs(30);
    
    leftTextField.sd_layout
    .centerXEqualToView(leftView)
    .centerYEqualToView(leftView)
    .widthIs(50)
    .heightIs(15);
    
    rightTextField.sd_layout
    .centerXEqualToView(rightView)
    .centerYEqualToView(rightView)
    .widthIs(50)
    .heightIs(15);
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(leftView,10)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLeft)];
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickright)];
    
    [leftView addGestureRecognizer:leftTap];
    [rightView addGestureRecognizer:rightTap];
    
}

- (void)clickLeft
{
    self.orderBy = 0;
    self.pageNo = 1;
    
    self.leftImageView.image = [UIImage imageNamed:@"mall_sort_desc_c"];
    self.rightImageView.image = [UIImage imageNamed:@"mall_sore2_default"];
    self.leftTextField.textColor = [UIColor redColor];
    self.rightTextField.textColor = [UIColor lightGrayColor];
    
    [self requestgetGiftList];
}

- (void)clickright
{
    if (self.orderBy == 0)
    {
        self.orderBy = 1;
        self.rightImageView.image = [UIImage imageNamed:@"mall_sort2_asc"];
        self.leftImageView.image = [UIImage imageNamed:@"mall_sort_desc"];
    }
    else if (self.orderBy == 1)
    {
        self.orderBy = 2;
        self.rightImageView.image = [UIImage imageNamed:@"mall_sort2_desc"];
        self.leftImageView.image = [UIImage imageNamed:@"mall_sort_desc"];
    }
    else
    {
        self.orderBy = 1;
        self.rightImageView.image = [UIImage imageNamed:@"mall_sort2_asc"];
        self.leftImageView.image = [UIImage imageNamed:@"mall_sort_desc"];
    }
    
    self.leftTextField.textColor = [UIColor lightGrayColor];
    self.rightTextField.textColor = [UIColor redColor];
    
    self.pageNo = 1;
    [self requestgetGiftList];
}

- (void)headerRefersh
{
    self.pageNo = 1;
    [self requestgetGiftList];
}

- (void)footerRefersh
{
    self.pageNo ++;
    [self requestgetGiftList];
}

- (void)clickRightBarBtn
{
    if ([UserM getUserM])
    {
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
        WalletVC *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"WalletVC"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *nav = [mainStoryBoard instantiateViewControllerWithIdentifier:@"LoginNC"];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark ================= 网络 =================
- (void)requestgetGiftList
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.type forKey:@"type"];
    [params setValue:@(self.orderBy) forKey:@"orderBy"];
    [params setValue:@(self.pageNo) forKey:@"pageNo"];
    [params setValue:@"999999" forKey:@"pageSize"];
    
    [ZPHTTP wPost:@"/app/prd/gift/getGiftList" parameters:params success:^(id responseObject)
    {
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            if (self.pageNo == 1)
            {
                self.modelArray = [NSMutableArray arrayWithArray:[LQModelGift mj_objectArrayWithKeyValuesArray:[[responseObject valueForKey:@"data"] valueForKey:@"giftList"]]];
            }
            else
            {
                NSArray *array = [NSMutableArray arrayWithArray:[LQModelGift mj_objectArrayWithKeyValuesArray:[[responseObject valueForKey:@"data"] valueForKey:@"giftList"]]];
                [self.modelArray addObjectsFromArray:array];
            }
            
            
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
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQJIFenShangChengHomeCell3 *cell = [LQJIFenShangChengHomeCell3 cellWithTableView:tableView];
    cell.model = self.modelArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQModelGift *model = self.modelArray[indexPath.row];
    
    LQJiFenDuiHuanDetailVC *vc = [[LQJiFenDuiHuanDetailVC alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
