//
//  NetMapVC.m
//  YouChengTire
//  网点信息定位
//  Created by WangZhipeng on 16/4/17.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "NetMapVC.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"
#import "MyAnnotationView.h"
#import "AppDelegate.h"
// ViewModels
#import "NetMapVM.h"
#import "PersonalDataVM.h"

@interface NetMapVC ()

@property (nonatomic, strong) NetMapVM *netMapVM;
@property (nonatomic, strong) PersonalDataVM *personalDataVM;

@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end

@implementation NetMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [MBProgressHUD showHUDAddedTo:self.view
                             animated:NO];
        // 開始定位
        [[AppDelegate appDelegete].locationManager startUpdatingLocation];
    } else {
        NSString *message = @"您的手机目前并未开放定位服务，如欲开放定位服务，请至设定->隐私->定位服务，开放本程式的定位功能";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法定位"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles: nil];
        [alertView show];
    }
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

#pragma mark - Override
- (void)configureView {
    [self configureNavigationController];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_netMapVM, title);
}

- (void)configureData {}

#pragma mark - MKMapViewDelegate
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    [MBProgressHUD hideHUDForView:self.view
                         animated:YES];
    
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [self.mapView setRegion:region
                   animated:YES];
    
    _netMapVM.lat = [NSString stringWithFormat:@"%f", loc.latitude];
    _netMapVM.lng = [NSString stringWithFormat:@"%f", loc.longitude];
    
    UIBarButtonItem *submitBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(openRightMenu:)];
    [self.navigationItem setRightBarButtonItems:@[submitBarButtonItem]];
}

#pragma mark - Private
- (void)configureNavigationController {}

- (void)openRightMenu:(id)sender {
    if (STRING_NOT_EMPTY(_netMapVM.lat)
        && STRING_NOT_EMPTY(_netMapVM.lng)) {
        _personalDataVM.userDetailsM.point.lat = _netMapVM.lat;
        _personalDataVM.userDetailsM.point.lng = _netMapVM.lng;
        _personalDataVM.userDetailsM.point.position = [NSString stringWithFormat:@"%@,%@", _netMapVM.lat, _netMapVM.lng];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        NSString *message = @"您的手机目前并未开放定位服务，如欲开放定位服务，请至设定->隐私->定位服务，开放本程式的定位功能";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法定位"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles: nil];
        [alertView show];
    }
}

- (void)setPersonalDataVM:(PersonalDataVM *)personalDataVM {
    _personalDataVM = personalDataVM;
}

@end
