//
//  LQInsuranceDetailVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQInsuranceDetailVC.h"
#import "LQInsuranceDetailCell.h"
#import "LQModelinsuranceList.h"
#import "LQInsuranceDetailCell2.h"
#import "LQModelPicture.h"
#import "MWPhotoBrowser.h"

@interface LQInsuranceDetailVC ()<UITableViewDelegate,UITableViewDataSource,MWPhotoBrowserDelegate>

@property (nonatomic, strong)  LQModelinsuranceList *model;
@property (nonatomic, strong) NSMutableArray *photoArray;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIButton *deleteBtn;
@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@property (strong, nonatomic) UINavigationController *photoNavigationController;

@end

@implementation LQInsuranceDetailVC


- (MWPhotoBrowser *)photoBrowser
{
    if (_photoBrowser == nil) {
        _photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        //        _photoBrowser.showLongPress = YES;
        _photoBrowser.displayActionButton = NO;
        _photoBrowser.displayNavArrows = YES;
        _photoBrowser.displaySelectionButtons = NO;
        _photoBrowser.alwaysShowControls = NO;
        _photoBrowser.wantsFullScreenLayout = YES;
        _photoBrowser.zoomPhotosToFill = YES;
        _photoBrowser.enableGrid = NO;
        _photoBrowser.startOnGrid = NO;
        //        _photoBrowser.navigationBarHide = NO;
        //        [_photoBrowser setCurrentPhotoIndex:0];
    }
    
    return _photoBrowser;
}

- (UINavigationController *)photoNavigationController
{
    if (_photoNavigationController == nil) {
        _photoNavigationController = [[UINavigationController alloc] initWithRootViewController:self.photoBrowser];
        _photoNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    
    [self.photoBrowser reloadData];
    return _photoNavigationController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"保险详情";
    self.view.backgroundColor = COLOR_LightGray;
    [self drawView];
    [self request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 50) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    //    tableView.tableFooterView = [self drawFooterView];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight - 64 - 40, kScreenWidth, 40)];
    [deleteBtn setTitle:@"删除订单" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deleteBtn.backgroundColor = [UIColor redColor];
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [deleteBtn addTarget:self action:@selector(deleteOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
    self.deleteBtn = deleteBtn;
}

- (void)deleteOrder
{
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:@"" animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self._id forKey:@"id"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [ZPHTTP wPost:@"/app/prd/insurance/deleteInsurance" parameters:params success:^(id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            kMRCSuccess(@"删除成功");
            
            if (self.deleteOrderSuccess) {
                self.deleteOrderSuccess();
            }
            
            [self.navigationController popViewControllerAnimated:YES];
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
#pragma mark ================= 网络请求 =================
- (void)request
{
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:@"" animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self._id forKey:@"id"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [ZPHTTP wPost:@"/app/prd/insurance/getInsurance" parameters:params success:^(id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            self.model = [LQModelinsuranceList mj_objectWithKeyValues:[[responseObject valueForKey:@"data"] valueForKey:@"insurance"]];
            self.photoArray = [NSMutableArray arrayWithArray:[LQModelPicture mj_objectArrayWithKeyValuesArray:[[responseObject valueForKey:@"data"] valueForKey:@"pictureList"]]];
            [self.tableView reloadData];
            
            self.deleteBtn.hidden = [self.model.status intValue] == 2?YES:NO;
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 2;
        }
            break;
        case 1:
        {
            return 5;
        }
            break;
        case 2:
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
    if (indexPath.section == 2) {
        LQInsuranceDetailCell2 *cell = [LQInsuranceDetailCell2 cellWithTableView:tableView];
        
        if (self.photoArray.count == 2)
        {
            LQModelPicture *picture1 = self.photoArray[0];
            LQModelPicture *picture2 = self.photoArray[1];
            [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:picture1.appPath] placeholderImage:[UIImage imageNamed:@"me_discount_logo"]];
            [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:picture2.appPath] placeholderImage:[UIImage imageNamed:@"me_discount_logo"]];
            
            __weak typeof(self) weakSelf = self;
            cell.didTapImageView1 = ^(UIImageView *imageView){
                
                [weakSelf.photoBrowser setCurrentPhotoIndex:indexPath.row];
                [weakSelf presentViewController:weakSelf.photoNavigationController animated:YES completion:nil];
            };
            
            cell.didTapImageView2 = ^(UIImageView *imageView){
                
                [weakSelf.photoBrowser setCurrentPhotoIndex:indexPath.row];
                [weakSelf presentViewController:self.photoNavigationController animated:YES completion:nil];
            };
        }
        
        return cell;
    }
    
    LQInsuranceDetailCell *cell = [LQInsuranceDetailCell cellWithTableView:tableView];
    
    if (self.model) {
        switch (indexPath.section) {
            case 0:
            {
                if (indexPath.row == 0) {
                    cell.namelabel.text = @"险种";
                    cell.contentLabel.text = self.model.monoline;
                }else{
                    cell.namelabel.text = @"保单号";
                    cell.contentLabel.text = self.model.number;
                }
            }
                break;
            case 1:
            {
                switch (indexPath.row)
                {
                    case 0:
                    {
                        cell.namelabel.text = @"车牌号码";
                        cell.contentLabel.text = self.model.plateNumber;
                    }
                        break;
                    case 1:
                    {
                        cell.namelabel.text = @"车架号";
                        cell.contentLabel.text = @"";
                    }
                        break;
                    case 2:
                    {
                        cell.namelabel.text = @"被保险人";
                        cell.contentLabel.text = self.model.insurer;
                    }
                        break;
                    case 3:
                    {
                        cell.namelabel.text = @"车主";
                        cell.contentLabel.text = self.model.owner;
                    }
                        break;
                    case 4:
                    {
                        cell.namelabel.text = @"保险期限";
                        cell.contentLabel.text = [NSString stringWithFormat:@"%@-%@",self.model.startDate,self.model.endDate];
                        if (cell.contentLabel.text.length == 1)
                        {
                            cell.contentLabel.text = @"";
                        }
                    }
                        break;
                        
                    default:
                        break;
                }
            }
                break;
                
            default:
                break;
        }
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
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

#pragma mark -
#pragma mark ================= MWPhotoBrowserDelegate =================
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return self.photoArray.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < self.photoArray.count)
    {
        LQModelPicture *modelPicture = self.photoArray[index];
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:modelPicture.appPath]];
        return photo;
    }
    
    return nil;
}


@end
