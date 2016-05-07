//
//  RescueBySelfVC.m
//  YouChengTire
//
//  Created by Baby on 16/3/31.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "RescueBySelfVC.h"

@interface RescueBySelfVC ()
@property (nonatomic, strong) UIBarButtonItem * listBar;
@property (nonatomic, strong) UIBarButtonItem * mapBar;

@property (weak, nonatomic) IBOutlet UIView *listView;
@property (weak, nonatomic) IBOutlet UIView *mapView;
@end

@implementation RescueBySelfVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自行协商";
    
    self.listBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_service_list"] style:UIBarButtonItemStylePlain target:self action:@selector(changeVC:)];
    self.mapBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_service_map"] style:UIBarButtonItemStylePlain target:self action:@selector(changeVC:)];
    [self.navigationItem setRightBarButtonItem:self.listBar animated:YES];
}

- (void)changeVC:(UIBarButtonItem *)_bar{
    if (_bar == self.listBar) {
        [self.navigationItem setRightBarButtonItem:self.mapBar animated:YES];
        [self.view bringSubviewToFront:self.listView];
    }else{
        [self.navigationItem setRightBarButtonItem:self.listBar animated:YES];
        [self.view bringSubviewToFront:self.mapView];
    }
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
