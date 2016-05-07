//
//  RescueOrderDetailVC.m
//  YouChengTire
//
//  Created by Baby on 16/3/23.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "RescueOrderDetailVC.h"
#import "RootTBC.h"
#import "RescueVM.h"

@interface RescueOrderDetailVC ()
@property (strong, nonatomic) RescueVM * rescueVM;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderViewHeightConstraint;         // price? 140 : 100
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollerBottomConstraint;          // bottom？-35 : 0

@property (weak, nonatomic) IBOutlet UILabel *orderLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *ruteLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *payLab;
@property (weak, nonatomic) IBOutlet UILabel *desLab;


@property (weak, nonatomic) IBOutlet UIButton *grabBtn;
@property (weak, nonatomic) IBOutlet UIButton *payCashBtn;
@property (weak, nonatomic) IBOutlet UIButton *payOnlineBtn;


@end

@implementation RescueOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"救援订单";
    
    if (self.rescueType == RESCUE_FIRST_TYPE) {
        self.orderViewHeightConstraint.constant = 100.0f;
        self.scrollerBottomConstraint.constant = -35.0f;
        
        self.grabBtn.hidden = NO;
        self.payCashBtn.hidden = self.payOnlineBtn.hidden = YES;
    }
    
    if (self.rescueType == RESCUE_SECOND_TYPE) {
        self.orderViewHeightConstraint.constant = 140.0f;
        self.scrollerBottomConstraint.constant = 0.0f;
    }
    
    if (self.rescueType == RESCUE_THIRD_TYPE) {
        self.orderViewHeightConstraint.constant = 140.0f;
        self.scrollerBottomConstraint.constant = -35.0f;
        
        self.grabBtn.hidden = YES;
        self.payCashBtn.hidden = self.payOnlineBtn.hidden = NO;
    }
    
    self.rescueVM = [[RescueVM alloc] init];
    
    NSMutableDictionary * params = @{@"id":self.sid}.mutableCopy;
    [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [self.rescueVM requestGetRescue:^(id object) {
        @strongify(self)
        [self refrashUI:object[@"rescue"]];
    } data:params error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (void)refrashUI:(NSDictionary *)dic{
    self.orderLab.text = [NSString stringWithFormat:@"订单号:%@",dic[@"number"]];
    switch ([dic[@"status"] integerValue]) {
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
    
    self.contentLab.text = dic[@"detail"];
    self.desLab.text = dic[@"description"];
    
    if (self.rescueType == RESCUE_FIRST_TYPE) {

    }
    
    if (self.rescueType == RESCUE_SECOND_TYPE) {
        NSDictionary * point = dic[@"point"];
        self.priceLab.text = [NSString stringWithFormat:@"¥ %@",point[@"charge"]];
        if ([@"0" isEqualToString:dic[@"paymentStatus"]]) {
            self.payLab.text = @"未付款";
        }else{
            self.payLab.text = @"已付款";
        }
    }
    
    if (self.rescueType == RESCUE_THIRD_TYPE) {

    }
    
    
}

// 立即抢单
- (IBAction)grabBtnClicked:(id)sender {
    NSMutableDictionary * params = @{@"id":self.sid}.mutableCopy;
    [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [self.rescueVM requestRushRescue:^(id object) {
        @strongify(self)
        kMRCSuccess(object);
        [self.navigationController popViewControllerAnimated:YES];
    } data:params error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

// 现金支付
- (IBAction)cashBtnClicked:(id)sender
{
}

// 在线支付
- (IBAction)payOnlineClicked:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
