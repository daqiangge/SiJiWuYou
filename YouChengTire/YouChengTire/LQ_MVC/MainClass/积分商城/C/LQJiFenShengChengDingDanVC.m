//
//  LQJiFenShengChengDingDanVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQJiFenShengChengDingDanVC.h"
#import "ReceiptAddressVC.h"
#import "ReceiptAddressM.h"

@interface LQJiFenShengChengDingDanVC ()<UITextFieldDelegate>

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *shangChangJiaLabel;
@property (nonatomic, weak) UILabel *xianJiFenLabel;
@property (nonatomic, weak) UILabel *yuanJiFenLabel;
@property (nonatomic, weak) UIImageView *shangPingImagView;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *phoneNumLabel;
@property (nonatomic, weak) UILabel *addressLabel;
@property (nonatomic, strong) ReceiptAddressItemM *addressModel;

@end

@implementation LQJiFenShengChengDingDanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"生成订单";
    
    self.view.backgroundColor = COLOR_LightGray;
    
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawView
{
    UIView *shangPingBackgroundView = [[UIView alloc] init];
    shangPingBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shangPingBackgroundView];
    
    UIImageView *shangPingImagView = [[UIImageView alloc] init];
    [shangPingBackgroundView addSubview:shangPingImagView];
    [shangPingImagView sd_setImageWithURL:[NSURL URLWithString:self.model.appPhoto] placeholderImage:[UIImage imageNamed:@"ic_service_logo"]];
    self.shangPingImagView = shangPingImagView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = self.model.name;
    [shangPingBackgroundView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *shangChangJiaLabel = [[UILabel alloc] init];
    shangChangJiaLabel.textColor = [UIColor lightGrayColor];
    shangChangJiaLabel.font = [UIFont systemFontOfSize:12];
    shangChangJiaLabel.text = [NSString stringWithFormat:@"市场价：￥%@",self.model.marketPrice];
    shangChangJiaLabel.hidden = !self.model.marketPrice.length;
    [shangPingBackgroundView addSubview:shangChangJiaLabel];
    self.shangChangJiaLabel = shangChangJiaLabel;
    
    UILabel *xianJiFenLabel = [[UILabel alloc] init];
    xianJiFenLabel.textColor = [UIColor redColor];
    xianJiFenLabel.font = [UIFont systemFontOfSize:12];
    xianJiFenLabel.text = [NSString stringWithFormat:@"现%ld积分",self.model.price];
    [shangPingBackgroundView addSubview:xianJiFenLabel];
    self.xianJiFenLabel = xianJiFenLabel;
    
    UILabel *yuanJiFenLabel = [[UILabel alloc] init];
    yuanJiFenLabel.textColor = [UIColor lightGrayColor];
    yuanJiFenLabel.font = [UIFont systemFontOfSize:12];
//    yuanJiFenLabel.text = [NSString stringWithFormat:@"原%@积分",self.model.oldPrice];
    [shangPingBackgroundView addSubview:yuanJiFenLabel];
    self.yuanJiFenLabel = yuanJiFenLabel;
    NSDictionary *dic = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],
                          NSFontAttributeName:[UIFont systemFontOfSize:12],
                          NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    NSString *str = [NSString stringWithFormat:@"原%@积分",self.model.oldPrice];
    NSMutableAttributedString *oldPriceAtt = [[NSMutableAttributedString alloc] initWithString:str attributes:dic];
    yuanJiFenLabel.attributedText = oldPriceAtt;
    
    UITextField *textField = [[UITextField alloc] init];
    textField.text = @"1";
    textField.font = [UIFont systemFontOfSize:12];
    textField.layer.borderColor = COLOR_LightGray.CGColor;
    textField.layer.borderWidth = 0.5;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.delegate = self;
    [shangPingBackgroundView addSubview:textField];
    self.textField = textField;
    
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [addBtn setImage:[UIImage imageNamed:@"mall_plus"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(plus) forControlEvents:UIControlEventTouchUpInside];
    textField.rightView = addBtn;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    UIButton *jianBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [jianBtn setImage:[UIImage imageNamed:@"mall_reduce"] forState:UIControlStateNormal];
    [jianBtn addTarget:self action:@selector(reduce) forControlEvents:UIControlEventTouchUpInside];
    textField.leftView = jianBtn;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *addressBackgroundView = [[UIView alloc] init];
    [self.view addSubview:addressBackgroundView];
    
    UIImageView *addressBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mall_order_cell_bg"]];
    [addressBackgroundView addSubview:addressBackgroundImageView];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"mall_order_cell_logo"];
    [addressBackgroundView addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor lightGrayColor];
