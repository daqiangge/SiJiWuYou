//
//  RootTBC.m
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "RootTBC.h"
#import "RDVTabBarItem.h"
// Tools
#import "UIColor+HexColor.h"
// Controllers
#import "HomeVC.h"
#import "RescueVC.h"
#import "ServiceVC.h"
#import "MeVC.h"
#import "GuideVC.h"
// ViewModels
#import "RootTBVM.h"

@interface RootTBC () <RDVTabBarControllerDelegate>

@property (nullable, nonatomic, strong) GuideVC *guideVC;
@property (nullable, nonatomic, strong) UINavigationController *homeNC;
@property (nullable, nonatomic, strong) UINavigationController *rescueNC;
@property (nullable, nonatomic, strong) UINavigationController *serviceNC;
@property (nullable, nonatomic, strong) UINavigationController *meNC;

@end

@implementation RootTBC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
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

#pragma mark - Private Methods
- (void)configureView {
    [self configureGuide];
    [self configureViewControllers];
    [self configureTabbar];
}

- (void)configureGuide {
    if ([UserM isShowGuide]) {
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
        _guideVC = [mainSB instantiateViewControllerWithIdentifier:@"GuideVC"];
        [self.view addSubview:_guideVC.view];
        [_guideVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}

- (void)configureViewControllers {
    
    self.delegate = self;
    
    UIStoryboard *homeSB = [UIStoryboard storyboardWithName:@"Home"
                                                     bundle:[NSBundle mainBundle]];
    _homeNC = [homeSB instantiateViewControllerWithIdentifier:@"HomeNC"];
    
    UIStoryboard *rescueSB = [UIStoryboard storyboardWithName:@"Rescue"
                                                       bundle:[NSBundle mainBundle]];
    _rescueNC = [rescueSB instantiateViewControllerWithIdentifier:@"RescueNC"];
    
    UIStoryboard *serviceSB = [UIStoryboard storyboardWithName:@"Service"
                                                        bundle:[NSBundle mainBundle]];
    _serviceNC = [serviceSB instantiateViewControllerWithIdentifier:@"ServiceNC"];
    
    UIStoryboard *meSB = [UIStoryboard storyboardWithName:@"Me"
                                                   bundle:[NSBundle mainBundle]];
    _meNC = [meSB instantiateViewControllerWithIdentifier:@"MeNC"];
    
    self.viewControllers = @[ _homeNC, _rescueNC, _serviceNC, _meNC ];
}

- (void)configureTabbar {
    UIView *lineView = [UIView new];
    lineView.backgroundColor = RGB(153, 153, 153);
    [self.tabBar.backgroundView addSubview:lineView];
    [lineView mas_makeConstraints: ^(MASConstraintMaker *make) {
        make.top.equalTo(self.tabBar.backgroundView.mas_top);
        make.left.equalTo(self.tabBar.backgroundView.mas_left);
        make.right.equalTo(self.tabBar.backgroundView.mas_right);
        make.height.equalTo(@(1));
    }];
    
    self.tabBar.backgroundView.backgroundColor = [UIColor whiteColor];
    
    NSArray *arrayRootTBVMs = [RootTBVM arrayRootTBVMs];
    NSInteger index = 0;
    for (RDVTabBarItem *item in[[self tabBar] items]) {
        RootTBVM *viewModel = arrayRootTBVMs[index];
        [item setFinishedSelectedImage:GETIMAGE(viewModel.itemImageNameSelect)
           withFinishedUnselectedImage:GETIMAGE(viewModel.ItemimageNameUnSelect)];
        item.title = viewModel.itemTitle;
        item.selectedTitleAttributes = @{ NSForegroundColorAttributeName:HEXCOLOR(@"#e94f42") };
        item.unselectedTitleAttributes = @{ NSForegroundColorAttributeName:HEXCOLOR(@"#666666") };
        //
        index++;
    }
}

#pragma mark - RDVTabBarControllerDelegate
- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (viewController == _rescueNC) {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"一键救援"
                                              message:@"工作时间: 8:30~21:00"
                                              preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"呼叫"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               [[UIApplication sharedApplication]
                                                                openURL:[NSURL URLWithString:@"tel:4008209686"]];
                                                           }];
        [alertController addAction:callAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
        return false;
    }
    return YES;
}

@end
