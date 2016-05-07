//
//  LQFindGoodsInfoVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQFindGoodsInfoVC.h"
#import "LQFindGoodsInfoCell.h"
#import "LQModelGoods.h"
#import "LQFindGoodsInfoCell2.h"

@interface LQFindGoodsInfoVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) LQModelGoods *model;

@end

@implementation LQFindGoodsInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"货源详情";
    
    [self drawView];
    [self request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}


#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 5;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        LQFindGoodsInfoCell *cell = [LQFindGoodsInfoCell cellWithTableView:tableView];
        
        switch (indexPath.row)
        {
            case 0:
            {
                cell.label1.text = @"货源名称";
                cell.label2.text = self.model.name;
            }
                break;
            case 1:
            {
                cell.label1.text = @"始发地";
                cell.label2.text = self.model.startPoint;
            }
                break;
            case 2:
            {
                cell.label1.text = @"目的地";
                cell.label2.text = self.model.endPoint;
            }
                break;
            case 3:
            {
                cell.label1.text = @"联系人";
                cell.label2.text = self.model.contacts;
            }
                break;
            case 4:
            {
                cell.label1.text = @"联系电话";
                cell.label2.text = self.model.mobile;
            }
                break;
                
            default:
                break;
        }
        
        return cell;
    }
    else
    {
        LQFindGoodsInfoCell2 *cell = [LQFindGoodsInfoCell2 cellWithTableView:tableView];
        
        if (self.model)
        {
            cell.str = self.model.content;
        }
        
        
        return cell;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 50;
    }
    else
    {
        return 150;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
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
