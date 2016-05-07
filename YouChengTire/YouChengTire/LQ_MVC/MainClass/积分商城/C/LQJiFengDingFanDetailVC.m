//
//  LQJiFengDingFanDetailVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQJiFengDingFanDetailVC.h"
#import "ReceiptAddressM.h"

@interface LQJiFengDingFanDetailVC ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *shangChangJiaLabel;
@property (nonatomic, weak) UILabel *xianJiFenLabel;
@property (nonatomic, weak) UILabel *yuanJiFenLabel;
@property (nonatomic, weak) UIImageView *shangPingImagView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *phoneNumLabel;
@property (nonatomic, weak) UILabel *addressLabel;
@property (nonatomic, weak) UILabel *numLabel;

@end

@implementation LQJiFengDingFanDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"订单详情";
    self.view.backgroundColor = COLOR_LightGray;
    
    if (self.model)
    {
        [self drawView];
    }
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
    shangPingImagView.backgroundColor = [UIColor redColor];
    [shangPingBackgroundView addSubview:shangPingImagView];
    self.shangPingImagView = shangPingImagView;
    [self.shangPingImagView sd_setImageWithURL:[NSURL URLWithString:self.model.gift.appPhoto] placeholderImage:[UIImage imageNamed:@"me_discount_logo"]];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = self.model.gift.name;
    [shangPingBackgroundView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *shangChangJiaLabel = [[UILabel alloc] init];
    shangChangJiaLabel.textColor = [UIColor lightGrayColor];
    shangChangJiaLabel.font = [UIFont systemFontOfSize:12];
    shangChangJiaLabel.text = [NSString stringWithFormat:@"市场价:%@",self.model.gift.marketPrice];
    shangChangJiaLabel.hidden = !self.model.gift.marketPrice.length;
    [shangPingBackgroundView addSubview:shangChangJiaLabel];
    self.shangChangJiaLabel = shangChangJiaLabel;
    
    UILabel *xianJiFenLabel = [[UILabel alloc] init];
    xianJiFenLabel.textColor = [UIColor redColor];
    xianJiFenLabel.font = [UIFont systemFontOfSize:12];
    xianJiFenLabel.text = [NSString stringWithFormat:@"现%ld积分",self.model.gift.price];
    [shangPingBackgroundView addSubview:xianJiFenLabel];
    self.xianJiFenLabel = xianJiFenLabel;
    
    UILabel *yuanJiFenLabel = [[UILabel alloc] init];
    yuanJiFenLabel.textColor = [UIColor lightGrayColor];
    yuanJiFenLabel.font = [UIFont systemFontOfSize:12];
    //    yuanJiFenLabel.text = [NSString stringWithFormat:@"原%@积分",self.model.oldPrice];
    [shangPingBackgroundView addSubview:yuanJiFenLabel];
    yuanJiFenLabel = yuanJiFenLabel;
    NSDictionary *dic = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],
                          NSFontAttributeName:[UIFont systemFontOfSize:12],
                          NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    NSString *str = [NSString stringWithFormat:@"原%@积分",self.model.gift.oldPrice];
    NSMutableAttributedString *oldPriceAtt = [[NSMutableAttributedString alloc] initWithString:str attributes:dic];
    yuanJiFenLabel.attributedText = oldPriceAtt;
    
    
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.textColor = [UIColor lightGrayColor];
    numLabel.font = [UIFont systemFontOfSize:12];
    numLabel.text = [NSString stringWithFormat:@"x%@",self.model.count];
    numLabel.textAlignment = NSTextAlignmentRight;
    [shangPingBackgroundView addSubview:numLabel];
    self.numLabel = numLabel;
    
    
    UIView *addressBackgroundView = [[UIView alloc] init];
    [self.view addSubview:addressBackgroundView];
    
    UIImageView *addressBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mall_order_cell_bg"]];
    [addressBackgroundView addSubview:addressBackgroundImageView];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"mall_order_cell_logo"];
    [addressBackgroundView addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor lightGrayColor];
    nameLabel.text = self.model.address.name;
    nameLabel.font = [UIFont systemFontOfSize:15];
    [addressBackgroundView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *phoneNumLabel = [[UILabel alloc] init];
    phoneNumLabel.textColor = [UIColor lightGrayColor];
    phoneNumLabel.text = self.model.address.mobile;
    phoneNumLabel.font = [UIFont systemFontOfSize:15];
    [addressBackgroundView addSubview:phoneNumLabel];
    self.phoneNumLabel = phoneNumLabel;
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.textColor = [UIColor lightGrayColor];
    addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",self.model.address.province,self.model.address.city,self.model.address.county,self.model.address.detail];
    addressLabel.font = [UIFont systemFontOfSize:15];
    [addressBackgroundView addSubview:addressLabel];
    self.addressLabel = addressLabel;
    
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
    [xianJiFenLabel setSingleLineAutoResizeWithMaxWidth:80];
    
    yuanJiFenLabel.sd_layout
    .leftSpaceToView(xianJiFenLabel,5)
    .bottomSpaceToView(shangPingBackgroundView,10)
    .heightIs(15);
    [yuanJiFenLabel setSingleLineAutoResizeWithMaxWidth:80];
    
    shangChangJiaLabel.sd_layout
    .leftSpaceToView(shangPingImagView,10)
    .bottomSpaceToView(xianJiFenLabel,5)
    .heightIs(15);
    [shangChangJiaLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    numLabel.sd_layout
    .rightSpaceToView(shangPingBackgroundView,10)
    .bottomEqualToView(xianJiFenLabel)
    .leftSpaceToView(yuanJiFenLabel,5)
    .heightIs(15);
    
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
    
    [addressBackgroundView setupAutoHeightWithBottomViewsArray:@[imageView,addressLabel] bottomMargin:15];
    
//----------------------------------------------------------------------------------------------------------
    UIView *stateBKV = [[UIView alloc] init];
    stateBKV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:stateBKV];
    
    UILabel *stateNameLabel = [[UILabel alloc] init];
    stateNameLabel.textColor = [UIColor blackColor];
    stateNameLabel.text = @"订单状态";
    stateNameLabel.font = [UIFont systemFontOfSize:15];
    [stateBKV addSubview:stateNameLabel];
    
    UILabel *stateLabel = [[UILabel alloc] init];
    stateLabel.textColor = [UIColor lightGrayColor];
    stateLabel.text = @"订单状态";
    stateLabel.font = [UIFont systemFontOfSize:15];
    [stateBKV addSubview:stateLabel];
    
    
    switch ([self.model.status intValue]) {
        case 0:
        {
            stateLabel.text = @"待发货";
        }
            break;
        case 1:
        {
            stateLabel.text = @"待发货";
        }
            break;
        case 2:
        {
            stateLabel.text = @"待发货";
        }
            break;
        case 3:
        {
            stateLabel.text = @"待发货";
        }
            break;
            
        default:
            break;
    }
    
    stateBKV.sd_layout
    .topSpaceToView(addressBackgroundView,10)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(40);
    
    stateNameLabel.sd_layout
    .topSpaceToView(stateBKV,0)
    .leftSpaceToView(stateBKV,10)
    .bottomSpaceToView(stateBKV,0)
    .widthIs(70);
    
    stateLabel.sd_layout
    .topSpaceToView(stateBKV,0)
    .leftSpaceToView(stateNameLabel,0)
    .bottomSpaceToView(stateBKV,0)
    .rightSpaceToView(stateBKV,10);
    
//----------------------------------------------------------------------------------------------------------
    UIView *orderTimeBKV = [[UIView alloc] init];
    orderTimeBKV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:orderTimeBKV];
    
    UILabel *timeNameLabel = [[UILabel alloc] init];
    timeNameLabel.textColor = [UIColor blackColor];
    timeNameLabel.text = @"订单时间";
    timeNameLabel.font = [UIFont systemFontOfSize:15];
    [orderTimeBKV addSubview:timeNameLabel];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.text = self.model.createDate;
    timeLabel.font = [UIFont systemFontOfSize:15];
    [orderTimeBKV addSubview:timeLabel];
    
    orderTimeBKV.sd_layout
    .topSpaceToView(stateBKV,10)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(40);
    
    timeNameLabel.sd_layout
    .topSpaceToView(orderTimeBKV,0)
    .leftSpaceToView(orderTimeBKV,10)
    .bottomSpaceToView(orderTimeBKV,0)
    .widthIs(70);
    
    timeLabel.sd_layout
    .topSpaceToView(orderTimeBKV,0)
    .leftSpaceToView(timeNameLabel,0)
    .bottomSpaceToView(orderTimeBKV,0)
    .rightSpaceToView(orderTimeBKV,10);
    
}

@end
