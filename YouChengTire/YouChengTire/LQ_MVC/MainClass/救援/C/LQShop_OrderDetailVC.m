//
//  LQShop_OrderDetailVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQShop_OrderDetailVC.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "MWPhotoBrowser.h"
#import "PhotoCollectionViewCell.h"
#import "LQModelRescueDetail.h"
#import "LQModelRescue.h"
#import "LQModelPicture.h"
#import "LQShop_RobOrderDetailCell.h"
#import "MyRescueVC.h"

@interface LQShop_OrderDetailVC ()<UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate,MWPhotoBrowserDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

/**
 *  地图
 */
@property (nonatomic, strong) BMKMapView* mapView;
@property (nonatomic, strong) BMKPointAnnotation *myAnnotation;
@property (nonatomic, weak) UITableView *tableView;
@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@property (strong, nonatomic) UINavigationController *photoNavigationController;
@property (nonatomic, strong) NSMutableArray *photoArray;
@property (nonatomic, weak) UICollectionView *photoCollectionView;
@property (nonatomic, weak) UILabel *problemDescriptionLabel;
@property (nonatomic, strong) LQModelRescueDetail *modelRescueDetail;
@property (nonatomic, weak) UIButton *robOrderBtn;
@property (nonatomic, weak) UITextField *xieshangTextField;
@property (nonatomic, weak) UIView *xieShangPriceBgv;

@end

@implementation LQShop_OrderDetailVC



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
    
    self.navigationItem.title = @"救援订单";
    
    [self drawView];
    [self request];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
}

- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    mapView.zoomLevel = 18;
    [self.view addSubview:mapView];
    self.mapView = mapView;
    tableView.tableHeaderView = mapView;
    tableView.tableFooterView = [self drawTableFooterView];
    
    UIView *xieShangPriceBgv = [[UIView alloc] init];
    xieShangPriceBgv.backgroundColor = RGB(102, 102, 102);
    xieShangPriceBgv.hidden = YES;
    [self.view addSubview:xieShangPriceBgv];
    self.xieShangPriceBgv = xieShangPriceBgv;
    
    UIButton *queRenBtn = [[UIButton alloc] init];
    [queRenBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [queRenBtn setTitle:@"确认支付" forState:UIControlStateHighlighted];
    [queRenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [queRenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    queRenBtn.backgroundColor = [UIColor redColor];
    [queRenBtn addTarget:self action:@selector(queRenZhifu) forControlEvents:UIControlEventTouchUpInside];
    [xieShangPriceBgv addSubview:queRenBtn];
    
//    UILabel *xieshangPriceLabel = [[UILabel alloc] init];
//    xieshangPriceLabel.font = [UIFont systemFontOfSize:15];
//    xieshangPriceLabel.textColor = [UIColor whiteColor];
//    xieshangPriceLabel.text = @"协商价格:";
//    [xieShangPriceBgv addSubview:xieshangPriceLabel];
//    
//    UITextField *xieshangTextField = [[UITextField alloc] init];
//    xieshangTextField.backgroundColor = [UIColor whiteColor];
//    xieshangTextField.font = [UIFont systemFontOfSize:15];
//    xieshangTextField.layer.cornerRadius = 5;
//    xieshangTextField.keyboardType = UIKeyboardTypeNumberPad;
//    xieshangTextField.layer.masksToBounds = YES;
//    [xieShangPriceBgv addSubview:xieshangTextField];
//    xieshangTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
//    xieshangTextField.leftViewMode = UITextFieldViewModeAlways;
//    self.xieshangTextField = xieshangTextField;
//    
//    UIButton *commitBtn = [[UIButton alloc] init];
//    [commitBtn setTitle:@"提交价格" forState:UIControlStateNormal];
//    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    commitBtn.backgroundColor = RGB(195, 51, 54);
//    commitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [commitBtn addTarget:self action:@selector(didClickCommitBtn) forControlEvents:UIControlEventTouchUpInside];
//    [xieShangPriceBgv addSubview:commitBtn];
    
    [tableView sd_clearViewFrameCache];
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0);
    
    xieShangPriceBgv.sd_layout
    .leftSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(35);
    
    queRenBtn.sd_layout
    .leftSpaceToView(xieShangPriceBgv,0)
    .bottomSpaceToView(xieShangPriceBgv,0)
    .rightSpaceToView(xieShangPriceBgv,0)
    .topSpaceToView(xieShangPriceBgv,0);
    
//    xieshangPriceLabel.sd_layout
//    .leftSpaceToView(xieShangPriceBgv,10)
//    .bottomSpaceToView(xieShangPriceBgv,0)
//    .widthIs(80)
//    .topSpaceToView(xieShangPriceBgv,5);
//    
//    xieshangTextField.sd_layout
//    .leftSpaceToView(xieshangPriceLabel,0)
//    .bottomSpaceToView(xieShangPriceBgv,5)
//    .widthIs(100)
//    .topSpaceToView(xieShangPriceBgv,5);
//    
//    commitBtn.sd_layout
//    .topSpaceToView(xieShangPriceBgv,0)
//    .bottomSpaceToView(xieShangPriceBgv,0)
//    .rightSpaceToView(xieShangPriceBgv,0)
//    .widthIs(100);
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

- (void)didClickCommitBtn
{
    [self.view endEditing:YES];
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:@"" animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.rescueID forKey:@"id"];
    [params setValue:self.xieshangTextField.text forKey:@"price"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [[ZPHTTPSessionManager sharedManager] wPost:@"/app/rescue/rescue/updateRescuePrice" parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:Window animated:YES];
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            [self request];
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
        [MBProgressHUD hideHUDForView:Window animated:YES];
    }];
}