//        nameLabel.text = @"张三";
    nameLabel.font = [UIFont systemFontOfSize:15];
    [addressBackgroundView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *phoneNumLabel = [[UILabel alloc] init];
    phoneNumLabel.textColor = [UIColor lightGrayColor];
//        phoneNumLabel.text = @"12345678909";
    phoneNumLabel.font = [UIFont systemFontOfSize:15];
    [addressBackgroundView addSubview:phoneNumLabel];
    self.phoneNumLabel = phoneNumLabel;
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.textColor = [UIColor lightGrayColor];
//        addressLabel.text = @"撒打算打算打算打算打算的飒飒大发发发无人玩儿玩儿额外热温热污染为人";
    addressLabel.font = [UIFont systemFontOfSize:15];
    [addressBackgroundView addSubview:addressLabel];
    self.addressLabel = addressLabel;
    
    UIButton *shengChengDingDanBtn = [[UIButton alloc] init];
    [shengChengDingDanBtn setTitle:@"生成订单" forState:UIControlStateNormal];
    [shengChengDingDanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    shengChengDingDanBtn.backgroundColor = [UIColor redColor];
    shengChengDingDanBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [shengChengDingDanBtn addTarget:self action:@selector(shengChengDingDan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shengChengDingDanBtn];
    
    
    shangPingBackgroundView.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(100);
    
    shangPingImagView.sd_layout
    .topSpaceToView(shangPingBackgroundView,10)
    .leftSpaceToView(shangPingBackgroundView,10)
    .widthIs(80)
    .heightEqualToWidth();
    
    titleLabel.sd_layout
    .topSpaceToView(shangPingBackgroundView,10)
    .leftSpaceToView(shangPingImagView,10)
    .rightSpaceToView(shangPingBackgroundView,10)
    .autoHeightRatio(0);
    [titleLabel setMaxNumberOfLinesToShow:2];
    
    xianJiFenLabel.sd_layout
    .leftSpaceToView(shangPingImagView,10)
    .bottomSpaceToView(shangPingBackgroundView,10)
    .heightIs(15);
    [xianJiFenLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    yuanJiFenLabel.sd_layout
    .leftSpaceToView(xianJiFenLabel,5)
    .bottomSpaceToView(shangPingBackgroundView,10)
    .heightIs(15);
    [yuanJiFenLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    shangChangJiaLabel.sd_layout
    .leftSpaceToView(shangPingImagView,10)
    .bottomSpaceToView(xianJiFenLabel,5)
    .heightIs(15);
    [shangChangJiaLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    textField.sd_layout
    .rightSpaceToView(shangPingBackgroundView,10)
    .bottomSpaceToView(shangPingBackgroundView,30)
    .heightIs(20)
    .widthIs(80);
    
    addressBackgroundView.sd_layout
    .topSpaceToView(shangPingBackgroundView,10)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0);
    
    addressBackgroundImageView.sd_layout
    .topSpaceToView(addressBackgroundView,0)
    .leftSpaceToView(addressBackgroundView,0)
    .rightSpaceToView(addressBackgroundView,0)
    .bottomSpaceToView(addressBackgroundView,0);
    
    imageView.sd_layout
    .widthIs(25)
    .heightIs(25)
    .leftSpaceToView(addressBackgroundView,15)
    .topSpaceToView(addressBackgroundView,15);
    
    nameLabel.sd_layout
    .topSpaceToView(addressBackgroundView,5)
    .leftSpaceToView(imageView,10)
    .heightIs(20)
    .widthIs(100);
    
    phoneNumLabel.sd_layout
    .topSpaceToView(addressBackgroundView,5)
    .leftSpaceToView(nameLabel,10)
    .heightIs(20)
    .widthIs(150);
    
    addressLabel.sd_layout
    .topSpaceToView(nameLabel,5)
    .leftSpaceToView(imageView,10)
    .rightSpaceToView(addressBackgroundView,15)
    .autoHeightRatio(0);
    
    shengChengDingDanBtn.sd_layout
    .bottomSpaceToView(self.view,15)
    .leftSpaceToView(self.view,15)
    .rightSpaceToView(self.view,15)
    .heightIs(40);
    
    [addressBackgroundView setupAutoHeightWithBottomViewsArray:@[imageView,addressLabel] bottomMargin:15];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setAddress)];
    [addressBackgroundView addGestureRecognizer:tap];
    
}

- (void)plus
{
    int i = [self.textField.text intValue];
    i++;
    NSLog(@"---->%d",i);
    self.textField.text = [NSString stringWithFormat:@"%d",i];
}

- (void)reduce
{
    int i = [self.textField.text intValue];
    if (i == 1) {
        return;
    }
    self.textField.text = [NSString stringWithFormat:@"%d",i-1];
}

- (void)setAddress
{
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
    ReceiptAddressVC *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ReceiptAddressVC"];
    vc.isFromLQOrderClaimsVC = YES;
    [self.navigationController pushViewController:vc animated:YES];

    __weak typeof(self) weakSelf = self;
    vc.selectAddress = ^(ReceiptAddressItemM *model){
        weakSelf.addressModel = model;
        weakSelf.nameLabel.text = model.name;
        weakSelf.phoneNumLabel.text = model.mobile;
        weakSelf.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.county,model.detail];
    };
}

- (void)shengChengDingDan
{
    if (!self.addressModel)
    {
        kMRCError(@"请选择收货地址");
        return;
    }
    
    [MBProgressHUD showLoadingHUDAddedToWindowWithTipStr:@"" animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.model._id forKey:@"giftId"];
    [params setValue:self.textField.text forKey:@"count"];
    [params setValue:self.addressModel.sId forKey:@"addressId"];
    [params setValue:[BaseVM createAppKey:params] forKey:@"appKey"];
    
    [ZPHTTP wPost:@"/app/prd/gift/saveOrder" parameters:params success:^(id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:Window animated:YES];
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            kMRCSuccess(@"订单生成成功");
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
#pragma mark ================= UITextFieldDelegate =================
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *toBeStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    return [self isPureInt:toBeStr];
}

- (BOOL)isPureInt:(NSString*)string
{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}

@end
