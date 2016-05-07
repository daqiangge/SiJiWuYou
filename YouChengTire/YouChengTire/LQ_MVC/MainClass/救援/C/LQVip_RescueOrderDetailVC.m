//
//  LQVip_RescueOrderDetailVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/23.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQVip_RescueOrderDetailVC.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import "MWPhotoBrowser.h"
#import "PhotoCollectionViewCell.h"
#import "LQVip_RescueOrderDetailCell.h"
#import "LQModelRescueDetail.h"
#import "LQModelRescue.h"
#import "LQModelPicture.h"
// Vendors
#import <AlipaySDK/AlipaySDK.h>

@interface LQVip_RescueOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate,BMKLocationServiceDelegate,MWPhotoBrowserDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

/**
 *  地图
 */
@property (nonatomic, strong) BMKMapView* mapView;
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) BMKPointAnnotation *myAnnotation;

@property (nonatomic, weak) UILabel *problemDescriptionLabel;
@property (nonatomic, weak) UICollectionView *photoCollectionView;

@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@property (strong, nonatomic) UINavigationController *photoNavigationController;

@property (nonatomic, strong) NSMutableArray *photoArray;
@property (nonatomic, copy) NSString *problemDescription;

@property (nonatomic, strong) LQModelRescueDetail *modelRescueDetail;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIButton *xianJingPayBtn;
@property (nonatomic, weak) UIButton *zaiXianPayBtn;

@end

@implementation LQVip_RescueOrderDetailVC

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    UIButton *xianJingPayBtn = [[UIButton alloc] init];
    xianJingPayBtn.backgroundColor = [UIColor blackColor];
    [xianJingPayBtn setTitle:@"现金支付" forState:UIControlStateNormal];
    [xianJingPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    xianJingPayBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [xianJingPayBtn addTarget:self action:@selector(didClickXianJinPayBtn) forControlEvents:UIControlEventTouchUpInside];
    xianJingPayBtn.hidden = YES;
    [self.view addSubview:xianJingPayBtn];
    self.xianJingPayBtn = xianJingPayBtn;
    
    UIButton *zaiXianPayBtn = [[UIButton alloc] init];
    zaiXianPayBtn.backgroundColor = [UIColor redColor];
    [zaiXianPayBtn setTitle:@"在线支付" forState:UIControlStateNormal];
    [zaiXianPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zaiXianPayBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [zaiXianPayBtn addTarget:self action:@selector(didClickZaiXianPayBtn) forControlEvents:UIControlEventTouchUpInside];
    zaiXianPayBtn.hidden = YES;
    [self.view addSubview:zaiXianPayBtn];
    self.zaiXianPayBtn = zaiXianPayBtn;
    
    [tableView sd_clearViewFrameCache];
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0);
    
    xianJingPayBtn.sd_layout
    .leftSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .widthRatioToView(self.view,0.5)
    .heightIs(40);
    
    zaiXianPayBtn.sd_layout
    .leftSpaceToView(xianJingPayBtn,0)
    .bottomSpaceToView(self.view,0)
    .widthRatioToView(self.view,0.5)
    .heightIs(40);
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
    problemDescriptionLabel.text = self.problemDescription;
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

- (void)didClickXianJinPayBtn
{
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:@"" animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.rescueID forKey:@"id"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [[ZPHTTPSessionManager sharedManager] wPost:@"/app/rescue/rescue/cashPayment" parameters:params success:^(id responseObject) {
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
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
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
    }];
}

- (void)didClickZaiXianPayBtn
{
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:@"" animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.rescueID forKey:@"id"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [[ZPHTTPSessionManager sharedManager] wPost:@"/app/shop/payment/getRescueInfo" parameters:params success:^(id responseObject) {
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            NSString *sign = [self urlEncodedString:[[[responseObject valueForKey:@"data"] valueForKey:@"rescue"] valueForKey:@"sign"]];
            NSString *orderInfo = [[[responseObject valueForKey:@"data"] valueForKey:@"rescue"] valueForKey:@"orderInfo"];
            
            NSString *orderString = nil;
            if (sign != nil)
            {
                orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"", orderInfo, sign, @"RSA"];
                [[AlipaySDK defaultService]
                 payOrder:orderString
                 fromScheme:kAppScheme
                 callback:^(NSDictionary *resultDic) {
                     NSLog(@"reslut = %@",resultDic);
                     if ([resultDic[@"resultStatus"] isEqualToString:@"9000"])
                     {
                         [self.navigationController popViewControllerAnimated:YES];
                     }
                     else
                     {
                         kMRCError(@"抱歉，您的订单支付失败");
                     }
                 }];
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
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
    }];
}

- (NSString*)urlEncodedString:(NSString *)string
{
    NSString * encodedString = (__bridge_transfer  NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
    
    return encodedString;
}

#pragma mark -
#pragma mark ================= 网络请求 =================
- (void)request
{
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
            
            if (![self.modelRescueDetail.rescue.paymentStatus intValue])
            {
                self.xianJingPayBtn.hidden = NO;
                self.zaiXianPayBtn.hidden = NO;
            }
            else
            {
                self.xianJingPayBtn.hidden = YES;
                self.zaiXianPayBtn.hidden = YES;
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
    LQVip_RescueOrderDetailCell *cell = [LQVip_RescueOrderDetailCell cellWithTableView:tableView];
    cell.modelRescueDetail = self.modelRescueDetail;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.modelRescueDetail)
    {
        return [tableView cellHeightForIndexPath:indexPath model:self.modelRescueDetail keyPath:@"modelRescueDetail" cellClass:[LQVip_RescueOrderDetailCell class] contentViewWidth:kScreenWidth];
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
