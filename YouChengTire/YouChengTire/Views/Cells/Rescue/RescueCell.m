//
//  RescueCell.m
//  YouChengTire
//
//  Created by Baby on 16/3/23.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "RescueCell.h"

@implementation RescueCell

@end

@interface RescueFirstCell()
@property (weak, nonatomic) IBOutlet UILabel *orderLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;

@end

@implementation RescueFirstCell

- (void)refrashData:(RescueItemM *)_rModel idex:(NSIndexPath *)_idex{
    self.index = _idex;
    self.orderLab.text = [NSString stringWithFormat:@"订单号：%@",_rModel.number];
    self.timeLab.text = [NSString stringWithFormat:@"发布时间：%@",_rModel.createDate];
    self.addressLab.text = [NSString stringWithFormat:@"救援位置：%@ %@ %@",_rModel.province,_rModel.city,_rModel.county];
    self.desLab.text = _rModel.des;
    
    switch ([_rModel.status integerValue]) {
        case 1:
            self.statusLab.text = @"编辑";
            break;
        case 2:
            self.statusLab.text = @"发布救援";
            break;
        case 3:
            self.statusLab.text = @"等待救援";
            break;
        case 4:
            self.statusLab.text = @"救援成功";
            break;
        case 5:
            self.statusLab.text = @"救援失败";
            break;
        default:
            break;
    }
}


- (IBAction)grapBusinessBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickButtonWithIndex:)]) {
        [self.delegate clickButtonWithIndex:self.index];
    }
}


@end

@interface RescueSecondCell()
//@property (nonatomic, assign) id<RescueSecondCellDelegate> delegate;
//@property (nonatomic, strong) NSIndexPath * index;

@property (weak, nonatomic) IBOutlet UILabel *orderLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *localLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UILabel *priceTagLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@end

@implementation RescueSecondCell

- (void)awakeFromNib{

}

- (void)refrashDataWithVIP:(BOOL)_isVIP data:(NSDictionary *)_dic  idx:(NSIndexPath *)_idex{
    self.index = _idex;
    if (!_isVIP) {
        self.priceTagLab.hidden = self.priceLab.hidden = NO;
    }
    
    self.orderLab.text = [NSString stringWithFormat:@"订单号:%@",_dic[@"number"]];
    self.timeLab.text = [NSString stringWithFormat:@"发布时间：%@",_dic[@"createDate"]];
    self.localLab.text = [NSString stringWithFormat:@"救援位置：%@ %@ %@",_dic[@"province"],_dic[@"city"],_dic[@"county"]];
    self.contentLab.text = _dic[@"description"];
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@", _dic[@"price"]];
    
    if (!_isVIP)
    {
        switch ([_dic[@"status"] integerValue])
        {
            case 3:
                self.statusLab.text = @"等待救援";
                self.leftBtn.hidden = YES;
                self.rightBtn.hidden = NO;
                [self.rightBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                break;
            case 4:
                self.statusLab.text = @"救援成功";
                self.leftBtn.hidden = YES;
                self.rightBtn.hidden = YES;
                break;
            case 5:
                self.statusLab.text = @"救援失败";
                self.leftBtn.hidden = YES;
                self.rightBtn.hidden = YES;
                break;
            default:
                break;
        }
    }
    else
    {
        switch ([_dic[@"status"] integerValue])
        {
            case 1:
                self.statusLab.text = @"编辑";
                self.leftBtn.hidden = YES;
                [self.leftBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                [self.rightBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                break;
            case 2:
                self.statusLab.text = @"发布救援";
                self.leftBtn.hidden = YES;
                [self.leftBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                [self.rightBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                break;
            case 3:
                self.statusLab.text = @"等待救援";
                self.leftBtn.hidden = YES;
                [self.leftBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                [self.rightBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                break;
            case 4:
                self.statusLab.text = @"救援成功";
                self.leftBtn.hidden = NO;
                [self.leftBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                [self.rightBtn setTitle:@"订单评价" forState:UIControlStateNormal];
                break;
            case 5:
                self.statusLab.text = @"救援失败";
                self.leftBtn.hidden = NO;
                [self.leftBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                [self.rightBtn setTitle:@"订单评价" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }
}


- (IBAction)leftButtonClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickLeftButtonWithIndex:obj:)]) {
        [self.delegate clickLeftButtonWithIndex:self.index obj:self.leftBtn];
    }
}

- (IBAction)rightButtonClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickRightButtonWithIndex:obj:)]) {
        [self.delegate clickRightButtonWithIndex:self.index obj:self.rightBtn];
    }
}


@end


@interface RescueThirdCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *disLab;

@end

@implementation RescueThirdCell
- (void)refrashData:(NearbyPointItemM *)_nModel idex:(NSIndexPath *)_idex{
    self.index = _idex;
    
    [self.iconImg yy_setImageWithURL:[NSURL URLWithString:_nModel.appPhoto]
                                   placeholder:[UIImage imageNamed:@"ic_service_logo"]];
    self.nameLab.text = _nModel.name;
    self.addressLab.text = _nModel.address;
    self.disLab.text = [NSString stringWithFormat:@"距离:<%@m",_nModel.distance];
}

- (IBAction)callClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickButtonWithIndex:)]) {
        [self.delegate clickButtonWithIndex:self.index];
    }
}

@end
