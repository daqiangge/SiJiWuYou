//
//  LQVisitingInstallDetailsVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/28.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQVisitingInstallDetailsVC.h"
#import "LQOrderClaimsShangMengTimeCell.h"
#import "LQOrderClaimsAddressCell.h"
#import "LQOrderClaimsAddressDetailCell.h"
#import "LQModelSetup.h"
#import "LQSetUpCell.h"

@interface LQVisitingInstallDetailsVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) ReceiptAddressItemM *addressModel;
@property (nonatomic, strong) LQModelSetup *model;

@property (nonatomic, weak) UIButton *leftBtn;
@property (nonatomic, weak) UIButton *rightBtn;
@end

@implementation LQVisitingInstallDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"订单详情";
    
    [self drawView];
    [self requsetgetSetup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIButton *leftBtn = [[UIButton alloc] init];
    [leftBtn setTitle:@"删除订单" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    leftBtn.layer.borderColor = COLOR_LightGray.CGColor;
    leftBtn.layer.borderWidth = 0.5;
    leftBtn.backgroundColor = [UIColor whiteColor];
    [leftBtn addTarget:self action:@selector(deleteOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    self.leftBtn = leftBtn;
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:@"服务评价" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    rightBtn.layer.borderColor = COLOR_LightGray.CGColor;
    rightBtn.layer.borderWidth = 0.5;
    rightBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:rightBtn];
    self.rightBtn = rightBtn;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0);
    
    rightBtn.sd_layout
    .rightSpaceToView(self.view,15)
    .bottomSpaceToView(self.view,15)
    .widthIs(60)
    .heightIs(20);
    
    leftBtn.sd_layout
    .rightSpaceToView(rightBtn,15)
    .bottomSpaceToView(self.view,15)
    .widthIs(60)
    .heightIs(20);
}

- (void)deleteOrder
{
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:@"" animated:YES];
    NSMutableDictionary * params = @{@"id":self.orderID}.mutableCopy;
    [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [ZPHTTP wPost:@"/app/service/setup/deleteSetup"
       parameters:params
          success:^(NSDictionary *object) {
              [MBProgressHUD hideAllHUDsForView:Window animated:YES];
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess])
              {
                  kMRCSuccess(@"订单删除成功");
                  
                  if (self.deleteOrderSuccess)
                  {
                      self.deleteOrderSuccess();
                  }
                  
                  [self.navigationController popViewControllerAnimated:YES];
              }
              else
              {
                  NSInteger errnoInteger = [object[@"msgCode"] integerValue];
                  NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : object[@"msg"] };
                  NSError *uError = [NSError errorWithDomain:@"ZPCustom"
                                                        code:errnoInteger
                                                    userInfo:userInfo];
                  kMRCError(uError.localizedDescription);
              }
          } failure:^(NSError *error) {
              kMRCError(error.localizedDescription);
              [MBProgressHUD hideAllHUDsForView:Window animated:YES];
          }];
}

#pragma mark -
#pragma mark ================= 网络请求 =================
- (void)requsetgetSetup
{
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:@"" animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.orderID forKey:@"id"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [ZPHTTP wPost:@"http://113.31.29.235:8080/chicheng/app/service/setup/getSetup" parameters:params success:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
        
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            self.model = [LQModelSetup mj_objectWithKeyValues:[[responseObject valueForKey:@"data"] valueForKey:@"setup"]];
            [self.tableView reloadData];
            
            if ([self.model.status integerValue] == 0)
            {
                self.rightBtn.sd_resetLayout
                .rightSpaceToView(self.view,15)
                .bottomSpaceToView(self.view,15)
                .widthIs(0)
                .heightIs(20);
            }
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
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
    }];
}

#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 2;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return 3;
        }
            break;
        case 3:
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
        switch (indexPath.row)
        {
            case 0:
            {
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.textLabel.textColor = [UIColor blackColor];
                cell.textLabel.text = [NSString stringWithFormat:@"订单号："];
                
                if (self.model)
                {
                    cell.textLabel.text = [NSString stringWithFormat:@"订单号：%@",self.model.order.number];
                }
                
                return cell;
                
            }
                break;
            case 1:
            {
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.textLabel.textColor = [UIColor blackColor];
                cell.textLabel.text = @"";
                cell.textLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:@"安装状态：" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
                if (self.model)
                {
                    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"安装状态：" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
                    
                    NSString *stateStr = @"";
                    switch ([self.model.status integerValue]) {
                        case 0:
                        {
                            stateStr = @"未安装";
                        }
                            break;
                        case 1:
                        {
                            stateStr = @"已安装";
                        }
                            break;
                    }
                    
                    
                    [att appendAttributedString:[[NSMutableAttributedString alloc] initWithString:stateStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]}]];
                    cell.textLabel.attributedText = att;
                }
                
                return cell;
            }
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 1)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                LQSetUpCell *cell = [LQSetUpCell cellWithTableView:tableView];
                
                if (self.model)
                {
                    cell.modelDic = [self.model.order.productList firstObject];
                }
                
                return cell;
            }
                
            default:
                break;
        }
    }
    else if (indexPath.section == 2)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                LQOrderClaimsShangMengTimeCell *cell = [LQOrderClaimsShangMengTimeCell cellWithTableView:tableView];
                cell.dateStr = @"";
                cell.hideLine = YES;
                if (self.model)
                {
                    cell.dateStr = self.model.setupDate;
                }
                return cell;
            }
                break;
            case 1:
            {
                LQOrderClaimsAddressCell *cell = [LQOrderClaimsAddressCell cellWithTableView:tableView];
                cell.hideLine = YES;
                return cell;
            }
                break;
            case 2:
            {
                LQOrderClaimsAddressDetailCell *cell = [LQOrderClaimsAddressDetailCell cellWithTableView:tableView];
                
                if (self.model)
                {
                    cell.model = self.model.order.address;
                }
                
                return cell;
            }
                break;
                
            default:
                break;
        }
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.textLabel.font =[UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.text = @"安装师傅";
        
        if (self.model)
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",self.model.name,self.model.mobile];
        }
        
        return cell;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 2)
    {
        if (!self.addressModel)
        {
            return [tableView cellHeightForIndexPath:indexPath model:nil keyPath:nil cellClass:[LQOrderClaimsAddressDetailCell class] contentViewWidth:kScreenWidth];
        }
        else
        {
            return [tableView cellHeightForIndexPath:indexPath model:self.addressModel keyPath:@"model" cellClass:[LQOrderClaimsAddressDetailCell class] contentViewWidth:kScreenWidth];
        }
    }
    
    if (indexPath.section == 1)
    {
        return 80;
    }
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
