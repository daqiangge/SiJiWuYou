//
//  GuideVC.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GuideVC.h"

@interface GuideVC () <
UIScrollViewDelegate
>

// UI
@property (nullable, nonatomic, weak) IBOutlet UIScrollView *masterScrollView;
@property (nullable, nonatomic, strong) NSArray *imageNameArray;

@end

@implementation GuideVC

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

#pragma mark - Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [UserM updateVersion];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    // 改变UI位置
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // 确定UI位置关系后设置AutoLayout
    [self configureScrollView];
}

#pragma mark - Override
- (void)configureView {}

- (void)bindViewModel {}

- (void)configureData {}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    /**
     *  左滑越界判断
     */
    if (scrollView.contentOffset.x < 0) {
        [scrollView setContentOffset:CGPointMake(0,
                                                 scrollView.contentOffset.y)
                            animated:NO];
        return;
    }
    /**
     *  右滑越界判断
     */
    if (scrollView.contentOffset.x > GET_VIEW_WIDTH(self.view) * (self.imageNameArray.count - 1)) {
        [scrollView setContentOffset:CGPointMake(GET_VIEW_WIDTH(self.view) * (self.imageNameArray.count - 1),
                                                 scrollView.contentOffset.y)
                            animated:NO];
        return;
    }
}

#pragma mark - Private
- (void)configureScrollView {
    _masterScrollView.pagingEnabled = YES;
    _masterScrollView.contentSize = CGSizeMake(GET_VIEW_WIDTH(self.view) * self.imageNameArray.count,
                                               GET_VIEW_HEIGHT(self.view));
    _masterScrollView.showsHorizontalScrollIndicator = NO;
    _masterScrollView.showsVerticalScrollIndicator = NO;
    _masterScrollView.scrollsToTop = NO;
    _masterScrollView.delegate = self;
    for (int i = 0; i < self.imageNameArray.count; i++) {
        UIImageView *imageV = [UIImageView new];
        UIImage *image = GETIMAGE(self.imageNameArray[i]);
        [imageV setImage:image];
        if (i == (self.imageNameArray.count - 1)) {
            imageV.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                                   action:@selector(close:)];
            tapGestureRecognizer.cancelsTouchesInView = NO;
            [imageV addGestureRecognizer:tapGestureRecognizer];
        }
        [_masterScrollView addSubview:imageV];
        [imageV mas_makeConstraints: ^(MASConstraintMaker *make) {
            make.top.equalTo(_masterScrollView.mas_top);
            make.left.equalTo(_masterScrollView).with.offset(GET_VIEW_WIDTH(self.view) * i);
            make.width.equalTo(@(GET_VIEW_WIDTH(self.view)));
            make.height.equalTo(@(GET_VIEW_HEIGHT(self.view)));
        }];
    }
    [_masterScrollView setContentOffset:CGPointMake(0,
                                                    _masterScrollView.contentOffset.y)];
}

- (void)close:(id)sender {
    [UIView animateWithDuration:0.35 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

#pragma mark - Custom Accessors
- (NSArray *)imageNameArray {
    // Version 1.11
    if (!_imageNameArray) {
        if (kDeviceIsiPhone6Plus) {
            _imageNameArray = @[
                                @"first1242_2208",
                                @"second1242_2208"
                                ];
        }
        else if (kDeviceIsiPhone6
                 || kDeviceIsiPhone6PlusEnlarge) {
            _imageNameArray = @[
                                @"first750_1334",
                                @"second750_1334"
                                ];
        }
        else if (kDeviceIsiPhone5) {
            _imageNameArray = @[
                                @"first640_1136",
                                @"second640_1136"
                                ];
        }
        else{
            _imageNameArray = @[
                                @"first640_960",
                                @"second640_960"
                                ];
        }
    }
    return _imageNameArray;
}

@end
