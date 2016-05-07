//
//  LQFaHuoDetailVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQFaHuoDetailVC.h"
#import "LQFahuoCell1.h"
#import "PhotoCollectionViewCell.h"
#import "MLPhotoBrowserViewController.h"
#import "LQModelGoods.h"
#import "LQModelPicture.h"


@interface LQFaHuoDetailVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MLPhotoBrowserViewControllerDataSource,MLPhotoBrowserViewControllerDelegate>

/**
 *  描述
 */
@property (nonatomic, weak) UITextView *problemDescriptionTextView;
@property (nonatomic, weak) UICollectionView *photoCollectionView;
@property (nonatomic, strong) NSMutableArray *photoArray;
@property (nonatomic, weak) MLPhotoBrowserViewController *photoBrowser;
@property (nonatomic, strong) LQModelGoods *model;


@end

@implementation LQFaHuoDetailVC

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
    
    self.title = @"货源详情";
    
    [self request];
}

- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [self drawFooterView];
    [self.view addSubview:tableView];
    
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight - 64-40, kScreenWidth, 40)];
    [deleteBtn setTitle:@"删除货源" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    deleteBtn.backgroundColor = [UIColor redColor];
    [deleteBtn addTarget:self action:@selector(deleteHuoYuan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
    
    
    UserM *userM = [UserM getUserM];
    if (userM)
    {
        if ([@"1" isEqualToString:userM.userDetailsM.userType]
            || [@"2" isEqualToString:userM.userDetailsM.userType])
        {
            deleteBtn.hidden = YES;
        }
        else
        {
            deleteBtn.hidden = self.model.status == 0?YES:NO;
        }
    }
}

- (UIView *)drawFooterView
{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 420)];
    footView.backgroundColor = [UIColor whiteColor];
    
    UILabel *problemDescriptionLabel = [[UILabel alloc] init];
    problemDescriptionLabel.text = @"货物描述";
    problemDescriptionLabel.font = [UIFont systemFontOfSize:15];
    [footView addSubview:problemDescriptionLabel];
    
    UITextView *problemDescriptionTextView = [[UITextView alloc] init];
    problemDescriptionTextView.delegate = self;
    problemDescriptionTextView.textColor = [UIColor blackColor];
    problemDescriptionTextView.backgroundColor = [UIColor clearColor];
    problemDescriptionTextView.layer.borderWidth = 1;
    problemDescriptionTextView.layer.borderColor = COLOR_LightGray.CGColor;
    problemDescriptionTextView.text = self.model.content;
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
#pragma mark ================= 网络请求 =================
- (void)request
{
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:@"" animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self._id forKey:@"id"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [ZPHTTP wPost:@"/app/prd/goods/getGoods" parameters:params success:^(id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            self.model = [LQModelGoods mj_objectWithKeyValues:[[responseObject valueForKey:@"data"] valueForKey:@"goods"]];
            
            self.photoArray = [NSMutableArray arrayWithArray:[LQModelPicture mj_objectArrayWithKeyValuesArray:[[responseObject valueForKey:@"data"] valueForKey:@"pictureList"]]];
            
            [self drawView];
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
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
    }];
}

- (void)deleteHuoYuan
{
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:@"" animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self._id forKey:@"id"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [ZPHTTP wPost:@"/app/prd/goods/deleteGoods" parameters:params success:^(id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            kMRCSuccess(@"删除成功");
            if (self.deleteGoodsSuccess) {
                self.deleteGoodsSuccess();
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
        kMRCError(error.localizedDescription);
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
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
    cell.textField.textColor = [UIColor grayColor];
    switch (indexPath.row)
    {
        case 0:
        {
            cell.titleLabel.text = @"货源名称";
            cell.textField.text = self.model.name;
        }
            break;
        case 1:
        {
            cell.titleLabel.text = @"始发地";
            cell.textField.text = self.model.startPoint;
        }
            break;
        case 2:
        {
            cell.titleLabel.text = @"目的地";
            cell.textField.text = self.model.endPoint;
        }
            break;
        case 3:
        {
            cell.titleLabel.text = @"联系人";
            cell.textField.text = self.model.contacts;
        }
            break;
        case 4:
        {
            cell.titleLabel.text = @"联系电话";
            cell.textField.text = self.model.mobile;
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
#pragma mark ================= CollectionViewDelegate,UICollectionViewDataSource =================
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"PhotoCollectionViewCell";
    PhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    LQModelPicture *model = self.photoArray[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.appPath] placeholderImage:[UIImage imageNamed:@"me_discount_logo"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 图片游览器
    MLPhotoBrowserViewController *photoBrowser = [[MLPhotoBrowserViewController alloc] init];
    // 缩放动画
    photoBrowser.status = UIViewAnimationAnimationStatusZoom;
    // 可以删除
    photoBrowser.editing = false;
    // 数据源/delegate
    photoBrowser.delegate = self;
    photoBrowser.dataSource = self;
    // 当前选中的值
    photoBrowser.currentIndexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:0];
    // 展示控制器
    [self.navigationController presentViewController:photoBrowser animated:NO completion:nil];
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
    LQModelPicture *model = self.photoArray[indexPath.row];
    MLPhotoBrowserPhoto *photo = [MLPhotoBrowserPhoto photoAnyImageObjWith:model.appPath];
    
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[self.photoCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.row inSection:0]];
    photo.toView = cell.imageView;
    photo.thumbImage = cell.imageView.image;
    return photo;
}


@end
