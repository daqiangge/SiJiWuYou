//
//  LQRescueBySelfMapVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/21.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQRescueBySelfMapVC.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import "LQModelPoint.h"
#import "LQModelPointList.h"
#import "LQModelRole.h"
#import "MyAnimatedAnnotationView.h"
#import "RescueBySelfListVC.h"

@interface LQRescueBySelfMapVC ()<BMKMapViewDelegate,BMKLocationServiceDelegate>

/**
 *  地图
 */
@property (nonatomic, strong) BMKMapView* mapView;

@property (nonatomic, strong) BMKLocationService *locService;

@property (nonatomic, strong) BMKPointAnnotation *myAnnotation;

@property (nonatomic, strong) NSMutableArray *pontListArray;



@end

@implementation LQRescueBySelfMapVC

- (NSMutableArray *)pontListArray
{
    if (!_pontListArray)
    {
        _pontListArray = [NSMutableArray array];
    }
    
    return _pontListArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    self.navigationItem.title = @"救援";
    
    [self drawSubviews];
    [self requestNearbyPointList];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_service_list"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoNearbyPointListVC)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawSubviews
{
    BMKMapView* mapView = [[BMKMapView alloc]init];
    mapView.zoomLevel = 14;
    [self.view addSubview:mapView];
    self.mapView = mapView;
    
    //初始化BMKLocationService
    self.locService = [[BMKLocationService alloc]init];
    
    [self drawSubViewFrame];
    
}

- (void)drawSubViewFrame
{
    self.mapView.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
}

- (void)addPointAnnotation
{
    // 添加一个PointAnnotation
    self.myAnnotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = [self.lat floatValue];
    coor.longitude = [self.lng floatValue];
    self.myAnnotation.coordinate = coor;
    [self.mapView addAnnotation:self.myAnnotation];
    [self.mapView showAnnotations:@[self.myAnnotation] animated:YES];
    
    for (LQModelPointList *modelPointList in self.pontListArray)
    {
        LQModelPoint *modelPoint = modelPointList.point;
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = [modelPoint.lat floatValue];
        coor.longitude = [modelPoint.lng floatValue];
        annotation.coordinate = coor;
        [self.mapView addAnnotation:annotation];
    }
}

- (void)gotoNearbyPointListVC
{
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = returnButtonItem;
    
    //将我们的storyBoard实例化，“Main”为StoryBoard的名称
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Rescue" bundle:nil];
    
    //将第二个控制器实例化，"SecondViewController"为我们设置的控制器的ID
    RescueBySelfListVC *rescueBySelfListVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"RescueBySelfListVC"];
    rescueBySelfListVC.lat = self.lat;
    rescueBySelfListVC.lng = self.lng;
    rescueBySelfListVC.rescueId = self.rescueId;
    //跳转事件
    [self.navigationController pushViewController:rescueBySelfListVC animated:YES];
//    RescueBySelfDetailsVC *vc = [[RescueBySelfDetailsVC alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark ================= 网络请求 =================
- (void)requestNearbyPointList
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.lng forKey:@"lng"];
    [params setValue:self.lat forKey:@"lat"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    
    [[ZPHTTPSessionManager sharedManager] wPost:@"/app/rescue/rescue/getNearbyPointList"
                                     parameters:params
                                        success:^(id responseObject) {
                                            
                                            if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess]) {
                                                NSDictionary *data = responseObject[@"data"];
                                                self.pontListArray = [LQModelPointList mj_objectArrayWithKeyValuesArray:data[@"pointList"]];
                                                
                                                NSLog(@"---->%@",self.pontListArray);
                                                [self addPointAnnotation];
                                            }
                                            else {
                                                NSInteger errnoInteger = [responseObject[@"msgCode"] integerValue];
                                                NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : responseObject[@"msg"] };
                                                NSError *uError = [NSError errorWithDomain:@"ZPCustom"
                                                                                      code:errnoInteger
                                                                                  userInfo:userInfo];
                                                kMRCError(uError.localizedDescription);
                                            }
                                        }
                                        failure:^(NSError *error) {
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

@end
