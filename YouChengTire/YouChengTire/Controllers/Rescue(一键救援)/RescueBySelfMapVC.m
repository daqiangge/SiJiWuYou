//
//  RescueBySelfMapVC.m
//  YouChengTire
//
//  Created by Baby on 16/3/31.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "RescueBySelfMapVC.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"
#import "MyAnnotationView.h"
#import "AppDelegate.h"


#import "RescueVM.h"


@interface RescueBySelfMapVC ()<MKMapViewDelegate>

@property (strong, nonatomic) RescueVM * rescueVM;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSMutableArray * annotationArrays;
@end

@implementation RescueBySelfMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rescueVM = [[RescueVM alloc] init];
    self.annotationArrays = [[NSMutableArray alloc] init];
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        // 開始定位
        [[AppDelegate appDelegete].locationManager startUpdatingLocation];
    }else {
        NSString *message = @"您的手机目前并未开放定位服务，如欲开放定位服务，请至设定->隐私->定位服务，开放本程式的定位功能";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法定位" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
}

- (void)requestServiceWithParams:(NSDictionary *)_params coor:(CLLocationCoordinate2D)_loc{
    @weakify(self)
    [_rescueVM requestGetNearbyPointList:^(id object) {
        @strongify(self)
        NearbyPointM *nearbyPointM = object;
        [self refrashMapAnnotations:_loc annotationArr:nearbyPointM.pointList];
    } data:_params error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        
    }];
}

- (void)refrashMapAnnotations:(CLLocationCoordinate2D)_loc annotationArr:(NSArray *)arr{
    //放大地图到自身的经纬度位置。
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(_loc, 250, 250);
    [self.mapView setRegion:region animated:YES];
    self.mapView.showsUserLocation = NO;
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.annotationArrays removeAllObjects];
    
    MyAnnotation * myAnnotation = [[MyAnnotation alloc] initWithCoordinates:_loc title:@"My Title" subTitle:@"My Sub Title"];
    myAnnotation.imageName = @"ic_location_green";
    [self.annotationArrays addObject:myAnnotation];
    
    for (NearbyPointItemM * nPI in arr) {
        CLLocationCoordinate2D location1 = CLLocationCoordinate2DMake([nPI.p_lat doubleValue], [nPI.p_lng doubleValue]);
        MyAnnotation * annotation = [[MyAnnotation alloc] initWithCoordinates:location1 title:@"My Title" subTitle:@"My Sub Title"];
        annotation.imageName = @"ic_location_red";
        [self.annotationArrays addObject:annotation];
    }
    [self.mapView addAnnotations:self.annotationArrays];
}


#pragma mark - MKMapViewDelegate

//MapView委托方法，当定位自身时调用
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    NSString * lat = [NSString stringWithFormat:@"%f",loc.latitude];
    NSString * lng = [NSString stringWithFormat:@"%f",loc.longitude];
    NSDictionary * data = @{@"lng":lng,@"lat":lat};
    [self requestServiceWithParams:@{@"lng":lng,@"lat":lat,@"appKey":[BaseVM createAppKey:data]} coor:loc];
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView * result = nil;
    if([annotation isKindOfClass:[MyAnnotation class]] == NO)
    {
        return result;
    }
    
    if([mapView isEqual:self.mapView] == NO)
    {
        return result;
    }
    
    static NSString *AnnotationViewID = @"AnimatedAnnotation";
    MyAnnotationView *annotationView = (MyAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[MyAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
    //    annotationView.delegate = self;
    MyAnnotation * myAnnotation = (MyAnnotation *)annotation;
    annotationView.customAnnotation = myAnnotation;
    annotationView.image = [UIImage imageNamed:myAnnotation.imageName];
    result = annotationView;
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
