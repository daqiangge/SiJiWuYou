//
//  LQFaHuoVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQFaHuoVC.h"
#import "LQFahuoCell1.h"
#import "PhotoCollectionViewCell.h"
#import "MLPhotoBrowserViewController.h"

@interface LQFaHuoVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MLPhotoBrowserViewControllerDataSource,MLPhotoBrowserViewControllerDelegate>

/**
 *  描述
 */
@property (nonatomic, weak) UITextView *problemDescriptionTextView;
@property (nonatomic, weak) UITextView *problemDescription_placehodeTextView;
@property (nonatomic, weak) UICollectionView *photoCollectionView;
@property (nonatomic, strong) NSMutableArray *photoArray;
@property (nonatomic, weak) MLPhotoBrowserViewController *photoBrowser;

@end

@implementation LQFaHuoVC

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
    
    self.title = @"发布货源";
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(request)];
    self.navigationItem.rightBarButtonItem = barBtn;
    
    [self drawView];
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
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [self drawFooterView];
    [self.view addSubview:tableView];
}

- (UIView *)drawFooterView
{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 420)];
    footView.backgroundColor = [UIColor whiteColor];
    
    UILabel *problemDescriptionLabel = [[UILabel alloc] init];
    problemDescriptionLabel.text = @"货物描述";
    problemDescriptionLabel.font = [UIFont systemFontOfSize:15];
    [footView addSubview:problemDescriptionLabel];
    
    UITextView *problemDescription_placehodeTextView = [[UITextView alloc] init];
    problemDescription_placehodeTextView.text = @"请输入货物描述";
    problemDescription_placehodeTextView.editable = NO;
    problemDescription_placehodeTextView.textColor = [UIColor lightGrayColor];
    problemDescription_placehodeTextView.layer.borderWidth = 1;
    problemDescription_placehodeTextView.layer.borderColor = COLOR_LightGray.CGColor;
    [footView addSubview:problemDescription_placehodeTextView];
    self.problemDescription_placehodeTextView = problemDescription_placehodeTextView;
    
    UITextView *problemDescriptionTextView = [[UITextView alloc] init];
    problemDescriptionTextView.delegate = self;
    problemDescriptionTextView.textColor = [UIColor blackColor];
    problemDescriptionTextView.backgroundColor = [UIColor clearColor];
    problemDescriptionTextView.layer.borderWidth = 1;
    problemDescriptionTextView.layer.borderColor = COLOR_LightGray.CGColor;
    [footView addSubview:problemDescriptionTextView];
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
    [footView addSubview:photoCollectionView];
    self.photoCollectionView = photoCollectionView;
    
    problemDescriptionLabel.sd_layout
    .topSpaceToView(footView,10)
    .leftSpaceToView(footView,15)
    .rightSpaceToView(footView,15)
    .heightIs(20);
    
    self.problemDescription_placehodeTextView.sd_layout
    .topSpaceToView(problemDescriptionLabel,2)
    .leftSpaceToView(footView,15)
    .rightSpaceToView(footView,15)
    .heightIs(100);
    
    self.problemDescriptionTextView.sd_layout
    .topSpaceToView(problemDescriptionLabel,2)
    .leftSpaceToView(footView,15)
    .rightSpaceToView(footView,15)
    .heightIs(100);
    
    self.photoCollectionView.sd_layout
    .topSpaceToView(self.problemDescriptionTextView,5)
    .leftSpaceToView(footView,15)
    .rightSpaceToView(footView,15)
    .heightIs(250);
    
    return footView;
}

#pragma mark -
#pragma mark ================= 网络 =================
- (void)request
{
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:@"" animated:YES];
    UITextField *tf1 = [self.view viewWithTag:100];
    UITextField *tf2 = [self.view viewWithTag:101];
    UITextField *tf3 = [self.view viewWithTag:102];
    UITextField *tf4 = [self.view viewWithTag:103];
    UITextField *tf5 = [self.view viewWithTag:104];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:tf1.text forKey:@"name"];
    [params setValue:tf2.text forKey:@"startPoint"];
    [params setValue:tf3.text forKey:@"endPoint"];
    [params setValue:tf4.text forKey:@"contacts"];
    [params setValue:tf5.text forKey:@"mobile"];
    [params setValue:self.problemDescriptionTextView.text forKey:@"content"];
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
    
    [[ZPHTTPSessionManager sharedManager] LQPost:@"/app/prd/goods/saveGoods" parameters:params fileInfo:files success:^(NSDictionary *responseObject) {
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
        
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            if (self.saveGoodsSuccess) {
                self.saveGoodsSuccess();
            }
            
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
        
    } failure:^(NSError *error) {
        NSLog(@"**%@",error);
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
        kMRCError(error.localizedDescription);
    }];
}

#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQFahuoCell1 *cell = [LQFahuoCell1 cellWithTableView:tableView];
    
    switch (indexPath.row)
    {
        case 0:
        {
            cell.titleLabel.text = @"货源名称";
            cell.textField.placeholder = @"请输入货源名称";
        }
            break;
        case 1:
        {
            cell.titleLabel.text = @"始发地";
            cell.textField.placeholder = @"请输入始发地";
        }
            break;
        case 2:
        {
            cell.titleLabel.text = @"目的地";
            cell.textField.placeholder = @"请输入目的地";
        }
            break;
        case 3:
        {
            cell.titleLabel.text = @"联系人";
            cell.textField.placeholder = @"请输入联系人";
        }
            break;
        case 4:
        {
            cell.titleLabel.text = @"联系电话";
            cell.textField.placeholder = @"请输入联系电话";
        }
            break;
            
        default:
            break;
    }
    
    cell.textField.tag = 100 + indexPath.row;
    return cell;
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
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
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.photoArray addObject:aImage];
    [self.photoCollectionView reloadData];
}

#pragma mark -
#pragma mark ================= CollectionViewDelegate,UICollectionViewDataSource =================
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (!self.photoArray.count)
    {
        return 1;
    }
    
    if (self.photoArray.count<9)
    {
        return self.photoArray.count + 1;
    }
    
    return self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"PhotoCollectionViewCell";
    PhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!self.photoArray.count)
    {
        cell.imageView.image = [UIImage imageNamed:@"ic_add"];
    }
    else if (self.photoArray.count<9)
    {
        if (indexPath.row == self.photoArray.count)
        {
            cell.imageView.image = [UIImage imageNamed:@"ic_add"];
        }
        else
        {
            cell.imageView.image = self.photoArray[indexPath.row];
        }
    }
    else
    {
        cell.imageView.image = self.photoArray[indexPath.row];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.photoArray.count)
    {
        UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"拍照", @"从相册中选取", nil];
        [choiceSheet showInView:self.view];
    }
    else if (self.photoArray.count<9)
    {
        if (indexPath.row == self.photoArray.count)
        {
            UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                     delegate:self
                                                            cancelButtonTitle:@"取消"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"拍照", @"从相册中选取", nil];
            [choiceSheet showInView:self.view];
        }
        else
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
    }
    else
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
