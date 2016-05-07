//
//  ServiceMapVC.m
//  YouChengTire
//
//  Created by Baby on 16/2/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "ServiceMapVC.h"
#import "MyAnnotation.h"
#import "MyAnnotationView.h"
#import "AppDelegate.h"
#import "ServiceVM.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

@interface ServiceMapVC ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
@property (nonatomic, strong) ServiceVM * serviceVM;
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) BMKPointAnnotation *myAnnotation;
@property (strong, nonatomic) NSMutableArray * annotationArrays;
@end

@implementation ServiceMapVC

- (NSMutableArray *)annotationArrays
{
    if (!_annotationArrays) {
        _annotationArrays = [NSMutableArray array];
    }
    
    return  _annotationArrays;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.serviceVM = [[ServiceVM alloc] init];
    [self drawView];
    [self startLocation];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    self.locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
    self.locService.delegate = nil;
}

- (void)drawView
{
    self.mapView.zoomLevel = 14;
    
    //初始化BMKLocationService
    self.locService = [[BMKLocationService alloc]init];
    self.locService.delegate = self;
}

/**
 *  废弃
 */
- (void)requestServiceWithParams:(NSDictionary *)_params coor:(CLLocationCoordinate2D)_loc
{
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [self.serviceVM requestGetPointList:^(id object) {
        @strongify(self)
        NearbyPointM *nearbyPointM = object;
        [self addPointAnnotationWithAnnotationArr:nearbyPointM.pointList];
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    } data:_params error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (void)requsetServiceWithParams:(NSDictionary *)params
{
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:nil animated:YES];
    [ZPHTTP wPost:@"/app/prd/point/getPointList" parameters:params success:^(id responseObject) {
        
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess]) {
            NearbyPointM *nearbyPointM = [NearbyPointM yy_modelWithDictionary:responseObject[@"data"]];
            [self addPointAnnotationWithAnnotationArr:nearbyPointM.pointList];
        }
        else {
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
    }];
}

- (void)addPointAnnotationWithAnnotationArr:(NSArray *)arr
{
    for (NearbyPointItemM * nPI in arr)
    {
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = [nPI.p_lat floatValue];
        coor.longitude = [nPI.p_lng floatValue];
        annotation.coordinate = coor;
        [self.mapView addAnnotation:annotation];
    }
}

- (void)startLocation
{
    //启动LocationService
    [self.locService startUserLocationService];
    self.mapView.showsUserLocation = NO;//先关闭显示的定位图层
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    self.mapView.showsUserLocation = YES;//显示定位图层
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
    
    if (annotation == self.myAnnotation)
    {
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
    
    NSString *AnnotationViewID = @"otherAnnotation";
    BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        // 设置颜色
        annotationView.pinColor = BMKPinAnnotationColorRed;
        annotationView.draggable = YES;
    }
    return annotationView;
}

#pragma mark -
#pragma mark ================= BMKLocationServiceDelegate =================
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //    [self.mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    self.myAnnotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = userLocation.location.coordinate.latitude;
    coor.longitude = userLocation.location.coordinate.longitude;
    self.myAnnotation.coordinate = coor;
    [self.mapView addAnnotation:self.myAnnotation];
    [self.mapView showAnnotations:@[self.myAnnotation] animated:YES];
    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    [self.locService stopUserLocationService];
    
    
    [self requsetServiceWithParams:@{@"lng":[NSString stringWithFormat:@"%f",coor.longitude],
                                     @"lat":[NSString stringWithFormat:@"%f",coor.latitude],
                                     @"type":@"1",
                                     @"province":[AppDelegate appDelegete].locState,
                                     @"city":[AppDelegate appDelegete].locCity,
                                     @"county":[AppDelegate appDelegete].locSubLocality}];
}

@end
