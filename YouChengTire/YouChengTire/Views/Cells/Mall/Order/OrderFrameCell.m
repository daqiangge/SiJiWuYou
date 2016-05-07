//
//  OrderFrameCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/3/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderFrameCell.h"
// Controllers
#import "OrderAddRemarkVC.h"
#import "OrderAfterSalesVC.h"
#import "OrderFrameVC.h"
// Models
#import "OrderFrameM.h"
// ViewModel
#import "OrderFrameVM.h"

@implementation OrderFrameCell

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface OrderFrameFirstCell ()

@property (nonatomic, weak) IBOutlet UILabel *belongName;
@property (nonatomic, weak) IBOutlet UILabel *status;

@end

@implementation OrderFrameFirstCell

- (void)configureCell:(NSDictionary *)model {
    OrderFrameM *orderFrameM = model[@"kModel"];
    _belongName.text = orderFrameM.belongName;
    _status.text = orderFrameM.status;
}

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface OrderFrameSecondCell ()

@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *price;
@property (nonatomic, weak) IBOutlet UILabel *count;

@end

@implementation OrderFrameSecondCell

- (void)configureCell:(NSDictionary *)model {
    NSDictionary *dictionary = model[@"kModel"];
    _count.text = [NSString stringWithFormat:@"x %@", dictionary[@"count"]];
    
    OrderFrameProductM *orderFrameProductM = [OrderFrameProductM yy_modelWithDictionary:dictionary[@"product"]];
    [_logoImageView yy_setImageWithURL:[NSURL URLWithString:orderFrameProductM.photo]
                           placeholder:nil];
    _title.text = orderFrameProductM.name;
    _price.text = [NSString stringWithFormat:@"￥ %@", orderFrameProductM.price];
}

@end

/*****************************************************************************************
 * 三
 *****************************************************************************************/
@interface OrderFrameThirdCell ()

@property (nonatomic, weak) IBOutlet UILabel *totalLabel;

@property (nonatomic, weak) IBOutlet UIButton *firstButton;
@property (nonatomic, weak) IBOutlet UIButton *secondButton;
@property (nonatomic, weak) IBOutlet UIButton *thirdButton;

@property (nonatomic, strong) OrderFrameVM *viewModel;
@property (nonatomic, strong) OrderFrameM *model;

@end

@implementation OrderFrameThirdCell

- (void)awakeFromNib {
    // Initialization code
    _firstButton.layer.borderWidth = 1;
    _firstButton.layer.cornerRadius = 6;
    _firstButton.layer.borderColor = [UIColor clearColor].CGColor;
    
    _secondButton.layer.borderWidth = 1;
    _secondButton.layer.cornerRadius = 6;
    _secondButton.layer.borderColor = RGB(49, 49, 49).CGColor;
    
    _thirdButton.layer.borderWidth = 1;
    _thirdButton.layer.cornerRadius = 6;
    _thirdButton.layer.borderColor = RGB(49, 49, 49).CGColor;
}

- (void)bindViewModel:(OrderFrameVM *)viewModel {
    _viewModel = viewModel;
}

- (void)configureCell:(NSDictionary *)model {
    _model = model[@"kModel"];
    _totalLabel.text = [NSString stringWithFormat:@"共 %lu 件商品 合计: ￥%@（含运费 ￥%.2f）",
                        (unsigned long)_model.productList.count,
                        _model.totalPrice,
                        [_model.freightPrice floatValue]];
    [self configureButton:_model.status];
}

