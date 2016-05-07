//
//  LQInsuranceVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/28.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQInsuranceVC.h"
#import "ModelInsurance.h"
#import "RootTBC.h"
#import "LoginVC.h"
#import "LQInsuranceSuccessVC.h"
#import "LQInsuranceJieShaoVC.h"
#import "PhotoCollectionViewCell.h"
#import "MLPhotoBrowserViewController.h"

@interface LQInsuranceVC ()<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,MLPhotoBrowserViewControllerDataSource,MLPhotoBrowserViewControllerDelegate>

@property (nonatomic, strong) ModelInsurance *modelInsurance;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIWebView *web;
@property (nonatomic, weak) UITextView *problemDescription_placehodeTextView;
@property (nonatomic, weak) UITextView *problemDescriptionTextView;
@property (nonatomic, strong) NSMutableArray *photoArray;
@property (nonatomic, weak) UICollectionView *photoCollectionView;

@end

@implementation LQInsuranceVC

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
    
    self.navigationItem.title = @"保险";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self requestgetMonoline];
    
    [self drawView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    [(RootTBC *)ZPRootViewController setTabBarHidden:YES
                                            animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = false;
    [IQKeyboardManager sharedManager].enableAutoToolbar = false;
}

- (void)drawView
{
    UIView *insuranceIntroduceView = [[UIView alloc] init];
    insuranceIntroduceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:insuranceIntroduceView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"保险优势";
    [insuranceIntroduceView addSubview:titleLabel];
    
    UIButton *introduceBtn = [[UIButton alloc] init];
    [introduceBtn setImage:[UIImage imageNamed:@"ic_advantage"] forState:UIControlStateNormal];
    [introduceBtn addTarget:self action:@selector(gotoJieShaoVC) forControlEvents:UIControlEventTouchUpInside];
    [insuranceIntroduceView addSubview:introduceBtn];
    
    UIWebView *web = [[UIWebView alloc] init];
    web.backgroundColor = [UIColor whiteColor];
    web.scrollView.showsVerticalScrollIndicator = NO;
    web.scrollView.showsHorizontalScrollIndicator =NO;
    [insuranceIntroduceView addSubview:web];
    self.web = web;
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = COLOR_LightGray;
    [self.view addSubview:lineView1];
    
    insuranceIntroduceView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(150);
    
    titleLabel.sd_layout
    .leftSpaceToView(insuranceIntroduceView,15)
    .topSpaceToView(insuranceIntroduceView,15)
    .widthIs(80)
    .autoHeightRatio(0);
    
    introduceBtn.sd_layout
    .rightSpaceToView(insuranceIntroduceView,15)
    .topSpaceToView(insuranceIntroduceView,15)
    .widthIs(80)
    .heightRatioToView(titleLabel,1);
    
    web.sd_layout
    .topSpaceToView(titleLabel,10)
    .leftSpaceToView(insuranceIntroduceView,15)
    .rightSpaceToView(insuranceIntroduceView,15)
    .heightIs(100);
    
    lineView1.sd_layout
    .topSpaceToView(insuranceIntroduceView,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(5);
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
//    scrollView.backgroundColor = [UIColor redColor];
    scrollView.contentSize = CGSizeMake(kScreenWidth, 450);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIButton *commitBtn = [[UIButton alloc] init];
    [commitBtn setBackgroundColor:[UIColor redColor]];
    [commitBtn setTitle:@"立即申请" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [commitBtn addTarget:self action:@selector(requestsaveInsurance) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
    
    commitBtn.sd_layout
    .bottomSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(40);
    
    scrollView.sd_layout
    .topSpaceToView(lineView1,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(commitBtn,0);
    
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    titleLabel2.font = [UIFont systemFontOfSize:16];
    titleLabel2.textColor = [UIColor blackColor];
    titleLabel2.text = @"险种选择";
    [scrollView addSubview:titleLabel2];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = COLOR_LightGray;
    [scrollView addSubview:lineView2];
    
    titleLabel2.sd_layout
    .leftSpaceToView(scrollView,15)
    .topSpaceToView(scrollView,15)
    .widthIs(80)
    .autoHeightRatio(0);
    
    lineView2.sd_layout
    .topSpaceToView(titleLabel2,15)
    .leftSpaceToView(scrollView,0)
    .rightSpaceToView(scrollView,0)
    .heightIs(1);
    
    UIButton *zeRenXianBtn = [[UIButton alloc] init];
    [zeRenXianBtn setTitle:@"第三方责任险" forState:UIControlStateNormal];
    [zeRenXianBtn setTitle:@"第三方责任险" forState:UIControlStateSelected];
    [zeRenXianBtn setImage:[UIImage imageNamed:@"ic_checkbox-nml"] forState:UIControlStateNormal];
    [zeRenXianBtn setImage:[UIImage imageNamed:@"ic_checkbox-click"] forState:UIControlStateSelected];
    [zeRenXianBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [zeRenXianBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    zeRenXianBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    zeRenXianBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [zeRenXianBtn addTarget:self action:@selector(didClickZenRenXian:) forControlEvents:UIControlEventTouchUpInside];
    zeRenXianBtn.tag = 1000;
    [scrollView addSubview:zeRenXianBtn];
    
    zeRenXianBtn.sd_layout
    .topSpaceToView(lineView2,15)
    .leftSpaceToView(scrollView,15)
    .widthIs(90)
    .heightIs(25);
    
    UIButton *zeRenXian_20 = [[UIButton alloc] init];
//    zeRenXian_20.backgroundColor = [UIColor redColor];
    [zeRenXian_20 setTitle:@"【20万】" forState:UIControlStateNormal];
    [zeRenXian_20 setTitle:@"【20万】" forState:UIControlStateSelected];
    [zeRenXian_20 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [zeRenXian_20 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    zeRenXian_20.titleLabel.font = [UIFont systemFontOfSize:12];
    [zeRenXian_20 addTarget:self action:@selector(didClickZenRenXianMoney:) forControlEvents:UIControlEventTouchUpInside];
    zeRenXian_20.tag = 20;
//    zeRenXian_20.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [scrollView addSubview:zeRenXian_20];
    
    UIButton *zeRenXian_30 = [[UIButton alloc] init];
//    zeRenXian_30.backgroundColor = [UIColor redColor];
    [zeRenXian_30 setTitle:@"【30万】" forState:UIControlStateNormal];
    [zeRenXian_30 setTitle:@"【30万】" forState:UIControlStateSelected];
    [zeRenXian_30 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [zeRenXian_30 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    zeRenXian_30.titleLabel.font = [UIFont systemFontOfSize:12];
    [zeRenXian_30 addTarget:self action:@selector(didClickZenRenXianMoney:) forControlEvents:UIControlEventTouchUpInside];
    zeRenXian_30.tag = 30;
//    zeRenXian_30.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [scrollView addSubview:zeRenXian_30];
    
    UIButton *zeRenXian_50 = [[UIButton alloc] init];
//    zeRenXian_50.backgroundColor = [UIColor redColor];
    [zeRenXian_50 setTitle:@"【50万】" forState:UIControlStateNormal];
    [zeRenXian_50 setTitle:@"【50万】" forState:UIControlStateSelected];
    [zeRenXian_50 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [zeRenXian_50 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    zeRenXian_50.titleLabel.font = [UIFont systemFontOfSize:12];
    [zeRenXian_50 addTarget:self action:@selector(didClickZenRenXianMoney:) forControlEvents:UIControlEventTouchUpInside];
    zeRenXian_50.tag = 50;
    //    zeRenXian_30.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [scrollView addSubview:zeRenXian_50];
    
    UIButton *zeRenXian_100 = [[UIButton alloc] init];
//    zeRenXian_100.backgroundColor = [UIColor redColor];
    [zeRenXian_100 setTitle:@"【100万】" forState:UIControlStateNormal];
    [zeRenXian_100 setTitle:@"【100万】" forState:UIControlStateSelected];
    [zeRenXian_100 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [zeRenXian_100 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    zeRenXian_100.titleLabel.font = [UIFont systemFontOfSize:12];
    [zeRenXian_100 addTarget:self action:@selector(didClickZenRenXianMoney:) forControlEvents:UIControlEventTouchUpInside];
    zeRenXian_100.tag = 100;
    //    zeRenXian_30.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [scrollView addSubview:zeRenXian_100];
    
    zeRenXian_20.selected = YES;
    
    zeRenXian_20.sd_layout
    .topEqualToView(zeRenXianBtn)
    .leftSpaceToView(zeRenXianBtn,0)
    .widthIs(55)
    .heightRatioToView(zeRenXianBtn,1);
    
    zeRenXian_30.sd_layout
    .topEqualToView(zeRenXianBtn)
    .leftSpaceToView(zeRenXian_20,-5)
    .widthIs(55)
    .heightRatioToView(zeRenXianBtn,1);
    
    zeRenXian_50.sd_layout
    .topEqualToView(zeRenXianBtn)
    .leftSpaceToView(zeRenXian_30,-5)
    .widthIs(55)
    .heightRatioToView(zeRenXianBtn,1);
    
    zeRenXian_100.sd_layout
    .topEqualToView(zeRenXianBtn)
    .leftSpaceToView(zeRenXian_50,-5)
    .widthIs(60)
    .heightRatioToView(zeRenXianBtn,1);
    
}

- (void)drawXianZhongBtn
{
    int m = 1;
    for (NSString *str in self.modelInsurance.monolineList)
    {
        UIButton *zeRenXianBtn = [[UIButton alloc] init];
        [zeRenXianBtn setTitle:str forState:UIControlStateNormal];
        [zeRenXianBtn setTitle:str forState:UIControlStateSelected];
        [zeRenXianBtn setImage:[UIImage imageNamed:@"ic_checkbox-nml"] forState:UIControlStateNormal];
        [zeRenXianBtn setImage:[UIImage imageNamed:@"ic_checkbox-click"] forState:UIControlStateSelected];
        [zeRenXianBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [zeRenXianBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        zeRenXianBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        zeRenXianBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [zeRenXianBtn addTarget:self action:@selector(didClickZenRenXian:) forControlEvents:UIControlEventTouchUpInside];
        zeRenXianBtn.tag = 1000 + m;
        [self.scrollView addSubview:zeRenXianBtn];
        
        switch (m)
        {
            case 1:
            {
                UIButton *btn = [self.view viewWithTag:1000];
                
                zeRenXianBtn.sd_layout
                .topSpaceToView(btn,15)
                .leftEqualToView(btn)
                .widthIs(((kScreenWidth-30)/3))
                .heightIs(30);
            }
                break;
            case 2:
            case 3:
            {
                UIButton *btn = [self.view viewWithTag:1000];
                UIButton *btn2 = [self.view viewWithTag:zeRenXianBtn.tag - 1];
                zeRenXianBtn.sd_layout
                .topSpaceToView(btn,15)
                .leftSpaceToView(btn2,10)
                .widthIs(((kScreenWidth-30)/3))
                .heightIs(30);
            }
                break;
            case 4:
            {
                UIButton *btn = [self.view viewWithTag:1001];
                zeRenXianBtn.sd_layout
                .topSpaceToView(btn,15)
                .leftEqualToView(btn)
                .widthIs(((kScreenWidth-30)/3))
                .heightIs(30);
                
            }
                break;
            case 5:
            case 6:
            {
                UIButton *btn = [self.view viewWithTag:1001];
                UIButton *btn2 = [self.view viewWithTag:zeRenXianBtn.tag - 1];
                zeRenXianBtn.sd_layout
                .topSpaceToView(btn,15)
                .leftSpaceToView(btn2,10)
                .widthIs(((kScreenWidth-30)/3))
                .heightIs(30);
                
            }
                break;
            case 7:
            {
                UIButton *btn = [self.view viewWithTag:1004];
                zeRenXianBtn.sd_layout
                .topSpaceToView(btn,15)
                .leftEqualToView(btn)
                .widthIs(((kScreenWidth-30)/3))
                .heightIs(30);
                
            }
                break;
            case 8:
            case 9:
            {
                UIButton *btn = [self.view viewWithTag:1004];
                UIButton *btn2 = [self.view viewWithTag:zeRenXianBtn.tag - 1];
                zeRenXianBtn.sd_layout
                .topSpaceToView(btn,15)
                .leftSpaceToView(btn2,10)
                .widthIs(((kScreenWidth-30)/3))
                .heightIs(30);
                
            }
                break;
            case 10:
            {
                UIButton *btn = [self.view viewWithTag:1007];
                zeRenXianBtn.sd_layout
                .topSpaceToView(btn,15)
                .leftEqualToView(btn)
                .widthIs(((kScreenWidth-30)/3))
                .heightIs(30);
                
            }
                break;
            case 11:
            case 12:
            {
                UIButton *btn = [self.view viewWithTag:1007];
                UIButton *btn2 = [self.view viewWithTag:zeRenXianBtn.tag - 1];
                zeRenXianBtn.sd_layout
                .topSpaceToView(btn,15)
                .leftSpaceToView(btn2,0)
                .widthIs(((kScreenWidth-30)/3))
                .heightIs(30);
                
            }
                break;
                
            default:
                break;
        }
        
        m ++;
    }
    
    UIButton *btn = [self.view viewWithTag:1000+self.modelInsurance.monolineList.count];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = COLOR_LightGray;
    [self.scrollView addSubview:lineView2];
    
    lineView2.sd_layout
    .topSpaceToView(btn,15)
    .leftSpaceToView(self.scrollView,0)
    .rightSpaceToView(self.scrollView,0)
    .heightIs(5);
    
    UITextView *problemDescription_placehodeTextView = [[UITextView alloc] init];
    //    problemDescription_placehodeTextView.backgroundColor = [UIColor lightGrayColor];
    problemDescription_placehodeTextView.text = @"行驶证必须主页和附页分别上传，共两张，保证清晰度，谢谢配合";
    problemDescription_placehodeTextView.editable = NO;
    problemDescription_placehodeTextView.textColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:problemDescription_placehodeTextView];
    self.problemDescription_placehodeTextView = problemDescription_placehodeTextView;
    
    UITextView *problemDescriptionTextView = [[UITextView alloc] init];
    //    problemDescriptionTextView.backgroundColor = [UIColor grayColor];
    problemDescriptionTextView.delegate = self;
    problemDescriptionTextView.textColor = [UIColor blackColor];
    problemDescriptionTextView.backgroundColor = [UIColor clearColor];
    problemDescriptionTextView.layer.borderWidth = 1;
    problemDescriptionTextView.layer.borderColor = COLOR_LightGray.CGColor;
    [self.scrollView addSubview:problemDescriptionTextView];
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
    [self.scrollView addSubview:photoCollectionView];
    self.photoCollectionView = photoCollectionView;
    
    
    problemDescription_placehodeTextView.sd_layout
    .topSpaceToView(lineView2,15)
    .leftSpaceToView(self.scrollView,15)
    .rightSpaceToView(self.scrollView,15)
    .heightIs(100);
    
    problemDescriptionTextView.sd_layout
    .topSpaceToView(lineView2,15)
    .leftSpaceToView(self.scrollView,15)
    .rightSpaceToView(self.scrollView,15)
    .heightIs(100);
    
    self.photoCollectionView.sd_layout
    .topSpaceToView(problemDescriptionTextView,5)
    .leftEqualToView(problemDescriptionTextView)
    .rightEqualToView(problemDescriptionTextView)
    .heightIs(100);
    
//    [self.scrollView setupAutoContentSizeWithBottomView:addPicture1 bottomMargin:15];
}

- (void)addPicture:(UIButton *)btn
{
    
    UIButton *btn1 = [self.view viewWithTag:2000];
    UIButton *btn2 = [self.view viewWithTag:2001];
    
    btn1.selected = NO;
    btn2.selected = NO;
    btn.selected = YES;
    
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}


- (void)didClickZenRenXian:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
}

- (void)didClickZenRenXianMoney:(UIButton *)btn
{
    UIButton *btn20 = [self.view viewWithTag:20];
    UIButton *btn30 = [self.view viewWithTag:30];
    UIButton *btn50 = [self.view viewWithTag:50];
    UIButton *btn100 = [self.view viewWithTag:100];
    
    btn20.selected = NO;
    btn30.selected = NO;
    btn50.selected = NO;
    btn100.selected = NO;
    
    btn.selected = true;
}

- (void)gotoJieShaoVC
{
    LQInsuranceJieShaoVC *vc = [[LQInsuranceJieShaoVC alloc] init];
    vc.urlStr = self.modelInsurance.renbaoUrl;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark ================= 网络请求 =================
- (void)requestgetMonoline
{
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:@"" animated:YES];
    [ZPHTTP wPost:@"/app/prd/insurance/getMonoline" parameters:nil success:^(id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            self.modelInsurance = [ModelInsurance mj_objectWithKeyValues:[responseObject valueForKey:@"data"]];
            
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.modelInsurance.insuranceUrl]];
            [self.web loadRequest:request];
            [self drawXianZhongBtn];
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

- (void)requestsaveInsurance
{
    if (self.photoArray.count != 2)
    {
        kMRCError(@"行驶证必须主页和附页分别上传，共两张，保证清晰度，谢谢配合");
        return;
    }
    
    NSString *monoline = @"";
    
    UIButton *zenRenXianBtn = [self.view viewWithTag:1000];
    if (zenRenXianBtn.selected)
    {
        UIButton *zenRenXianBtn20 = [self.view viewWithTag:20];
        UIButton *zenRenXianBtn30 = [self.view viewWithTag:30];
        UIButton *zenRenXianBtn50 = [self.view viewWithTag:50];
        UIButton *zenRenXianBtn100 = [self.view viewWithTag:100];
        
        if (zenRenXianBtn20.selected)
        {
           monoline = [monoline stringByAppendingString:@"第三责任险[20万],"];
        }
        else if (zenRenXianBtn30.selected)
        {
            monoline = [monoline stringByAppendingString:@"第三责任险[30万]，"];
        }
        else if (zenRenXianBtn50.selected)
        {
            monoline = [monoline stringByAppendingString:@"第三责任险[50万],"];
        }
        else if (zenRenXianBtn100.selected)
        {
            monoline = [monoline stringByAppendingString:@"第三责任险[100万],"];
        }
        
    }
    
    for (int i = 1; i <= self.modelInsurance.monolineList.count; i++)
    {
        UIButton *btn = [self.view viewWithTag:1000+i];
        
        if (btn.selected)
        {
            monoline = [monoline stringByAppendingString:[NSString stringWithFormat:@"%@,",btn.titleLabel.text]];
        }
    }
    
    if (!monoline.length)
    {
        kMRCError(@"请选择一个险种");
        return;
    }
    
    monoline = [monoline stringByReplacingCharactersInRange:NSMakeRange(monoline.length-1, 1) withString:@""];
    NSLog(@"------>%@",monoline);
    
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:@"" animated:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:monoline forKey:@"monoline"];
    [params setValue:self.problemDescriptionTextView.text forKey:@"description"];
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
    
    [ZPHTTP LQPost:@"http://113.31.29.235:8080/chicheng/app/prd/insurance/saveInsurance" parameters:params fileInfo:files success:^(NSDictionary *object) {
        NSLog(@"**%@",object);
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
        
        if ([object[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            LQInsuranceSuccessVC *vc = [[LQInsuranceSuccessVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
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
        kMRCError(error.localizedDescription);
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
    
    if (self.photoArray.count<2)
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
    else if (self.photoArray.count<2)
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
