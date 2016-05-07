//
//  ServiceCell.m
//  YouChengTire
//
//  Created by Baby on 16/2/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "ServiceCell.h"

@implementation ServiceCell

@end

@interface ServiceFirstCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *distenceLab;

@end

@implementation ServiceFirstCell
- (void)refrashData:(NearbyPointItemM *)_nModel index:(NSIndexPath *)_idex{
    self.index = _idex;
    [self.iconImgV yy_setImageWithURL:[NSURL URLWithString:_nModel.appPhoto]
                         placeholder:[UIImage imageNamed:@"ic_service_logo"]];
    self.nameLab.text = _nModel.name;
    self.addressLab.text = _nModel.address;
    self.distenceLab.text = [NSString stringWithFormat:@"距离:%@m",_nModel.distance];
}

- (IBAction)callBtnClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(callClickedWithIndex:)]) {
        [self.delegate callClickedWithIndex:self.index];
    }
}

@end


/*****************************************************************************************
 * 二
 *****************************************************************************************/

@interface ServiceSecondCell()

@end

@implementation ServiceSecondCell

@end


/*****************************************************************************************
 * 三
 *****************************************************************************************/

@interface ServiceThirdCell()
@property (weak, nonatomic) IBOutlet UILabel *orderNumLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightWidthConstraint;

@end

@implementation ServiceThirdCell

- (void)refrashData:(NSDictionary *)_dic index:(NSIndexPath *)_idex{
    self.index = _idex;
    if ([@"0" isEqualToString:_dic[@"status"]]) {
        self.statusLab.text = @"等待安装";
        self.leftBtn.hidden = NO;
        self.rightBtn.hidden = YES;
        self.rightWidthConstraint.constant = 0.0f;
    }else{
        self.statusLab.text = @"安装成功";
        self.leftBtn.hidden = self.rightBtn.hidden = NO;
        self.rightWidthConstraint.constant = 65.0f;
    }
    self.timeLab.text = [NSString stringWithFormat:@"上门时间:%@",_dic[@"setupDate"]];
    
    
    NSDictionary * orderDic = _dic[@"order"];
    NSArray * productList = orderDic[@"productList"];
    NSDictionary * firstDic = [productList firstObject];
    NSDictionary * productDic = firstDic[@"product"];
    
    self.orderNumLab.text = [NSString stringWithFormat:@"订单号:%@",orderDic[@"number"]];
    [self.iconIV yy_setImageWithURL:[NSURL URLWithString:productDic[@"photo"]]
                          placeholder:nil];
    self.titleLab.text = productDic[@"name"];
    self.numLab.text = [NSString stringWithFormat:@"x %@",firstDic[@"count"]];
    self.priceLab.text = [NSString stringWithFormat:@"¥%@",productDic[@"price"]];
}

- (IBAction)leftBtnClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(leftBtnClickedWithIndex:)]) {
        [self.delegate leftBtnClickedWithIndex:self.index];
    }
}

- (IBAction)rightBtnClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(rightBtnClickedWithIndex:)]) {
        [self.delegate rightBtnClickedWithIndex:self.index];
    }
}


@end


/*****************************************************************************************
 * 四
 *****************************************************************************************/

@interface ServiceFourCell()
@property (weak, nonatomic) IBOutlet UILabel *orderLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightWidthConstraint;
@end

@implementation ServiceFourCell

- (void)refrashData:(NSDictionary *)_dic index:(NSIndexPath *)_idex{
    self.index = _idex;
    
    switch ([_dic[@"status"] integerValue])
    {
            break;
        case 1:
        {
            self.statusLab.text = @"编辑";
            self.leftBtn.hidden = NO;
            self.rightBtn.hidden = YES;
            self.rightWidthConstraint.constant = 0.0f;
        }
            break;
        case 2:
        {
            self.statusLab.text = @"待审核";
            self.leftBtn.hidden = NO;
            self.rightBtn.hidden = YES;
            self.rightWidthConstraint.constant = 0.0f;
        }
            break;
        case 3:
        {
            self.statusLab.text = @"审核通过";
            self.leftBtn.hidden = NO;
            self.rightBtn.hidden = YES;
            self.rightWidthConstraint.constant = 0.0f;
        }
            break;
        case 4:
        {
            self.statusLab.text = @"审核失败";
            self.leftBtn.hidden = self.rightBtn.hidden = NO;
            self.rightWidthConstraint.constant = 65.0f;
        }
            break;
        case 5:
        {
            self.statusLab.text = @"理赔成功";
            self.leftBtn.hidden = self.rightBtn.hidden = NO;
            self.rightWidthConstraint.constant = 65.0f;
        }
            
        default:
            break;
    }
    
    self.numLab.hidden = YES;
    
//    NSDictionary * orderDic = _dic[@"order"];
    NSArray * productList = [NSArray arrayWithArray:_dic[@"pictureList"]];
    NSDictionary * firstDic = [productList firstObject];
    
    self.orderLab.text = [NSString stringWithFormat:@"订单号:%@",_dic[@"number"]];
    [self.iconIV yy_setImageWithURL:[NSURL URLWithString:firstDic[@"appPath"]]
                        placeholder:[UIImage imageNamed:@"ic_service_logo"]];
    self.titleLab.text = [NSString stringWithFormat:@"%@%@%@",_dic[@"brand"],_dic[@"pattern"],_dic[@"tireNumber"]];
//    self.numLab.text = [NSString stringWithFormat:@"x %@",firstDic[@"count"]];
    self.moneyLab.text = [NSString stringWithFormat:@"规格：%@",_dic[@"standard"]];
    self.desLab.text = [NSString stringWithFormat:@"问题描述：%@",_dic[@"description"]];
    
}

- (IBAction)leftBtnClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(leftBtnClickedWithIndex:)]) {
        [self.delegate leftBtnClickedWithIndex:self.index];
    }
}
- (IBAction)rightBtnClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(rightBtnClickedWithIndex:)]) {
        [self.delegate rightBtnClickedWithIndex:self.index];
    }
}

@end