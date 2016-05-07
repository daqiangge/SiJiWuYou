//
//  VipVC.m
//  YouChengTire
//
//  Created by Baby on 16/3/17.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "VipVC.h"
#import "RootTBC.h"
#import "RescueVM.h"
#import "AppDelegate.h"

@interface VipVC ()
@property (strong, nonatomic) RescueVM * rescueVM;

@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (copy, nonatomic) NSString * lat;
@property (copy, nonatomic) NSString * lng;
@property (copy, nonatomic) NSString * proviceStr;
@property (copy, nonatomic) NSString * cityStr;
@property (copy, nonatomic) NSString * districtStr;
@end

@implementation VipVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [(RootTBC *)ZPRootViewController setTabBarHidden:YES
                                            animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"救援";
    self.rescueVM = [[RescueVM alloc] init];
    self.location = [AppDelegate appDelegete].loc;
    self.lat = [NSString stringWithFormat:@"%f",self.location.latitude];
    self.lng = [NSString stringWithFormat:@"%f",self.location.longitude];
    self.proviceStr = [AppDelegate appDelegete].locState;
    self.cityStr = [AppDelegate appDelegete].locCity;
    self.districtStr = [AppDelegate appDelegete].locSubLocality;
}

- (IBAction)rescueBySelfBtnClicked:(UIButton *)sender {
    [self requestDataFromServiceWithTag:@"1"];
}

- (IBAction)rescuePhoneBtnClicked:(id)sender {
    [self requestDataFromServiceWithTag:@"2"];
}

- (IBAction)publishBtnClicked:(id)sender {
    [self requestDataFromServiceWithTag:@"3"];
}

- (void)requestDataFromServiceWithTag:(NSString *)_tagStr{
    NSString * str = [NSString stringWithFormat:@"%@%@%@",self.proviceStr,self.cityStr,self.districtStr];
    NSMutableDictionary * params = @{@"type":_tagStr,@"province":self.proviceStr,@"city":self.cityStr,@"county":self.districtStr,@"detail":str,@"lng":self.lng,@"lat":self.lat}.mutableCopy;
    [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [self.rescueVM requestSaveRescue:^(id object) {
        @strongify(self)
        if ([@"1" isEqualToString:_tagStr]) {
            [self performSegueWithIdentifier:@"RescueBySelfVC_ID" sender:nil];
        }else if ([@"2" isEqualToString:_tagStr]){
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"客服中心"
                                                  message:@"工作时间: 8:30~21:00"
                                                  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"呼叫"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                   [[UIApplication sharedApplication]
                                                                    openURL:[NSURL URLWithString:@"tel:400-400-8888"]];
                                                               }];
            [alertController addAction:callAction];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:nil];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController
                               animated:YES
                             completion:nil];
        }else{
            [self performSegueWithIdentifier:@"PublishRescueVC_ID" sender:nil];
        }

    } data:params error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}


#pragma mark - Override
- (void)configureView {
    [self configureNavigationController];
}

#pragma mark - Private
- (void)configureNavigationController {
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
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
