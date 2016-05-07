//
//  VIP_HelpVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/19.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "VIP_HelpVC.h"
#import "RootTBC.h"
#import "PhotoCollectionViewCell.h"
#import "ZPHTTPSessionManager.h"
#import "MLPhotoBrowserViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "LQRescueBySelfMapVC.h"
#import "RescueM.h"
#import "PublishRescueVC.h"

#define ZPHTTP [ZPHTTPSessionManager sharedManager]

@interface VIP_HelpVC ()<BMKMapViewDelegate,UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MLPhotoBrowserViewControllerDataSource,MLPhotoBrowserViewControllerDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property (nonatomic, strong) NSMutableArray *photoArray;

/**
 *  地图
 */
@property (nonatomic, strong) BMKMapView* mapView;

/**
 *  问题描述
 */
@property (nonatomic, weak) UILabel *problemDescriptionLabel;

/**
 *  问题描述
 */
@property (nonatomic, weak) UITextView *problemDescriptionTextView;

/**
 *  问题描述_placehodel
 */
@property (nonatomic, weak) UITextView *problemDescription_placehodeTextView;

/**
 *  上传地图
 */
@property (nonatomic, weak) UICollectionView *photoCollectionView;
//@property (nonatomic, weak) UIView *photoCollectionView;

/**
 *  上传地图
 */
@property (nonatomic, weak) UIButton *uploadPhotoBtn;

/**
 *  自行协商
 */
@property (nonatomic, weak) UIButton *negotiationBtn;

/**
 *  一键救援
 */
@property (nonatomic, weak) UIButton *oneKeyRescueBtn;

/**
 *  发布救援
 */
@property (nonatomic, weak) UIButton *pushRescueBtn;

@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong)BMKGeoCodeSearch *geocodesearch;

@property (nonatomic, weak) UIView *line1;
@property (nonatomic, weak) UIView *line2;

@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *county;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *lat;

@end

@implementation VIP_HelpVC

- (NSMutableArray *)photoArray
{
    if (!_photoArray)
    {
        _photoArray = [NSMutableArray array];
    }
    
    return _photoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"救援";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self drawSubviews];
    [self startLocation];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    self.locService.delegate = self;
    self.geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    [(RootTBC *)ZPRootViewController setTabBarHidden:YES
                                            animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
    self.locService.delegate = nil;
    self.geocodesearch.delegate = nil; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawSubviews
{
    BMKMapView* mapView = [[BMKMapView alloc]init];
    mapView.zoomLevel = 18;
    [self.view addSubview:mapView];
    self.mapView = mapView;
    
    //初始化BMKLocationService
    self.locService = [[BMKLocationService alloc]init];
    self.geocodesearch = [[BMKGeoCodeSearch alloc]init];
    
    UILabel *problemDescriptionLabel = [[UILabel alloc] init];
//    problemDescriptionLabel.backgroundColor = [UIColor darkGrayColor];
    problemDescriptionLabel.text = @"问题描述";
    problemDescriptionLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:problemDescriptionLabel];
    self.problemDescriptionLabel = problemDescriptionLabel;
    
    UITextView *problemDescription_placehodeTextView = [[UITextView alloc] init];
//    problemDescription_placehodeTextView.backgroundColor = [UIColor lightGrayColor];
    problemDescription_placehodeTextView.text = @"请您再次描述理赔商品的详细情况，并上传图片";
    problemDescription_placehodeTextView.editable = NO;
    problemDescription_placehodeTextView.textColor = [UIColor lightGrayColor];
    problemDescription_placehodeTextView.layer.borderWidth = 1;
    problemDescription_placehodeTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:problemDescription_placehodeTextView];
    self.problemDescription_placehodeTextView = problemDescription_placehodeTextView;
    
    UITextView *problemDescriptionTextView = [[UITextView alloc] init];
