//
//  PublishRescueVC.m
//  YouChengTire
//
//  Created by duwen on 16/4/4.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "PublishRescueVC.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "LQModelPointList.h"
#import "LQModelPoint.h"
#import "LQModelRescueDetail.h"
#import "LQModelRescue.h"
#import "MyRescueVC.h"

@interface PublishRescueVC ()<BMKMapViewDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (nonatomic, strong) BMKPointAnnotation *myAnnotation;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) NSMutableArray *pontListArray;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIButton *banJinBtn;
@property (weak, nonatomic) IBOutlet UIButton *pushBtn;

@end

@implementation PublishRescueVC

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
    self.title = @"救援";
    [self drawView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_service_list"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoNearbyPointListVC)];
//    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
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
    self.pushBtn.selected = YES;//用于传递取消发布
    self.mapView.zoomLevel = 14;
    [self requestPointListByDistanceWithDistance:@"30"];
    
    self.banJinBtn.layer.cornerRadius = 2;
    self.banJinBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.banJinBtn.layer.borderWidth = 1;
}

- (IBAction)didClickBanJinBtn:(UIButton *)sender
{
    
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"30km", @"20km", @"10km",nil];
    [choiceSheet showInView:self.view];
}


- (IBAction)cancelBtnClicked:(id)sender
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.rescueID forKey:@"id"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    
    [ZPHTTP wPost:@"/app/rescue/rescue/cancelPublishRescue" parameters:params success:^(id responseObject) {
        
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            if (self.pushBtn.selected)
            {
                self.pushBtn.selected = NO;
            }else{
                [self.navigationController popViewControllerAnimated:YES];
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

// 立即发布
- (IBAction)publishBtnClicked:(id)sender
{
    if ([self.pushBtn.titleLabel.text isEqualToString:@"取消发布"])
    {
        [self.pushBtn setTitle:@"立即发布" forState:UIControlStateNormal];
        [self cancelBtnClicked:nil];
        
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.rescueID forKey:@"id"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];

    
    [ZPHTTP wPost:@"/app/rescue/rescue/publishRescue" parameters:params success:^(id responseObject) {
        
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            [self.pushBtn setTitle:@"取消发布" forState:UIControlStateNormal];
            [self timeOut];
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

- (void)timeOut
{
    __weak typeof(self) weakSelf = self;
    __block int timeout=180; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if (timeout%10 == 0 && timeout != 180)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf requestGetRescue];
            });
        }
        
        if(timeout<=0)
        { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIAlertView showAlertViewWithTitle:@"暂无商家接单,请返回重新发布" message:nil cancelButtonTitle:@"确定" otherButtonTitles:@[] onDismiss:^(int buttonIndex) {
                } onCancel:^{
                    [weakSelf cancelBtnClicked:nil];
                }];
            });
        }else
        {
            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d分%.2d秒",minutes, seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                weakSelf.timeLabel.text = strTime;
                
                if (!weakSelf.pushBtn.selected)
                {
                    dispatch_source_cancel(_timer);
                    self.pushBtn.selected = YES;
                }
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
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

- (void)removewPointAnnotation
{
    for (LQModelPointList *modelPointList in self.pontListArray)
    {
        LQModelPoint *modelPoint = modelPointList.point;
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = [modelPoint.lat floatValue];
        coor.longitude = [modelPoint.lng floatValue];
        annotation.coordinate = coor;
        [self.mapView removeAnnotation:annotation];
    }
}

#pragma mark -
#pragma mark ================= 网络请求 =================
- (void)requestPointListByDistanceWithDistance:(NSString *)distance
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.lng forKey:@"lng"];
    [params setValue:self.lat forKey:@"lat"];
    [params setValue:[distance stringByAppendingString:@"000"] forKey:@"distance"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    
    [ZPHTTP wPost:@"/app/rescue/rescue/getPointListByDistance" parameters:params success:^(id responseObject) {
        
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            NSDictionary *data = responseObject[@"data"];
            self.pontListArray = [LQModelPointList mj_objectArrayWithKeyValuesArray:data[@"pointList"]];
            
            NSLog(@"---->%@",self.pontListArray);
            [self removewPointAnnotation];
            [self addPointAnnotation];
            self.numLabel.text = [NSString stringWithFormat:@"附近救援网点数量:%ld个",self.pontListArray.count];
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

- (void)requestGetRescue
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.rescueID forKey:@"id"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [[ZPHTTPSessionManager sharedManager] wPost:@"/app/rescue/rescue/getRescue" parameters:params success:^(id responseObject) {
        
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            LQModelRescueDetail *modelRescueDetail = [LQModelRescueDetail mj_objectWithKeyValues:[responseObject valueForKey:@"data"]];
            if ([modelRescueDetail.rescue.status isEqualToString:@"3"])
            {
                [UIAlertView showAlertViewWithTitle:@"已有商家接受了您的救援订单" message:nil cancelButtonTitle:@"确定" otherButtonTitles:@[] onDismiss:^(int buttonIndex) {
                } onCancel:^{
                    // 救援订单
                    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Rescue" bundle:[NSBundle mainBundle]];
                    MyRescueVC * vc = [sb instantiateViewControllerWithIdentifier:@"MYRESCUEVC_SBID"];
                    [self.navigationController pushViewController:vc animated:YES];
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
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    }];
}

#pragma mark -
#pragma mark ================= UIActionSheetDelegate =================
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 3)
    {
        return;
    }
    
    
    if (buttonIndex == 0)
    {
        [self.banJinBtn setTitle:@"30km" forState:UIControlStateNormal];
        
        [self requestPointListByDistanceWithDistance:@"30"];
    }
    else if (buttonIndex == 1)
    {
        [self.banJinBtn setTitle:@"20km" forState:UIControlStateNormal];
        
        [self requestPointListByDistanceWithDistance:@"20"];
    }
    else if (buttonIndex == 2)
    {
        [self.banJinBtn setTitle:@"10km" forState:UIControlStateNormal];
        
        [self requestPointListByDistanceWithDistance:@"10"];
    }
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
