//
//  LQVisitingClaimsDetailsVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQVisitingClaimsDetailsVC.h"
#import "MWPhotoBrowser.h"
#import "PhotoCollectionViewCell.h"
#import "LQOrderClaimsShangMengTimeCell.h"
#import "LQOrderClaimsAddressCell.h"
#import "LQOrderClaimsAddressDetailCell.h"
#import "ModelClaim.h"
#import "LQModelPicture.h"

@interface LQVisitingClaimsDetailsVC ()<UITableViewDelegate,UITableViewDataSource,MWPhotoBrowserDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UILabel *problemDescriptionLabel;
@property (nonatomic, weak) UICollectionView *photoCollectionView;

@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@property (strong, nonatomic) UINavigationController *photoNavigationController;

@property (nonatomic, strong) NSMutableArray *photoArray;

@property (nonatomic, strong) ModelClaim *modelClaim;

@end

@implementation LQVisitingClaimsDetailsVC

- (NSMutableArray *)photoArray
{
    if (!_photoArray)
    {
        _photoArray = [NSMutableArray array];
    }
    
    return _photoArray;
}

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
    self.title = @"订单详情";
    
    [self drawView];
    [self requsetgetClaim];
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
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.tableFooterView = [self drawTableFooterView];
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0);
}

- (UIView *)drawTableFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"问题描述";
    label.font = [UIFont systemFontOfSize:15];
    
    UILabel *problemDescriptionLabel = [[UILabel alloc] init];
    problemDescriptionLabel.font = [UIFont systemFontOfSize:14];
    problemDescriptionLabel.textColor = [UIColor lightGrayColor];
    problemDescriptionLabel.text = @"";
    problemDescriptionLabel.isAttributedContent = NO;
    self.problemDescriptionLabel = problemDescriptionLabel;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(PhotoCollectionViewCell_W, PhotoCollectionViewCell_H);
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 15 * 0.5;
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    UICollectionView *photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    [photoCollectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoCollectionViewCell"];
    photoCollectionView.backgroundColor = [UIColor whiteColor];
    photoCollectionView.delaysContentTouches = NO;
    photoCollectionView.dataSource = self;
    photoCollectionView.delegate = self;
    self.photoCollectionView = photoCollectionView;
    // 将子view添加进父view
    [footerView sd_addSubviews:@[label, problemDescriptionLabel,photoCollectionView]];
    
    label.sd_layout
    .topSpaceToView(footerView,10)
    .leftSpaceToView(footerView,10)
    .rightSpaceToView(footerView,10)
    .autoHeightRatio(0);
    
    self.problemDescriptionLabel.sd_layout
    .topSpaceToView(label,3)
    .leftSpaceToView(footerView,10)
    .rightSpaceToView(footerView,10)
    .autoHeightRatio(0);
    
    
    self.photoCollectionView.sd_layout
    .topSpaceToView(problemDescriptionLabel,5)
    .leftSpaceToView(footerView,10)
    .rightSpaceToView(footerView,10)
    .heightIs(100);
    
    
    [footerView setupAutoHeightWithBottomView:self.photoCollectionView bottomMargin:10];
    
    return footerView;
}

#pragma mark -
#pragma mark ================= 网络请求 =================
- (void)requsetgetClaim
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.orderID forKey:@"id"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [ZPHTTP wPost:@"/app/service/claim/getClaim" parameters:params success:^(id responseObject) {
        
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            self.modelClaim = [ModelClaim mj_objectWithKeyValues:[[responseObject valueForKey:@"data"] valueForKey:@"Claim"]];
            [self.tableView reloadData];
            
            self.problemDescriptionLabel.text = self.modelClaim._description;
            self.photoArray = [NSMutableArray arrayWithArray:self.modelClaim.pictureList];
            [self.photoBrowser reloadData];
            [self.photoCollectionView reloadData];
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

#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
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
            return 4;
        }
            break;
        case 2:
        {
            return 3;
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
                
                if (self.modelClaim)
                {
                    cell.textLabel.text = [NSString stringWithFormat:@"订单号：%@",self.modelClaim.number];
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
                cell.textLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:@"理赔状态：" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
                if (self.modelClaim)
                {
                    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"理赔状态：" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
                    
                    NSString *stateStr = @"";
                    switch ([self.modelClaim.status integerValue]) {
                        case 1:
                        {
                            stateStr = @"编辑";
                        }
                            break;
                        case 2:
                        {
                            stateStr = @"待审核";
                        }
                            break;
                        case 3:
                        {
                            stateStr = @"审核通过";
                        }
                            break;
                        case 4:
                        {
                            stateStr = @"审核失败";
                        }
                            break;
                        case 5:
                        {
                            stateStr = @"理赔成功";
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
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.textLabel.textColor = [UIColor blackColor];
                cell.textLabel.text = [NSString stringWithFormat:@"规格："];
                
                if (self.modelClaim)
                {
                    cell.textLabel.text = [NSString stringWithFormat:@"规格：%@",self.modelClaim.standard];
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
                cell.textLabel.text = [NSString stringWithFormat:@"品牌："];
                
                if (self.modelClaim)
                {
                    cell.textLabel.text = [NSString stringWithFormat:@"品牌：%@",self.modelClaim.brand];
                }
                return cell;
            }
                break;
            case 2:
            {
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.textLabel.textColor = [UIColor blackColor];
                cell.textLabel.text = [NSString stringWithFormat:@"花纹："];
                
                if (self.modelClaim)
                {
                    cell.textLabel.text = [NSString stringWithFormat:@"花纹：%@",self.modelClaim.pattern];
                }
                return cell;
            }
                break;
            case 3:
            {
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.textLabel.textColor = [UIColor blackColor];
                cell.textLabel.text = [NSString stringWithFormat:@"胎号："];
                
                if (self.modelClaim)
                {
                    cell.textLabel.text = [NSString stringWithFormat:@"胎号：%@",self.modelClaim.tireNumber];
                }
                return cell;
            }
                break;
                
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
                
                if (self.modelClaim)
                {
                    cell.model = self.modelClaim.address;
                }
                
                return cell;
            }
                break;
                
            default:
                break;
        }
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 2)
    {
        if (!self.modelClaim)
        {
            return [tableView cellHeightForIndexPath:indexPath model:nil keyPath:nil cellClass:[LQOrderClaimsAddressDetailCell class] contentViewWidth:kScreenWidth];
        }
        else
        {
            return [tableView cellHeightForIndexPath:indexPath model:self.modelClaim.address keyPath:@"model" cellClass:[LQOrderClaimsAddressDetailCell class] contentViewWidth:kScreenWidth];
        }
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


#pragma mark -
#pragma mark ================= CollectionViewDelegate,UICollectionViewDataSource =================
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LQModelPicture *modelPicture = self.photoArray[indexPath.row];
    
    static NSString * CellIdentifier = @"PhotoCollectionViewCell";
    PhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:modelPicture.appPath] placeholderImage:[UIImage imageNamed:@"ic_service_logo"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.photoBrowser setCurrentPhotoIndex:indexPath.row];
    [self presentViewController:self.photoNavigationController animated:YES completion:nil];
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
