//
//  LQServiceDetailVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQServiceDetailVC.h"
#import "RootTBC.h"
#import "LQModelUser.h"
#import "LQModelPoint.h"

@interface LQServiceDetailVC ()

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *lianXiRenLabel;
@property (nonatomic, weak) UILabel *lianXiFangShiLabel;
@property (nonatomic, weak) UILabel *pingPaiLabel;
@property (nonatomic, weak) UILabel *fanWeiLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UIImageView *serviceImageView;

@end

@implementation LQServiceDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawView];
    [self request];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [(RootTBC *)ZPRootViewController setTabBarHidden:YES
                                            animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [(RootTBC *)ZPRootViewController setTabBarHidden:NO
                                            animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawView
{
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    scrollview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollview];
    
    UIImageView *serviceImageView = [[UIImageView alloc] init];
    serviceImageView.image = [UIImage imageNamed:@"service_head"];
    [scrollview addSubview:serviceImageView];
    self.serviceImageView = serviceImageView;
    
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"service_black_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(didBack) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:backBtn];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:18];
    nameLabel.textColor = [UIColor blackColor];
    //    nameLabel.text = @"网点联系人：";
    [scrollview addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_LightGray;
    [scrollview addSubview:lineView];
    
    UILabel *lianXiRenLabel = [[UILabel alloc] init];
    lianXiRenLabel.font = [UIFont systemFontOfSize:15];
    lianXiRenLabel.textColor = [UIColor lightGrayColor];
    lianXiRenLabel.text = @"网点联系人：";
    [scrollview addSubview:lianXiRenLabel];
    self.lianXiRenLabel = lianXiRenLabel;
    
    UILabel *lianXiFangShiLabel = [[UILabel alloc] init];
    lianXiFangShiLabel.font = [UIFont systemFontOfSize:15];
    lianXiFangShiLabel.textColor = [UIColor lightGrayColor];
    lianXiFangShiLabel.text = @"联系方式：";
    [scrollview addSubview:lianXiFangShiLabel];
    self.lianXiFangShiLabel = lianXiFangShiLabel;
    
    UILabel *pingPaiLabel = [[UILabel alloc] init];
    pingPaiLabel.font = [UIFont systemFontOfSize:15];
    pingPaiLabel.textColor = [UIColor lightGrayColor];
    pingPaiLabel.text = @"经营品牌：";
    [scrollview addSubview:pingPaiLabel];
    self.pingPaiLabel = pingPaiLabel;
    
    UILabel *fanWeiLabel = [[UILabel alloc] init];
    fanWeiLabel.font = [UIFont systemFontOfSize:15];
    fanWeiLabel.textColor = [UIColor lightGrayColor];
    fanWeiLabel.text = @"救援范围：";
    [scrollview addSubview:fanWeiLabel];
    self.fanWeiLabel = fanWeiLabel;
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.textColor = [UIColor lightGrayColor];
    priceLabel.text = @"救援价格：";
    [scrollview addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    scrollview.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,-20)
    .bottomSpaceToView(self.view,0);
    
    backBtn.sd_layout
    .leftSpaceToView(scrollview,10)
    .widthIs(20)
    .topSpaceToView(scrollview,25)
    .heightIs(20);
    
    serviceImageView.sd_layout
    .leftSpaceToView(scrollview,0)
    .rightSpaceToView(scrollview,0)
    .topSpaceToView(scrollview,0)
    .heightIs(200);
    
    nameLabel.sd_layout
    .leftSpaceToView(scrollview,10)
    .rightSpaceToView(scrollview,10)
    .topSpaceToView(serviceImageView,0)
    .heightIs(40);
    
    lineView.sd_layout
    .leftSpaceToView(scrollview,0)
    .rightSpaceToView(scrollview,0)
    .topSpaceToView(nameLabel,0)
    .heightIs(1);
    
    lianXiRenLabel.sd_layout
    .leftSpaceToView(scrollview,10)
    .rightSpaceToView(scrollview,10)
    .topSpaceToView(lineView,5)
    .heightIs(20);
    
    lianXiFangShiLabel.sd_layout
    .leftSpaceToView(scrollview,10)
    .rightSpaceToView(scrollview,10)
    .topSpaceToView(lianXiRenLabel,5)
    .heightIs(20);
    
    pingPaiLabel.sd_layout
    .leftSpaceToView(scrollview,10)
    .rightSpaceToView(scrollview,10)
    .topSpaceToView(lianXiFangShiLabel,5)
    .heightIs(20);
    
    fanWeiLabel.sd_layout
    .leftSpaceToView(scrollview,10)
    .rightSpaceToView(scrollview,10)
    .topSpaceToView(pingPaiLabel,5)
    .heightIs(20);
    
    priceLabel.sd_layout
    .leftSpaceToView(scrollview,10)
    .rightSpaceToView(scrollview,10)
    .topSpaceToView(fanWeiLabel,5)
    .heightIs(20);
    
    [scrollview setupAutoContentSizeWithBottomView:priceLabel bottomMargin:10];
}

- (void)didBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark ================= 网络请求 =================
- (void)request
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.serviewID forKey:@"id"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [ZPHTTP wPost:@"/app/sys/user/getUserById" parameters:params success:^(id responseObject) {
        
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            LQModelUser *user = [LQModelUser mj_objectWithKeyValues:[[responseObject valueForKey:@"data"] valueForKey:@"user"]];
            self.nameLabel.text = user.point.name;
            self.lianXiRenLabel.text = [NSString stringWithFormat: @"网点联系人：%@",user.point.contact];
            self.lianXiFangShiLabel.text = [NSString stringWithFormat: @"联系方式：%@",user.point.phone];
            self.pingPaiLabel.text = [NSString stringWithFormat: @"经营品牌：%@",user.point.brand];
            self.fanWeiLabel.text = [NSString stringWithFormat: @"救援范围：%@",user.point.scope];
            self.priceLabel.text = [NSString stringWithFormat: @"救援价格：%@",user.point.charge];
            [self.serviceImageView sd_setImageWithURL:[NSURL URLWithString:user.point.freightPrice] placeholderImage:[UIImage imageNamed:@"service_head"]];
            
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
        [MBProgressHUD hideHUDForView:Window animated:YES];
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
        [MBProgressHUD hideHUDForView:Window animated:YES];
    }];
}

@end
