//
//  LQOrderClaimsVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/25.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQOrderClaimsVC.h"
#import "LQOrderClaimsCell.h"
#import "LQOrderClaimsCell1.h"
#import "LQOrderClaimsCell2.h"
#import "LQOrderClaimsCell3.h"
#import "LQOrderClaimsShangMengTimeCell.h"
#import "LQOrderClaimsAddressCell.h"
#import "LQOrderClaimsAddressDetailCell.h"
#import "PhotoCollectionViewCell.h"
#import "MWPhotoBrowser.h"
#import "LQModelStandardList.h"
#import "LQModelStandard.h"
#import "LQModelStandardChild.h"
#import "ActivitiesPublishTimePickerView.h"
#import "ReceiptAddressVC.h"
#import "ReceiptAddressM.h"

@interface LQOrderClaimsVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,MWPhotoBrowserDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak) UITextView *problemDescription_placehodeTextView;
@property (nonatomic, weak) UITextView *problemDescriptionTextView;
@property (nonatomic, weak) UICollectionView *photoCollectionView;
@property (nonatomic, weak) UITableView *tableView;
@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@property (strong, nonatomic) UINavigationController *photoNavigationController;
@property (nonatomic, strong) NSMutableArray *photoArray;
@property (nonatomic, weak) ActivitiesPublishTimePickerView *pickerView;
@property (nonatomic, strong) ReceiptAddressItemM *addressModel;

@property (nonatomic, strong) LQModelStandardList *modelStandardList;
@property (nonatomic, strong) NSMutableArray *guiGeArray;
@property (nonatomic, strong) NSMutableArray *guiGeArray2;

@property (nonatomic, copy) NSString *guiGeStr;
@property (nonatomic, copy) NSString *guiGeStr2;
@property (nonatomic, copy) NSString *pingPaiStr;
@property (nonatomic, copy) NSString *huaWenStr;
@property (nonatomic, copy) NSString *taiHaoStr;
@property (nonatomic, copy) NSString *dateStr;
@property (nonatomic, copy) NSString *descriptionStr;

@end

@implementation LQOrderClaimsVC

- (NSMutableArray *)photoArray
{
    if (!_photoArray)
    {
        _photoArray = [NSMutableArray array];
    }
    
    return _photoArray;
}

- (NSMutableArray *)guiGeArray
{
    if (!_guiGeArray)
    {
        _guiGeArray = [NSMutableArray array];
    }
    
    return _guiGeArray;
}

- (NSMutableArray *)guiGeArray2
{
    if (!_guiGeArray2)
    {
        _guiGeArray2 = [NSMutableArray array];
    }
    
    return _guiGeArray2;
}

- (ActivitiesPublishTimePickerView *)pickerView
{
    if (!_pickerView) {
        ActivitiesPublishTimePickerView *pickerView = [[ActivitiesPublishTimePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.view.window addSubview: pickerView];
        _pickerView = pickerView;
    }
    
    return _pickerView;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"申请理赔";
    
    [self drawView];
    [self requestGetStandardList];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.tableFooterView = [self drawTableFooterView];
    
    UIButton *commitBtn = [[UIButton alloc] init];
    commitBtn.backgroundColor = [UIColor redColor];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(didCommitBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,40)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0);
    
    commitBtn.sd_layout
    .leftSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(tableView,0);
}

- (UIView *)drawTableFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"问题描述";
    label.font = [UIFont systemFontOfSize:15];
    [footerView addSubview:label];
    
    
    UITextView *problemDescription_placehodeTextView = [[UITextView alloc] init];
    problemDescription_placehodeTextView.text = @"请您再次描述理赔商品的详细情况，并上传图片";
    problemDescription_placehodeTextView.editable = NO;
    problemDescription_placehodeTextView.textColor = [UIColor lightGrayColor];
    [footerView addSubview:problemDescription_placehodeTextView];
    self.problemDescription_placehodeTextView = problemDescription_placehodeTextView;
    
    UITextView *problemDescriptionTextView = [[UITextView alloc] init];
    problemDescriptionTextView.delegate = self;
    problemDescriptionTextView.textColor = [UIColor blackColor];
    problemDescriptionTextView.backgroundColor = [UIColor clearColor];
    problemDescriptionTextView.layer.borderWidth = 1;
    problemDescriptionTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [footerView addSubview:problemDescriptionTextView];
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
    [footerView addSubview:photoCollectionView];
    self.photoCollectionView = photoCollectionView;
    
    UIButton *uploadBtn = [[UIButton alloc] init];
    [uploadBtn setTitle:@"上传图片" forState:UIControlStateNormal];
    [uploadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    uploadBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    uploadBtn.layer.cornerRadius = 5;
    uploadBtn.layer.borderColor = COLOR_LightGray.CGColor;
    uploadBtn.layer.borderWidth = 1;
    [uploadBtn addTarget:self action:@selector(didClickUploadBtn) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:uploadBtn];
    
    label.sd_layout
    .topSpaceToView(footerView,10)
    .leftSpaceToView(footerView,10)
    .rightSpaceToView(footerView,10)
    .autoHeightRatio(0);
    
    problemDescription_placehodeTextView.sd_layout
    .topSpaceToView(label,3)
    .leftSpaceToView(footerView,10)
    .rightSpaceToView(footerView,10)
    .heightIs(100);
    
    problemDescriptionTextView.sd_layout
    .topSpaceToView(label,3)
    .leftSpaceToView(footerView,10)
    .rightSpaceToView(footerView,10)
    .heightIs(100);
    
    photoCollectionView.sd_layout
    .topSpaceToView(problemDescriptionTextView,5)
    .leftSpaceToView(footerView,10)
    .rightSpaceToView(footerView,10)
    .heightIs(100);
    
    uploadBtn.sd_layout
    .topSpaceToView(photoCollectionView,5)
    .leftSpaceToView(footerView,10)
    .widthIs(80)
    .heightIs(35);
    
    return footerView;
}

