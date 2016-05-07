//
//  RescueBySelfListVC.m
//  YouChengTire
//
//  Created by Baby on 16/3/31.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "RescueBySelfListVC.h"
#import "RescueCell.h"
#import "RescueVM.h"
#import "AppDelegate.h"
#import "RescueBySelfDetailsVC.h"

@interface RescueBySelfListVC ()<RescueThirdDelegate>
@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (nonatomic, strong) NearbyPointM *nearbyPointM;
@property (nonatomic, strong) UserPointM *userPointM;

@property (strong, nonatomic) RescueVM * rescueVM;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBottomConstraint;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBottomConstraint;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RescueBySelfListVC

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"救援";
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_service_map"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    self.rescueVM = [[RescueVM alloc] init];
    self.location = [AppDelegate appDelegete].loc;
    [self buttonClicked:self.leftBtn];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)buttonClicked:(UIButton *)sender {
    if (sender == self.leftBtn) {
        self.leftBtn.selected = YES;
        self.rightBtn.selected = NO;
        self.leftBottomConstraint.constant = 2.0f;
        self.rightBottomConstraint.constant = 0.0f;
        
//        NSString * lat = [NSString stringWithFormat:@"%f",self.location.latitude];
//        NSString * lng = [NSString stringWithFormat:@"%f",self.location.longitude];
        NSDictionary * data = @{@"lng":self.lng,@"lat":self.lat};
        [self requestServiceWithParams:@{@"lng":self.lng,@"lat":self.lat,@"appKey":[BaseVM createAppKey:data]} isLeft:YES];
    }else{
        self.leftBtn.selected = NO;
        self.rightBtn.selected = YES;
        self.leftBottomConstraint.constant = 0.0f;
        self.rightBottomConstraint.constant = 2.0f;
        
        NSMutableDictionary * params = @{@"pageNo":@"1",@"pageSize":@"10"}.mutableCopy;
        [params setObject:[BaseVM createAppKey:params] forKey:@"appKey"];
        [self requestServiceWithParams:params isLeft:NO];
    }
}

- (void)requestServiceWithParams:(NSDictionary *)_params isLeft:(BOOL)_isLeft{
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    if (_isLeft) {
        // 附近商家
        [_rescueVM requestGetNearbyPointList:^(id object) {
            @strongify(self)
            self.nearbyPointM = object;
            [self.tableView reloadData];
        } data:_params error:^(NSError *error) {
            kMRCError(error.localizedDescription);
        } failure:^(NSError *error) {
            kMRCError(error.localizedDescription);
        } completion:^{
            [MBProgressHUD hideHUDForView:ZPRootView
                                 animated:YES];
        }];
    }else{
        // 常用商家
        [_rescueVM requestGetUsedPointList:^(id object) {
            self.nearbyPointM = object;
            [self.tableView reloadData];
        } data:_params error:^(NSError *error) {
            kMRCError(error.localizedDescription);
        } failure:^(NSError *error) {
            kMRCError(error.localizedDescription);
        } completion:^{
            [MBProgressHUD hideHUDForView:ZPRootView
                                 animated:YES];
        }];
    }
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (self.leftBtn.selected) {
//        return self.nearbyPointM.pointList.count;
//    }else{
//        return self.nearbyPointM.pointList.count;
//    }
    
    return self.nearbyPointM.pointList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RescueThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RESCUE_THIRD_CELL_ID"];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(RescueThirdCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (self.leftBtn.selected) {
//        [cell refrashData:[self.nearbyPointM.pointList objectAtIndex:indexPath.section] idex:indexPath];
//    }else{
//        [cell refrashData:[self.nearbyPointM.pointList objectAtIndex:indexPath.section] idex:indexPath];
//    }
    
    [cell refrashData:[self.nearbyPointM.pointList objectAtIndex:indexPath.section] idex:indexPath];
}

# pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = returnButtonItem;
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Rescue" bundle:[NSBundle mainBundle]];
    RescueBySelfDetailsVC * vc = [sb instantiateViewControllerWithIdentifier:@"RescueBySelfDetailsVC"];
    vc.np = [self.nearbyPointM.pointList objectAtIndex:indexPath.section];
    vc.rescueId = self.rescueId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickButtonWithIndex:(NSIndexPath *)_index{
    NearbyPointItemM * np = [self.nearbyPointM.pointList objectAtIndex:_index.section];
    NSString * phoneNum = [NSString stringWithFormat:@"tel:%@",np.mobile];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneNum]]];
    [self.view addSubview:callWebview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
