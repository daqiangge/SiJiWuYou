//
//  VisitingServiceVC.m
//  YouChengTire
//
//  Created by duwen on 16/4/4.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "VisitingServiceVC.h"
#import "RootTBC.h"
#import "OrderClaimsVC.h"
#import "LQOrderClaimsVC.h"

@interface VisitingServiceVC ()
@property (strong, nonatomic) IBOutlet UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UIButton *rightBtn;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftBottomConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rightBottomConstraint;

@property (strong, nonatomic) IBOutlet UIView *leftView;
@property (strong, nonatomic) IBOutlet UIView *rightView;

@end

@implementation VisitingServiceVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [(RootTBC *)ZPRootViewController setTabBarHidden:YES
                                            animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上门服务";
    
    UIBarButtonItem * rightBar= [[UIBarButtonItem alloc] initWithTitle:@"申请理赔" style:UIBarButtonItemStylePlain target:self action:@selector(payButtonClicked)];
    [self.navigationItem setRightBarButtonItem:rightBar animated:YES];
}

- (IBAction)btnClicked:(UIButton *)sender {
    if (sender == self.leftBtn) {
        self.leftBtn.selected = YES;
        self.rightBtn.selected = NO;
        self.leftBottomConstraint.constant = 2;
        self.rightBottomConstraint.constant = 0;
        self.leftView.hidden = NO;
        self.rightView.hidden = YES;
    }else{
        self.leftBtn.selected = NO;
        self.rightBtn.selected = YES;
        self.leftBottomConstraint.constant = 0;
        self.rightBottomConstraint.constant = 2;
        self.leftView.hidden = YES;
        self.rightView.hidden = NO;
    }
}

- (void)payButtonClicked
{
//    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Service"
//                                                  bundle:[NSBundle mainBundle]];
//    OrderClaimsVC * vc = [sb instantiateViewControllerWithIdentifier:@"OrderClaimsVC_SBID"];
//    [self.navigationController pushViewController:vc
//                                         animated:YES];
    
    LQOrderClaimsVC *vc = [[LQOrderClaimsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Override
- (void)configureView {
    [self configureNavigationController];
}

#pragma mark - Private
- (void)configureNavigationController {
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
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