- (void)didCommitBtn
{
    if (!self.addressModel)
    {
        kMRCError(@"请填写地址");
    }
    [self requestSaveClaim];
}

- (void)didClickUploadBtn
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
/**
 *  获取轮胎规格
 */
- (void)requestGetStandardList
{
    [ZPHTTP wPost:@"/app/prd/tire/getStandardList" parameters:nil success:^(id responseObject) {
        
        self.modelStandardList = [LQModelStandardList mj_objectWithKeyValues:[responseObject valueForKey:@"data"]];
        
        for (LQModelStandard *modelStandar in self.modelStandardList.standardList)
        {
            [self.guiGeArray addObject:modelStandar.name];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)requestSaveClaim
{
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:@"" animated:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[NSString stringWithFormat:@"%@ %@",self.guiGeStr,self.guiGeStr2] forKey:@"standard"];
    [params setValue:self.pingPaiStr forKey:@"brand"];
    [params setValue:self.huaWenStr forKey:@"pattern"];
    [params setValue:self.taiHaoStr forKey:@"tireNumber"];
    [params setValue:self.descriptionStr forKey:@"description"];
    [params setValue:self.addressModel.sId forKey:@"addressId"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    NSMutableArray *files = [NSMutableArray array];
    int m = 1;
    for (UIImage *image in self.photoArray)
    {
        NSDictionary *fileDic = @{
                                  @"kFileData" : UIImageJPEGRepresentation(image, 0.1),
                                  @"kName" : [NSString stringWithFormat:@"file%d",m],
                                  @"kFileName" : [NSString stringWithFormat:@"file%d.jpg",m],
                                  @"kMimeType" : @"file"
                                  };
        [files addObject:fileDic];
        m++;
    }
    
    NSLog(@"---->%@",params);
    
    [[ZPHTTPSessionManager sharedManager] LQPost:@"/app/service/claim/saveClaim" parameters:params fileInfo:files success:^(NSDictionary *object) {
        NSLog(@"**%@",object);
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
        
        if ([object[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            NSInteger errnoInteger = [object[@"msgCode"] integerValue];
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : object[@"msg"] };
            NSError *uError = [NSError errorWithDomain:@"ZPCustom"
                                                  code:errnoInteger
                                              userInfo:userInfo];
            kMRCError(uError.localizedDescription);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"**%@",error);
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
    }];
}

#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 4;
        }
            break;
        case 1:
        {
            return 3;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                LQOrderClaimsCell *cell = [LQOrderClaimsCell cellWithTableView:tableView];
                
                cell.guiGeStr = self.guiGeStr;
                cell.guiGeStr2 = self.guiGeStr2;
                
                __weak typeof(self) weakSelf = self;
                __weak typeof(cell) weakCell = cell;
                cell.clickGuiGeBtn = ^(){
                    if (self.guiGeArray.count)
                    {
                        LCActionSheet *sheet = [[LCActionSheet alloc] initWithTitle:nil buttonTitles:weakSelf.guiGeArray redButtonIndex:-1 delegate:nil];
                        sheet.didClickedButtonAtIndex = ^(NSInteger btnIndex,NSString *title){
                            weakSelf.guiGeStr = title;
                            weakCell.guiGeStr = title;
                            for (LQModelStandard *modelStandar in weakSelf.modelStandardList.standardList)
                            {
                                if ([modelStandar.name isEqualToString:weakSelf.guiGeStr])
                                {
                                    [weakSelf.guiGeArray2 removeAllObjects];
                                    
                                    for (LQModelStandardChild *modelStandardChild in modelStandar.childList)
                                    {
                                        [weakSelf.guiGeArray2 addObject:modelStandardChild.name];
                                    }
                                    
                                    LQModelStandardChild *modelStandardChild = [modelStandar.childList firstObject];
                                    
                                    weakSelf.guiGeStr2 = modelStandardChild.name;
                                    weakCell.guiGeStr2 = modelStandardChild.name;
                                }
                            }
                        };
                        [sheet show];
                    }
                    else
                    {
                        kMRCError(@"没有可选规格");
                    }
                };
                
                cell.clickXingHaoBtn = ^(){
                    if (self.guiGeArray2.count)
                    {
                        LCActionSheet *sheet = [[LCActionSheet alloc] initWithTitle:nil buttonTitles:weakSelf.guiGeArray2 redButtonIndex:-1 delegate:nil];
                        sheet.didClickedButtonAtIndex = ^(NSInteger btnIndex,NSString *title){
                            weakSelf.guiGeStr2 = title;
                            weakCell.guiGeStr2 = title;
                        };
                        [sheet show];
                    }
                    else
                    {
                        kMRCError(@"没有可选型号");
                    }
                };
                
                return cell;
            }
                break;
            case 1:
            {
                LQOrderClaimsCell1 *cell = [LQOrderClaimsCell1 cellWithTableView:tableView];
                
                __weak typeof(self) weakSelf = self;
                cell.textFieldDidChange = ^(NSString *str){
                    weakSelf.pingPaiStr = str;
                };
                
                return cell;
            }
                break;
            case 2:
            {
                LQOrderClaimsCell2 *cell = [LQOrderClaimsCell2 cellWithTableView:tableView];
                
                __weak typeof(self) weakSelf = self;
                cell.textFieldDidChange = ^(NSString *str){
                    weakSelf.huaWenStr = str;
                };
                
                return cell;
            }
                break;
            case 3:
            {
                LQOrderClaimsCell3 *cell = [LQOrderClaimsCell3 cellWithTableView:tableView];
                
                __weak typeof(self) weakSelf = self;
                cell.textFieldDidChange = ^(NSString *str){
                    weakSelf.taiHaoStr = str;
                };
                
                return cell;
            }
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 1)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                LQOrderClaimsShangMengTimeCell *cell = [LQOrderClaimsShangMengTimeCell cellWithTableView:tableView];
                cell.dateStr = self.dateStr;
                return cell;
            }
                break;
            case 1:
            {
                LQOrderClaimsAddressCell *cell = [LQOrderClaimsAddressCell cellWithTableView:tableView];
                
                return cell;
            }
                break;
            case 2:
            {
                LQOrderClaimsAddressDetailCell *cell = [LQOrderClaimsAddressDetailCell cellWithTableView:tableView];
                
                if (self.addressModel)
                {
                    cell.model = self.addressModel;
                }
                
                return cell;
            }
                break;
                
            default:
                break;
        }
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 2)
    {
        if (!self.addressModel)
        {
            return [tableView cellHeightForIndexPath:indexPath model:nil keyPath:nil cellClass:[LQOrderClaimsAddressDetailCell class] contentViewWidth:kScreenWidth];
        }
        else
        {
            return [tableView cellHeightForIndexPath:indexPath model:self.addressModel keyPath:@"ReceiptAddressItemM" cellClass:[LQOrderClaimsAddressDetailCell class] contentViewWidth:kScreenWidth];
        }
    }
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        LQOrderClaimsShangMengTimeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.pickerView.hidden = NO;
        [self.pickerView showMyPicker];
        self.pickerView.date = [NSDate date];
        self.pickerView.minDate = [NSDate date];
        self.pickerView.maxDate = nil;
        
        __weak typeof(self) weakSelf = self;
        __weak typeof(cell) weakCell = cell;
        [self.pickerView returnDateStr:^(NSString *dateStr,NSDate *date) {
            weakSelf.dateStr = dateStr;
            weakCell.dateStr = dateStr;
        }];
    }
    else if (indexPath.section == 1 && indexPath.row == 2)
    {
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
        ReceiptAddressVC *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ReceiptAddressVC"];
        vc.isFromLQOrderClaimsVC = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        __weak typeof(self) weakSelf = self;
        LQOrderClaimsAddressDetailCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        vc.selectAddress = ^(ReceiptAddressItemM *model){
            weakSelf.addressModel = model;
            cell.model = model;
        };
    }
}

#pragma mark -
#pragma mark ================= UITextViewDelegate =================
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *toBeStr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    self.problemDescription_placehodeTextView.hidden = toBeStr.length;
    self.descriptionStr = toBeStr;
    
    return YES;
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
    [self.photoBrowser setCurrentPhotoIndex:indexPath.row];
    [self presentViewController:self.photoNavigationController animated:YES completion:nil];
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
    [self.photoBrowser reloadData];
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
        MWPhoto *photo = [MWPhoto photoWithImage:self.photoArray[index]];
        return photo;
    }
    
    return nil;
}

@end
