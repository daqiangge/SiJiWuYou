//
//  GoodsParameterVC.m
//  YouChengTire
//  商品参数
//  Created by WangZhipeng on 16/3/26.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsParameterVC.h"
// ViewModels
#import "GoodsParameterVM.h"
// Cells
#import "GoodsParameterCell.h"

static NSString *const kCellIdentifier = @"GoodsParameterCell";

@interface GoodsParameterVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) GoodsParameterVM *goodsParameterVM;

@property (weak, nonatomic) IBOutlet UIWebView *firstWebView;
@property (weak, nonatomic) IBOutlet UIWebView *secondWebView;
@property (weak, nonatomic) IBOutlet UITableView *thirdTableView;

@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;

@end

@implementation GoodsParameterVC

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
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_goodsParameterVM, title);
    
    @weakify(self)
    [RACObserve(_goodsParameterVM, tabNumber)
     subscribeNext:^(NSNumber *tabNumber) {
         @strongify(self)
         switch ([tabNumber integerValue]) {
             case 1: {
                 self.firstWebView.hidden = NO;
                 self.secondWebView.hidden = YES;
                 self.thirdTableView.hidden = YES;
                 
                 self.firstView.hidden = NO;
                 self.secondView.hidden = YES;
                 self.thirdView.hidden = YES;
                 
                 self.firstLabel.textColor = RGB(49, 49, 49);
                 self.secondLabel.textColor = RGB(153, 153, 153);
                 self.thirdLabel.textColor = RGB(153, 153, 153);
             }
                 break;
                 
             case 2: {
                 self.firstWebView.hidden = YES;
                 self.secondWebView.hidden = NO;
                 self.thirdTableView.hidden = YES;
                 
                 self.firstView.hidden = YES;
                 self.secondView.hidden = NO;
                 self.thirdView.hidden = YES;
                 
                 self.firstLabel.textColor = RGB(153, 153, 153);
                 self.secondLabel.textColor = RGB(49, 49, 49);
                 self.thirdLabel.textColor = RGB(153, 153, 153);
             }
                 break;
                 
             case 3: {
                 self.firstWebView.hidden = YES;
                 self.secondWebView.hidden = YES;
                 self.thirdTableView.hidden = NO;
                 
                 self.firstView.hidden = YES;
                 self.secondView.hidden = YES;
                 self.thirdView.hidden = NO;
                 
                 self.firstLabel.textColor = RGB(153, 153, 153);
                 self.secondLabel.textColor = RGB(153, 153, 153);
                 self.thirdLabel.textColor = RGB(49, 49, 49);
             }
                 break;
                 
             default:
                 break;
         }
     }];
}

- (void)configureData {
    switch ([_goodsParameterVM.tabNumber integerValue]) {
        case 1: {
            NSURL *url = [NSURL URLWithString:_goodsParameterVM.appPictureDescUrl];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [_firstWebView loadRequest:request];
        }
            break;
            
        case 2: {
            NSURL *url = [NSURL URLWithString:_goodsParameterVM.parametersUrl];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [_secondWebView loadRequest:request];
        }
            break;
            
        case 3: {
            if (!_goodsParameterVM.array) {
                [self requestGetCommentList];
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showHUDAddedTo:self.view
                         animated:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)web {
    [MBProgressHUD hideHUDForView:self.view
                         animated:YES];
    if ([web isEqual:_firstWebView]) {
        _goodsParameterVM.isFirstSuccess = @YES;
    }
    else if ([web isEqual:_secondWebView]) {
        _goodsParameterVM.isSecondSuccess = @YES;
    }
}

- (void)webView:(UIWebView *)webView DidFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.view
                         animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8.f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _goodsParameterVM.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:kCellIdentifier
                                    cacheByIndexPath:indexPath
                                       configuration: ^(GoodsParameterCell *cell) {
                                           // TODO
                                       }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(GoodsParameterCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell configureCell:_goodsParameterVM.array[indexPath.row]];
}

#pragma mark - Private
- (void)configureNavigationController {}

- (void)requestGetCommentList {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    [_goodsParameterVM requestGetCommentList:^(id object) {
        [self.thirdTableView reloadData];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

#pragma mark - Event Response
- (IBAction)switchFirst:(id)sender {
    if([_goodsParameterVM switchFirst]) {
        if (![_goodsParameterVM.isFirstSuccess boolValue]) {
            NSURL *url = [NSURL URLWithString:_goodsParameterVM.appPictureDescUrl];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [_firstWebView loadRequest:request];
        }
    }
}

- (IBAction)switchSecond:(id)sender {
    if([_goodsParameterVM switchSecond]) {
        if (![_goodsParameterVM.isSecondSuccess boolValue]) {
            NSURL *url = [NSURL URLWithString:_goodsParameterVM.parametersUrl];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [_secondWebView loadRequest:request];
        }
    }
}

- (IBAction)switchThird:(id)sender {
    if([_goodsParameterVM switchThird]) {
        if (!_goodsParameterVM.array) {
            [self requestGetCommentList];
        }
    }
}

#pragma mark - Custom Accessors
- (void)setAppPictureDescUrl:(NSString *)appPictureDescUrl {
    _goodsParameterVM.appPictureDescUrl = appPictureDescUrl;
}

- (void)setParametersUrl:(NSString *)parametersUrl {
    _goodsParameterVM.parametersUrl = parametersUrl;
}

- (void)setParentId:(NSString *)parentId {
    _goodsParameterVM.parentId = parentId;
}

- (void)setTabNumber:(NSNumber *)tabNumber {
    _goodsParameterVM.tabNumber = tabNumber;
}

@end
