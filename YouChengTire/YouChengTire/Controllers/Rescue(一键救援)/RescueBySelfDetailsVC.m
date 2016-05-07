//
//  RescueBySelfDetailsVC.m
//  YouChengTire
//
//  Created by duwen on 16/4/15.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "RescueBySelfDetailsVC.h"
#import "RescueVM.h"
#import "MyRescueVC.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "PhotoCollectionViewCell.h"
#import "MWPhotoBrowser.h"
#import "LQModelRescue.h"
#import "LQModelPicture.h"

@interface RescueBySelfDetailsVC ()<UITextFieldDelegate,BMKMapViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,MWPhotoBrowserDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *addressLab;
@property (strong, nonatomic) IBOutlet UILabel *routeLab;
@property (strong, nonatomic) RescueVM * rescueVM;

@property (strong, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextView *problemDescriptionTextView;
@property (weak, nonatomic) IBOutlet UITextView *problemDescription_placehodeTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionVeiw;
@property (weak, nonatomic) IBOutlet UIButton *uploadPhotoBtn;

@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@property (strong, nonatomic) UINavigationController *photoNavigationController;

@property (nonatomic, strong) NSMutableArray *photoArray;

@property (nonatomic, strong) LQModelRescue *modelRescue;

@property (nonatomic, strong) BMKPointAnnotation *myAnnotation;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation RescueBySelfDetailsVC

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
    
    self.navigationItem.title = @"救援订单";
    
    self.scrollView.delegate = self;
    [self drawView];
    [self requestGetRescue];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;}

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
    self.uploadPhotoBtn.hidden = YES;
    self.problemDescriptionTextView.editable = NO;
    self.problemDescription_placehodeTextView.hidden = YES;
    self.mapView.zoomLevel = 14;
    self.mapView.scrollEnabled = NO;
    self.problemDescriptionTextView.delegate = self;
    self.rescueVM = [[RescueVM alloc] init];
    self.nameLab.text = self.np.name;
    self.addressLab.text = [NSString stringWithFormat:@"%@%@%@%@",self.np.province,self.np.city,self.np.county,self.np.address];
    self.routeLab.text = [NSString stringWithFormat:@"距离:%.2fkm",[self.np.distance floatValue]/1000];
    
    self.problemDescriptionTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.problemDescriptionTextView.layer.borderWidth = 1;
    
    self.uploadPhotoBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.uploadPhotoBtn.layer.borderWidth = 1;
    self.uploadPhotoBtn.layer.cornerRadius = 5;
    self.uploadPhotoBtn.layer.masksToBounds = YES;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(PhotoCollectionViewCell_W, PhotoCollectionViewCell_H);
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 15 * 0.5;
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.photoCollectionVeiw.collectionViewLayout = layout;
    [self.photoCollectionVeiw registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoCollectionViewCell"];
    self.photoCollectionVeiw.backgroundColor = [UIColor whiteColor];
    self.photoCollectionVeiw.delaysContentTouches = NO;
    self.photoCollectionVeiw.dataSource = self;
    self.photoCollectionVeiw.delegate = self;
}

- (IBAction)callclicked:(id)sender {
    NSString * phoneNum = [NSString stringWithFormat:@"tel:%@",self.np.mobile];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneNum]]];
    [self.view addSubview:callWebview];
}

- (IBAction)submitClicked:(id)sender {
    if (self.moneyTF.text.length == 0) {
        kMRCError(@"请输入金额");
        return;
    }
    
    NSMutableDictionary * params = @{@"id":self.rescueId,@"price":self.moneyTF.text,@"pointId":self.np.sId}.mutableCopy;
    [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [self.rescueVM requestEnsurePoint:^(id object) {
        @strongify(self)
        kMRCSuccess(object);
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Rescue" bundle:[NSBundle mainBundle]];
        MyRescueVC * vc = [sb instantiateViewControllerWithIdentifier:@"MYRESCUEVC_SBID"];
        [self.navigationController pushViewController:vc animated:YES];
    } data:params error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.moneyTF resignFirstResponder];
    return YES;
}

- (IBAction)clickUploadPhotoBtn:(id)sender
{
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}

#pragma mark -
#pragma mark ================= 网络请求 =================
- (void)requestGetRescue
{
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:nil animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.rescueId forKey:@"id"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [[ZPHTTPSessionManager sharedManager] wPost:@"/app/rescue/rescue/getRescue" parameters:params success:^(id responseObject) {
        
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            self.modelRescue = [LQModelRescue mj_objectWithKeyValues:responseObject[@"data"][@"rescue"]];
            
            // 添加一个PointAnnotation
            self.myAnnotation = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D coor;
            coor.latitude = [self.modelRescue.lat floatValue];
            coor.longitude = [self.modelRescue.lng floatValue];
            self.myAnnotation.coordinate = coor;
            [self.mapView addAnnotation:self.myAnnotation];
            [self.mapView showAnnotations:@[self.myAnnotation] animated:YES];
            
            if (self.modelRescue._description.length)
            {
                self.problemDescriptionTextView.text = self.modelRescue._description;
                self.problemDescription_placehodeTextView.hidden = YES;
            }
            
            if (self.modelRescue.pictureList.count)
            {
                [self.photoArray addObjectsFromArray:self.modelRescue.pictureList];
                [self.photoBrowser reloadData];
                [self.photoCollectionVeiw reloadData];
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
#pragma mark ================= CollectionViewDelegate,UICollectionViewDataSource =================
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"PhotoCollectionViewCell";
    PhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *photoDic = self.photoArray[indexPath.row];
    [cell.imageView sd_setImageWithURL:[photoDic valueForKey:@"appPath"] placeholderImage:[UIImage imageNamed:@"me_discount_logo"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.photoBrowser setCurrentPhotoIndex:indexPath.row];
    [self presentViewController:self.photoNavigationController animated:YES completion:nil];
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
    [self.photoBrowser reloadData];
    [self.photoCollectionVeiw reloadData];
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
        NSDictionary *photoDic = self.photoArray[index];
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:[photoDic valueForKey:@"appPath"]]];
        return photo;
    }
    
    return nil;
}


@end