- (void)addPointAnnotation
{
    // 添加一个PointAnnotation
    self.myAnnotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = [self.modelRescueDetail.rescue.lat floatValue];
    coor.longitude = [self.modelRescueDetail.rescue.lng floatValue];
    self.myAnnotation.coordinate = coor;
    [self.mapView addAnnotation:self.myAnnotation];
    [self.mapView showAnnotations:@[self.myAnnotation] animated:YES];
}

- (void)queRenZhifu
{
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:@"" animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.rescueID forKey:@"id"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [[ZPHTTPSessionManager sharedManager] wPost:@"/app/rescue/rescue/ensureCashPayment" parameters:params success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:Window animated:YES];
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            [self request];
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
        [MBProgressHUD hideHUDForView:Window animated:YES];
    }];
}

#pragma mark -
#pragma mark ================= 网络请求 =================
- (void)request
{
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:@"" animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.rescueID forKey:@"id"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [[ZPHTTPSessionManager sharedManager] wPost:@"/app/rescue/rescue/getRescue" parameters:params success:^(id responseObject) {
        
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            self.modelRescueDetail = [LQModelRescueDetail mj_objectWithKeyValues:[responseObject valueForKey:@"data"]];
            self.problemDescriptionLabel.text = self.modelRescueDetail.rescue._description;
            [self.tableView reloadData];
            [self addPointAnnotation];
            self.photoArray = [NSMutableArray arrayWithArray:self.modelRescueDetail.pictureList];
            [self.photoCollectionView reloadData];
            [self.photoBrowser reloadData];
            
            if ([self.modelRescueDetail.rescue.paymentStatus intValue] == 2 && [self.modelRescueDetail.rescue.status intValue] == 3)
            {
                self.xieShangPriceBgv.hidden = NO;
            }else {
                self.xieShangPriceBgv.hidden = YES;
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
        [MBProgressHUD hideHUDForView:Window animated:YES];
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
        [MBProgressHUD hideHUDForView:Window animated:YES];
    }];
}


#pragma mark -
#pragma mark ================= BMKMapViewDelegate =================
/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //    if (annotation == self.myAnnotation)
    //    {
    //        //动画annotation
    //        NSString *AnnotationViewID = @"myAnnotation";
    //        MyAnimatedAnnotationView *annotationView = nil;
    //        if (annotationView == nil) {
    //            annotationView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    //        }
    //        NSMutableArray *images = [NSMutableArray array];
    //        [images addObject:[UIImage imageNamed:@"ic_救援location_green"]];
    //        annotationView.annotationImages = images;
    //        return annotationView;
    //    }
    //
    //    // 生成重用标示identifier
    //    NSString *AnnotationViewID = @"otherAnnotation";
    //    MyAnimatedAnnotationView *annotationView = nil;
    //    if (annotationView == nil) {
    //        annotationView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    //    }
    //    NSMutableArray *images = [NSMutableArray array];
    //    [images addObject:[UIImage imageNamed:@"ic_救援location_red"]];
    //    annotationView.annotationImages = images;
    //    return annotationView;
    
    NSString *AnnotationViewID = @"myAnnotation";
    BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        // 设置颜色
        annotationView.pinColor = BMKPinAnnotationColorGreen;
        // 从天上掉下效果
        annotationView.animatesDrop = YES;
        // 设置可拖拽
        annotationView.draggable = YES;
    }
    return annotationView;
}

