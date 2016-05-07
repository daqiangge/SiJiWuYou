//
//  IntegraMallVC.m
//  YouChengTire
//
//  Created by liqiang on 16/4/17.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "IntegraMallVC.h"
#import "LCFInfiniteScrollView.h"
//#import "SDVersion.h"
#import "UIColor+LCFImageAdditions.h"
#import "RootTBC.h"
#import "ModelIntegralHome.h"
#import "LQJIFenShangChengHomeCell1.h"
#import "LQJIFenShangChengHomeCell2.h"
#import "LQJIFenShangChengHomeCell3.h"
#import "LQJiFenDuiHuanDetailVC.h"
#import "LQJiFengShangChengVC.h"

@interface IntegraMallVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) LCFInfiniteScrollView *infiniteScrollView;

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat itemSpacing;

@property (nonatomic, copy) NSArray<LCFInfiniteScrollViewItem *> *items;

@property (nonatomic, strong) ModelIntegralHome *modelIntegralHome;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation IntegraMallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"积分商城";
    
    [self drawView];
    
    [self request];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [(RootTBC *)ZPRootViewController setTabBarHidden:YES
                                            animated:YES];
}

- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.tableHeaderView = [self drawHeaderView];
}

- (UIView *)drawHeaderView
{
    self.infiniteScrollView = [[LCFInfiniteScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.itemSize.height)];
    [self.view addSubview:self.infiniteScrollView];
    //    self.tableView.tableHeaderView = self.infiniteScrollView;
    
    self.infiniteScrollView.itemSize = self.itemSize;
    self.infiniteScrollView.itemSpacing = self.itemSpacing;
    
    self.infiniteScrollView.autoscroll = YES;
    self.infiniteScrollView.timeInterval = 1.5;
    
    UIColor *color = [UIColor colorWithRed:237 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1];
    self.infiniteScrollView.placeholderImage = [color lcf_imageSized:self.itemSize];
    
    self.infiniteScrollView.didSelectItemAtIndex = ^(NSUInteger index) {
        NSLog(@"didSelectItemAtIndex: %@", @(index));
    };
    
    return self.infiniteScrollView;
}

- (CGSize)itemSize
{
    return CGSizeMake(kScreenWidth, 150);
}

- (CGFloat)itemSpacing
{
    return 0;
}

#pragma mark -
#pragma mark ================= 网络 =================
- (void)request
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [ZPHTTP wPost:@"/app/prd/gift/getHomeInfo" parameters:params success:^(id responseObject) {
        
        
        if ([responseObject[@"msgCode"] isEqualToString:kRequestSuccess])
        {
            self.modelIntegralHome = [ModelIntegralHome mj_objectWithKeyValues:[responseObject valueForKey:@"data"]];
            
            NSMutableArray *imageArray = [NSMutableArray array];
            for (LQModelIntegralHomeImage *modelIntegralHomeImage in self.modelIntegralHome.imageList)
            {
                LCFInfiniteScrollViewItem *item = [LCFInfiniteScrollViewItem itemWithImageURL:modelIntegralHomeImage.appPath text:nil];
                [imageArray addObject:item];
            }
            self.infiniteScrollView.items = imageArray;
            [self.tableView reloadData];
        }
        else
        {
            NSInteger errnoInteger = [responseObject[@"msgCode"] integerValue];
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : responseObject[@"msg"] };
            NSError *uError = [NSError errorWithDomain:@"ZPCustom"
                                                  code:errnoInteger
                                              userInfo:userInfo];
            kMRCError(uError.localizedDescription);
        }
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    }];
}

#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 2;
        }
            break;
            
        case 1:
        {
            if (self.modelIntegralHome)
            {
                return self.modelIntegralHome.giftList.count;
            }
            return 0;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0)
            {
                LQJIFenShangChengHomeCell1 *cell = [LQJIFenShangChengHomeCell1 cellWithTableView:tableView];
                return cell;
            }else{
                LQJIFenShangChengHomeCell2 *cell = [LQJIFenShangChengHomeCell2 cellWithTableView:tableView];
                
                __weak typeof(self) weakSelf = self;
                cell.clickBtn1 = ^(){
                    LQModelIntergralHometype *model = self.modelIntegralHome.typeList[0];
                    LQJiFengShangChengVC *vc = [[LQJiFengShangChengVC alloc] init];
                    vc.type = model.target;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                };
                cell.clickBtn2 = ^(){
                    LQModelIntergralHometype *model = self.modelIntegralHome.typeList[1];
                    LQJiFengShangChengVC *vc = [[LQJiFengShangChengVC alloc] init];
                    vc.type = model.target;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                };
                cell.clickBtn3 = ^(){
                    LQModelIntergralHometype *model = self.modelIntegralHome.typeList[2];
                    LQJiFengShangChengVC *vc = [[LQJiFengShangChengVC alloc] init];
                    vc.type = model.target;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                };
                cell.clickBtn4 = ^(){
                    LQModelIntergralHometype *model = self.modelIntegralHome.typeList[3];
                    LQJiFengShangChengVC *vc = [[LQJiFengShangChengVC alloc] init];
                    vc.type = model.target;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                };
                
                return cell;
            }
        }
            break;
        case 1:
        {
            LQJIFenShangChengHomeCell3 *cell = [LQJIFenShangChengHomeCell3 cellWithTableView:tableView];
            cell.model = self.modelIntegralHome.giftList[indexPath.row];
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            if (indexPath.row == 0)
            {
                return 35;
            }
            else
            {
                return kScreenWidth/2.25;
            }
        }
            break;
            
        default:
            break;
    }
    
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 10.0;
        }
            break;
        case 1:
        {
            return 15.0;
        }
            break;
            
        default:
            break;
    }
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 15)];
        footView.backgroundColor = [UIColor clearColor];
        
        UIView *line1= [[UIView alloc] init];
        line1.backgroundColor = [UIColor lightGrayColor];
        [footView addSubview:line1];
        
        UIView *line2= [[UIView alloc] init];
        line2.backgroundColor = [UIColor lightGrayColor];
        [footView addSubview:line2];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"推荐";
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        [footView addSubview:label];
        
        line1.sd_layout
        .leftSpaceToView(footView,0)
        .centerYEqualToView(footView)
        .widthIs(kScreenWidth/2 - 40)
        .heightIs(1);
        
        line2.sd_layout
        .rightSpaceToView(footView,0)
        .centerYEqualToView(footView)
        .widthIs(kScreenWidth/2 - 40)
        .heightIs(1);
        
        label.sd_layout
        .centerYEqualToView(footView)
        .centerXEqualToView(footView)
        .widthIs(40)
        .heightIs(10);
        
        return footView;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        LQModelGift *model = self.modelIntegralHome.giftList[indexPath.row];
        
        LQJiFenDuiHuanDetailVC *vc = [[LQJiFenDuiHuanDetailVC alloc] init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