//    problemDescriptionTextView.backgroundColor = [UIColor grayColor];
    problemDescriptionTextView.delegate = self;
    problemDescriptionTextView.textColor = [UIColor blackColor];
    problemDescriptionTextView.backgroundColor = [UIColor clearColor];
    problemDescriptionTextView.layer.borderWidth = 1;
    problemDescriptionTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:problemDescriptionTextView];
    self.problemDescriptionTextView = problemDescriptionTextView;
    
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
    [self.view addSubview:photoCollectionView];
    self.photoCollectionView = photoCollectionView;
    
    UIButton *uploadPhotoBtn = [[UIButton alloc] init];
//    uploadPhotoBtn.backgroundColor = [UIColor greenColor];
    [uploadPhotoBtn setTitle:@"上传图片" forState:UIControlStateNormal];
    uploadPhotoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    uploadPhotoBtn.layer.borderWidth = 1;
    uploadPhotoBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    uploadPhotoBtn.layer.cornerRadius = 5;
    [uploadPhotoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [uploadPhotoBtn addTarget:self action:@selector(uploadPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:uploadPhotoBtn];
    self.uploadPhotoBtn = uploadPhotoBtn;
    
    UIButton *negotiationBtn = [[UIButton alloc] init];
//    negotiationBtn.backgroundColor = [UIColor blueColor];
    [negotiationBtn setTitle:@"自行协商" forState:UIControlStateNormal];
    negotiationBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [negotiationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [negotiationBtn setImage:[UIImage imageNamed:@"ic_service_byself"] forState:UIControlStateNormal];
    [negotiationBtn addTarget:self action:@selector(clickNegotiationBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:negotiationBtn];
    self.negotiationBtn = negotiationBtn;
    
    UIButton *oneKeyRescueBtn = [[UIButton alloc] init];
//    oneKeyRescueBtn.backgroundColor = [UIColor cyanColor];
    [oneKeyRescueBtn setTitle:@"一键救援" forState:UIControlStateNormal];
    oneKeyRescueBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [oneKeyRescueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [oneKeyRescueBtn setImage:[UIImage imageNamed:@"ic_rescue_phone"] forState:UIControlStateNormal];
    [oneKeyRescueBtn addTarget:self action:@selector(clickoneKeyRescueBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:oneKeyRescueBtn];
    self.oneKeyRescueBtn = oneKeyRescueBtn;
    
    UIButton *pushRescueBtn = [[UIButton alloc] init];
//    pushRescueBtn.backgroundColor = [UIColor yellowColor];
    [pushRescueBtn setTitle:@"发布救援" forState:UIControlStateNormal];
    pushRescueBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [pushRescueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pushRescueBtn setImage:[UIImage imageNamed:@"ic_public_rescue"] forState:UIControlStateNormal];
    [pushRescueBtn addTarget:self action:@selector(clickpushRescueBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushRescueBtn];
    self.pushRescueBtn = pushRescueBtn;
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line1];
    self.line1 = line1;
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line2];
    self.line2 = line2;
    
    [self drawSubViewFrame];
}

- (void)drawSubViewFrame
{
    self.mapView.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(250);
    
    self.problemDescriptionLabel.sd_layout
    .topSpaceToView(self.mapView,1)
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .heightIs(20);
    
    self.negotiationBtn.sd_layout
    .bottomSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .widthIs(kScreenWidth/3 - 2)
    .heightIs(40);
    
    self.line1.sd_layout
    .leftSpaceToView(self.negotiationBtn,0)
    .centerYEqualToView(self.negotiationBtn)
    .heightIs(30)
    .widthIs(1);
    
    self.oneKeyRescueBtn.sd_layout
    .bottomSpaceToView(self.view,0)
    .leftSpaceToView(self.line1,0)
    .widthIs(kScreenWidth/3 - 2)
    .heightIs(40);
    
    self.line2.sd_layout
    .leftSpaceToView(self.oneKeyRescueBtn,0)
    .centerYEqualToView(self.negotiationBtn)
    .heightIs(30)
    .widthIs(1);
    
    self.pushRescueBtn.sd_layout
    .bottomSpaceToView(self.view,0)
    .leftSpaceToView(self.line2,0)
    .widthIs(kScreenWidth/3 - 2)
    .heightIs(40);
    
    self.uploadPhotoBtn.sd_layout
    .bottomSpaceToView(self.negotiationBtn,0)
    .leftSpaceToView(self.view,10)
    .widthIs(80)
    .heightIs(30);
    
    self.photoCollectionView.sd_layout
    .bottomSpaceToView(self.uploadPhotoBtn,2)
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .heightIs(100);
    
    self.problemDescription_placehodeTextView.sd_layout
    .topSpaceToView(self.problemDescriptionLabel,2)
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .bottomSpaceToView(self.photoCollectionView,2);
    
    self.problemDescriptionTextView.sd_layout
    .topSpaceToView(self.problemDescriptionLabel,2)
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .bottomSpaceToView(self.photoCollectionView,2);

}

- (void)uploadPhoto
{
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}

- (void)startLocation
{
    //启动LocationService
    [self.locService startUserLocationService];
    self.mapView.showsUserLocation = NO;//先关闭显示的定位图层
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    self.mapView.showsUserLocation = YES;//显示定位图层
}

/**
 *  自行协商
 */
- (void)clickNegotiationBtn
{
    [self requestWithType:@"1"];
}

- (void)clickoneKeyRescueBtn
{
    [self requestWithType:@"2"];
}

- (void)clickpushRescueBtn
{
    [self requestWithType:@"3"];
}

#pragma mark -
#pragma mark ================= 网络请求 =================
- (void)requestWithType:(NSString *)type
{
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:@"" animated:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:type forKey:@"type"];
    [params setValue:self.province forKey:@"province"];
    [params setValue:self.city forKey:@"city"];
    [params setValue:self.county forKey:@"county"];
    [params setValue:self.detail forKey:@"detail"];
    [params setValue:self.lng forKey:@"lng"];
    [params setValue:self.lat forKey:@"lat"];
    
    if (self.problemDescriptionTextView.text.length)
    {
        [params setValue:self.problemDescriptionTextView.text forKey:@"description"];
    }
    
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    NSMutableArray *files = [NSMutableArray array];
    int m = 1;
    for (UIImage *image in self.photoArray)
    {
        NSDictionary *fileDic = @{
                                  @"kFileData" : UIImageJPEGRepresentation(image, 0.1),
                                  @"kName" : @"files",
                                  @"kFileName" : @"file.jpg",
                                  @"kMimeType" : @"file"
                                  };
        [files addObject:fileDic];
        m++;
    }
    
    [ZPHTTP LQPost:@"/app/rescue/rescue/saveRescue" parameters:params fileInfo:files success:^(NSDictionary *object) {
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
        
        if ([type isEqualToString:@"1"])
        {
            UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
            returnButtonItem.title = @"";
            self.navigationItem.backBarButtonItem = returnButtonItem;
            LQRescueBySelfMapVC *vc = [[LQRescueBySelfMapVC alloc] init];
            vc.lat = self.lat;
            vc.lng = self.lng;
            vc.rescueId = [[[object valueForKey:@"data"] valueForKey:@"rescue"] valueForKey:@"id"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([type isEqualToString:@"2"])
        {
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
        }
        else if ([type isEqualToString:@"3"])
        {
            //将我们的storyBoard实例化，“Main”为StoryBoard的名称
            UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Rescue" bundle:nil];
            
            //将第二个控制器实例化，"SecondViewController"为我们设置的控制器的ID
            PublishRescueVC *rescueBySelfListVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"PublishRescueVC"];
            rescueBySelfListVC.lat = self.lat;
            rescueBySelfListVC.lng = self.lng;
            rescueBySelfListVC.rescueID = [[[object valueForKey:@"data"] valueForKey:@"rescue"] valueForKey:@"id"];
            [self.navigationController pushViewController:rescueBySelfListVC animated:YES];
//
        }
        
    } failure:^(NSError *error) {
        NSLog(@"**%@",error);
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
    }];
}

#pragma mark -
#pragma mark ================= UITextViewDelegate =================
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *toBeStr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    self.problemDescription_placehodeTextView.hidden = toBeStr.length;
    
    return YES;
}

#pragma mark -
#pragma mark ================= UIActionSheetDelegate =================
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2)
    {
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if (buttonIndex == 0)
    {
        //判断相机是否可用
        BOOL hasCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        if (hasCamera)
        {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.sourceType = sourceType;
            picker.allowsEditing = NO;
            [self presentViewController:picker animated:YES completion:nil];
        }else {
            [MBProgressHUD showErrorHUDAddedToWindowWithErrorStr:@"相机不可用" animated:YES showTime:1];
        }
    }
    else if (buttonIndex == 1)
    {
        // 从相册中选取
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark ================= UIImagePickerControllerDelegate =================
/**
 *  从相册获取照片的回掉
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)aImage editingInfo:(NSDictionary *)editingInfo
{
//    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.photoArray addObject:aImage];
    [self.photoCollectionView reloadData];
}

#pragma mark -
#pragma mark ================= CollectionViewDelegate,UICollectionViewDataSource =================
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"PhotoCollectionViewCell";
    PhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.imageView.image = self.photoArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 图片游览器
    MLPhotoBrowserViewController *photoBrowser = [[MLPhotoBrowserViewController alloc] init];
    // 缩放动画
    photoBrowser.status = UIViewAnimationAnimationStatusZoom;
    // 可以删除
    photoBrowser.editing = YES;
    // 数据源/delegate
    photoBrowser.delegate = self;
    photoBrowser.dataSource = self;
    // 当前选中的值
    photoBrowser.currentIndexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:0];
    // 展示控制器
    [self.navigationController presentViewController:photoBrowser animated:NO completion:nil];
}

#pragma mark -
#pragma mark ================= BMKMapViewDelegate =================
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    NSLog(@"BMKMapView控件初始化完成");
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: click blank");
}

- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: double click");
}

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
//    [self.mapView updateLocationData:userLocation];
    
    
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = userLocation.location.coordinate.latitude;
    coor.longitude = userLocation.location.coordinate.longitude;
    annotation.coordinate = coor;
    [self.mapView addAnnotation:annotation];
    [self.mapView showAnnotations:@[annotation] animated:YES];
    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    [self.locService stopUserLocationService];
    
    self.lat = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    self.lng = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    self.city = result.addressDetail.city;
    self.province = result.addressDetail.province;
    self.county = result.addressDetail.district;
    self.detail = [NSString stringWithFormat:@"%@%@",result.addressDetail.streetName,result.addressDetail.streetNumber];
    
    NSLog(@"---->%@",self.detail);
}

#pragma mark - <MLPhotoBrowserViewControllerDataSource>
- (NSInteger)photoBrowser:(MLPhotoBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section
{
    return self.photoArray.count;
}

#pragma mark - 每个组展示什么图片,需要包装下MLPhotoBrowserPhoto
- (MLPhotoBrowserPhoto *) photoBrowser:(MLPhotoBrowserViewController *)browser photoAtIndexPath:(NSIndexPath *)indexPath
{
    // 包装下imageObj 成 ZLPhotoPickerBrowserPhoto 传给数据源
    MLPhotoBrowserPhoto *photo = [MLPhotoBrowserPhoto photoAnyImageObjWith:self.photoArray[indexPath.row]];
    
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[self.photoCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.row inSection:0]];
    photo.toView = cell.imageView;
    photo.thumbImage = cell.imageView.image;
    return photo;
}

#pragma mark - <MLPhotoBrowserViewControllerDelegate>

- (BOOL)photoBrowser:(MLPhotoBrowserViewController *)photoBrowser willRemovePhotoAtIndexPath:(NSIndexPath *)indexPath
{
    [photoBrowser dismissViewControllerAnimated:YES completion:nil];
    [self.photoArray removeObjectAtIndex:indexPath.row];
    [self.photoCollectionView reloadData];
    
    return false;
}


@end