- (void)configureButton:(NSString *)status {
    
    [_firstButton removeTarget:nil
                        action:nil
              forControlEvents:UIControlEventTouchUpInside];
    [_secondButton removeTarget:nil
                         action:nil
               forControlEvents:UIControlEventTouchUpInside];
    [_thirdButton removeTarget:nil
                        action:nil
              forControlEvents:UIControlEventTouchUpInside];
    
    if ([status isEqualToString:@"待付款"]) {
        _firstButton.hidden = NO;
        [_firstButton setTitle:@"立即支付"
                      forState:UIControlStateNormal];
        [_firstButton addTarget:self
                         action:@selector(payImmediately)
               forControlEvents:UIControlEventTouchUpInside];
        
        _secondButton.hidden = YES;
        //        [_secondButton setTitle:@"取消订单"
        //                      forState:UIControlStateNormal];
        //        [_secondButton addTarget:self
        //                         action:@selector(cancelOrder)
        //               forControlEvents:UIControlEventTouchUpInside];
        
        _thirdButton.hidden = YES;
    }
    else if ([status isEqualToString:@"待发货"]) {
        _firstButton.hidden = YES;
        //        [_firstButton setTitle:@"提醒发货"
        //                      forState:UIControlStateNormal];
        //        [_firstButton addTarget:self
        //                         action:@selector(reminderDelivery)
        //               forControlEvents:UIControlEventTouchUpInside];
        
        _secondButton.hidden = YES;
        //        [_secondButton setTitle:@"查看物流"
        //                       forState:UIControlStateNormal];
        //        [_secondButton addTarget:self
        //                          action:@selector(viewLogistics)
        //                forControlEvents:UIControlEventTouchUpInside];
        
        _thirdButton.hidden = YES;
    }
    else if ([status isEqualToString:@"待收货"]) {
        _firstButton.hidden = NO;
        [_firstButton setTitle:@"确认收货"
                      forState:UIControlStateNormal];
        [_firstButton addTarget:self
                         action:@selector(confirmReceipt)
               forControlEvents:UIControlEventTouchUpInside];
        
        _secondButton.hidden = YES;
        //        [_secondButton setTitle:@"查看物流"
        //                       forState:UIControlStateNormal];
        //        [_secondButton addTarget:self
        //                          action:@selector(viewLogistics)
        //                forControlEvents:UIControlEventTouchUpInside];
        
        _thirdButton.hidden = YES;
        //        [_thirdButton setTitle:@"延长收货"
        //                      forState:UIControlStateNormal];
        //        [_thirdButton addTarget:self
        //                         action:@selector(extendedReceipt)
        //               forControlEvents:UIControlEventTouchUpInside];
    }
    else if ([status isEqualToString:@"待评价"]) {
        //        [_firstButton setTitle:@"再次购买"
        //                      forState:UIControlStateNormal];
        //        [_firstButton addTarget:self
        //                         action:@selector(buyAgain)
        //               forControlEvents:UIControlEventTouchUpInside];
        
        _firstButton.hidden = NO;
        [_firstButton setTitle:@"晒单评价"
                      forState:UIControlStateNormal];
        [_firstButton addTarget:self
                         action:@selector(sunExposureAssessment)
               forControlEvents:UIControlEventTouchUpInside];
        //        _firstButton.hidden = YES;
        
        _secondButton.hidden = YES;
        //        [_secondButton setTitle:@"晒单评价"
        //                       forState:UIControlStateNormal];
        //        [_secondButton addTarget:self
        //                          action:@selector(sunExposureAssessment)
        //                forControlEvents:UIControlEventTouchUpInside];
        //
        _thirdButton.hidden = YES;
        //        [_thirdButton setTitle:@"删除订单"
        //                      forState:UIControlStateNormal];
        //        [_thirdButton addTarget:self
        //                         action:@selector(deleteOrder)
        //               forControlEvents:UIControlEventTouchUpInside];
    }
    else if ([status isEqualToString:@"已评价"]) {
        //        [_firstButton setTitle:@"再次购买"
        //                      forState:UIControlStateNormal];
        //        [_firstButton addTarget:self
        //                         action:@selector(buyAgain)
        //               forControlEvents:UIControlEventTouchUpInside];
        //
        //        [_secondButton setTitle:@"删除订单"
        //                      forState:UIControlStateNormal];
        //        [_secondButton addTarget:self
        //                         action:@selector(deleteOrder)
        //               forControlEvents:UIControlEventTouchUpInside];
        
        _firstButton.hidden = NO;
        [_firstButton setTitle:@"申请售后"
                      forState:UIControlStateNormal];
        [_firstButton addTarget:self
                         action:@selector(afterSales)
               forControlEvents:UIControlEventTouchUpInside];
        //        _firstButton.hidden = YES;
        
        _secondButton.hidden = YES;
        _thirdButton.hidden = YES;
    }
}

/**
 *  取消订单
 */
- (void)cancelOrder {
    
}

/**
 *  立即支付
 */
- (void)payImmediately {
    [_viewModel.masterVC performSegueWithIdentifier:@"orderPayVC"
                                             sender:_model];
}

/**
 *  查看物流
 */
- (void)viewLogistics {
    
}

/**
 *  提醒发货
 */
- (void)reminderDelivery {
    
}

/**
 *  延长收货
 */
- (void)extendedReceipt {
    
}

/**
 *  确认收货
 */
- (void)confirmReceipt {
    _viewModel.orderId = _model.sId;
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    [_viewModel requestEnsureProduct:^(id object) {
        kMRCSuccess(@"确认收货成功");
        [((OrderFrameVC *)_viewModel.masterVC).fourthTableView.mj_header beginRefreshing];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

/**
 *  删除订单
 */
- (void)deleteOrder {
    
}

/**
 *  晒单评价
 */
- (void)sunExposureAssessment {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MallOrder"
                                                 bundle:[NSBundle mainBundle]];
    OrderAddRemarkVC *vc = [sb instantiateViewControllerWithIdentifier:@"OrderAddRemarkVC"];
    [vc setValue:_model
          forKey:@"orderFrameM"];
    [_viewModel.masterVC.navigationController pushViewController:vc
                                                        animated:YES];
}

/**
 *  再次购买
 */
- (void)buyAgain {
    
}

/**
 *  申请售后
 */
- (void)afterSales {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MallOrder"
                                                 bundle:[NSBundle mainBundle]];
    OrderAfterSalesVC *vc = [sb instantiateViewControllerWithIdentifier:@"OrderAfterSalesVC"];
    [vc setValue:_model
          forKey:@"orderFrameM"];
    [_viewModel.masterVC.navigationController pushViewController:vc
                                                        animated:YES];
}

@end
