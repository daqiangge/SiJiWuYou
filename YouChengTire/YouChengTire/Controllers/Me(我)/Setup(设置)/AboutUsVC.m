//
//  AboutUsVC.m
//  YouChengTire
//  关于我们
//  Created by WangZhipeng on 16/1/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "AboutUsVC.h"
// ViewModels
#import "AboutUsVM.h"

@interface AboutUsVC ()

@property (strong, nonatomic) AboutUsVM *aboutUsVM;

@property (nonatomic, weak) IBOutlet UIView *subtitleView;

@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark - Override
- (void)configureView {
    [self configureNavigationController];
    [self configureSubtitleView];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_aboutUsVM, title);
}

- (void)configureData {}

#pragma mark - Private
- (void)configureNavigationController {}

- (void)configureSubtitleView {
    _subtitleView.layer.borderWidth = 1;
    _subtitleView.layer.cornerRadius = 1;
    _subtitleView.layer.borderColor = RGB(204, 204, 204).CGColor;
}

#pragma mark - Custom Accessors

@end
