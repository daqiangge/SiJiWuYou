//
//  NetInfoVC.m
//  YouChengTire
//  网点信息
//  Created by WangZhipeng on 16/4/14.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "NetInfoVC.h"
// Controllers
#import "PersonalDataVC.h"
// ViewModels
#import "NetInfoVM.h"
#import "PersonalDataVM.h"
// Cells
#import "NetInfoCell.h"

static NSString *const kCellIdentifier = @"NetInfoCell";

@interface NetInfoVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, strong) NetInfoVM *netInfoVM;
@property (nonatomic, strong) PersonalDataVM *personalDataVM;

@property (nonatomic, weak) PersonalDataVC *previousVC;

@end

@implementation NetInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"netMapVC"]) {
        UIViewController *viewController = segue.destinationViewController;
        [viewController setValue:_personalDataVM
                          forKey:@"personalDataVM"];
    }
}

#pragma mark - View Lifecycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter]
       rac_addObserverForName:@"UIKeyboardWillShowNotification"
       object:nil] takeUntil:self.rac_willDeallocSignal]
     subscribeNext:^(NSNotification *notification) {
         @strongify(self);
         CGRect keyboardBounds = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
         self.baseTableView.contentInset = UIEdgeInsetsMake(self.baseTableView.contentInset.top,
                                                            0,
                                                            keyboardBounds.size.height,
                                                            0);
     }];
    
    [[[[NSNotificationCenter defaultCenter]
       rac_addObserverForName:@"UIKeyboardWillHideNotification"
       object:nil] takeUntil:self.rac_willDeallocSignal]
     subscribeNext:^(NSNotification *notification) {
         @strongify(self);
         self.baseTableView.contentInset = UIEdgeInsetsMake(self.baseTableView.contentInset.top,
                                                            0,
                                                            0,
                                                            0);
     }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - Override
- (void)configureView {
    [self configureNavigationController];
}

- (void)bindViewModel {
    RAC(self, title) = RACObserve(_netInfoVM, title);
    
    _netInfoVM.masterVC = self;
}

- (void)configureData {
    [self.baseTableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 531.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(NetInfoCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell bindViewModel:_netInfoVM];
    [cell configureCell:_personalDataVM.userDetailsM.point];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {}

#pragma mark - Private
- (void)configureNavigationController {
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(openRightMenu:)];
    [self.navigationItem setRightBarButtonItems:@[editBarButtonItem]];
    
    UIBarButtonItem *barBtnItem_back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:nil
                                                                       action:nil];
    [self.navigationItem setBackBarButtonItem:barBtnItem_back];
}

- (void)openRightMenu:(id)sender {
    NetInfoCell *cell = [self.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    _personalDataVM.userDetailsM.point.type = cell.sysPointType;
    [_previousVC requestUpdateUser];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setPersonalDataVM:(PersonalDataVM *)personalDataVM {
    _personalDataVM = personalDataVM;
}

- (void)setPreviousVC:(PersonalDataVC *)previousVC {
    _previousVC = previousVC;
}

@end