#pragma mark -
#pragma mark ================= UITableViewDelegate,UITableViewDataSource =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.modelRescueDetail)
    {
        return 1;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQShop_RobOrderDetailCell *cell = [LQShop_RobOrderDetailCell cellWithTableView:tableView];
    cell.modelRescueDetail = self.modelRescueDetail;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.modelRescueDetail)
    {
        return [tableView cellHeightForIndexPath:indexPath model:self.modelRescueDetail keyPath:@"modelRescueDetail" cellClass:[LQShop_RobOrderDetailCell class] contentViewWidth:kScreenWidth];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = self.tableView.backgroundColor;
    [headerView addSubview:lineView];
    
    UILabel *orderNumLabel = [[UILabel alloc] init];
    //    orderNumLabel.backgroundColor = [UIColor redColor];
    orderNumLabel.text = [NSString stringWithFormat:@"订单号："];
    orderNumLabel.textColor = [UIColor lightGrayColor];
    orderNumLabel.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:orderNumLabel];
    
    UILabel *orderStateLabel = [[UILabel alloc] init];
    //    orderStateLabel.backgroundColor = [UIColor blueColor];
    //    orderStateLabel.text = @"等待救援";
    orderStateLabel.font = [UIFont systemFontOfSize:12];
    orderStateLabel.textColor = [UIColor redColor];
    [headerView addSubview:orderStateLabel];
    
    lineView.sd_layout
    .topSpaceToView(headerView,0)
    .rightSpaceToView(headerView,0)
    .leftSpaceToView(headerView,0)
    .heightIs(10);
    
    orderStateLabel.sd_layout
    .topSpaceToView(lineView,0)
    .rightSpaceToView(headerView,10)
    .bottomSpaceToView(headerView,0)
    .widthIs(50);
    
    orderNumLabel.sd_layout
    .topSpaceToView(lineView,0)
    .leftSpaceToView(headerView,10)
    .bottomSpaceToView(headerView,0)
    .rightSpaceToView(orderStateLabel,10);
    
    
    if (self.modelRescueDetail)
    {
        orderNumLabel.text = [NSString stringWithFormat:@"订单号：%@",self.modelRescueDetail.rescue.number];
        
        NSArray *stateArray = @[@"编辑",@"发布救援",@"等待救援",@"救援成功",@"救援失败"];
        orderStateLabel.text = stateArray[[self.modelRescueDetail.rescue.status intValue] - 1];
        
    }
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *price = [[UILabel alloc] init];
    //    price.backgroundColor = [UIColor redColor];
    price.text = @"救援金额：";
    price.font = [UIFont systemFontOfSize:12];
    [footerView addSubview:price];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    //    priceLabel.text = @"￥0.02";
    priceLabel.textColor = [UIColor redColor];
    priceLabel.font = [UIFont systemFontOfSize:12];
    [footerView addSubview:priceLabel];
    
    UILabel *payStateLabel = [[UILabel alloc] init];
    //    payStateLabel.text = @"未支付";
    payStateLabel.textColor = [UIColor lightGrayColor];
    payStateLabel.font = [UIFont systemFontOfSize:12];
    [footerView addSubview:payStateLabel];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = self.tableView.backgroundColor;
    [footerView addSubview:lineView];
    
    price.sd_layout
    .topSpaceToView(footerView,0)
    .leftSpaceToView(footerView,10)
    .bottomSpaceToView(footerView,0)
    .widthIs(60);
    
    priceLabel.sd_layout
    .topSpaceToView(footerView,0)
    .leftSpaceToView(price,5)
    .bottomSpaceToView(footerView,0)
    .widthIs(150);
    
    payStateLabel.sd_layout
    .topSpaceToView(footerView,0)
    .bottomSpaceToView(footerView,0)
    .rightSpaceToView(footerView,10)
    .widthIs(40);
    
    lineView.sd_layout
    .topSpaceToView(payStateLabel,0)
    .rightSpaceToView(footerView,0)
    .leftSpaceToView(footerView,0)
    .heightIs(10);
    
    if (self.modelRescueDetail)
    {
        priceLabel.text = [NSString stringWithFormat:@"￥%@",self.modelRescueDetail.rescue.price];
        
        NSArray *patStateArray = @[@"未支付",@"已支付",@"待确认"];
        payStateLabel.text = patStateArray[[self.modelRescueDetail.rescue.paymentStatus intValue]];
        
    }
    
    return footerView;
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
