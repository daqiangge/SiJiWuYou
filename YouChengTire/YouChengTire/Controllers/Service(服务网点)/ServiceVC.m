//
//  ServiceVC.m
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "ServiceVC.h"
// Controllers
#import "RootTBC.h"

@implementation ServiceVC

// WangZhipeng 当点击首页“服务网点”，隐藏底部Tabbar Start 20160429
#pragma mark - Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count > 1) {
        [(RootTBC *)ZPRootViewController setTabBarHidden:YES
                                                animated:YES];
    }
}
// WangZhipeng 当点击首页“服务网点”，隐藏底部Tabbar End 20160429

- (IBAction)flipBtnClicked:(id)sender {
    _mapView.hidden = !_mapView.hidden;
    _listView.hidden = !_listView.hidden;
    if (_mapView.hidden) {
        self.changeBarButtonItem.image = [UIImage imageNamed:@"ic_service_map"];
    }else{
        self.changeBarButtonItem.image = [UIImage imageNamed:@"ic_service_list"];
    }
}

@end
