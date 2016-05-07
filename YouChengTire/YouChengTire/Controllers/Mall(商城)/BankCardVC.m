//
//  BankCardVC.m
//  YouChengTire
//  选择银行卡
//  Created by WangZhipeng on 16/1/27.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BankCardVC.h"
// ViewModels
#import "BankCardVM.h"
// Cells
#import "BankCardCell.h"

static NSString *const kBankCardFirstCellIdentifier = @"BankCardFirstCell";
static NSString *const kBankCardSecondCellIdentifier = @"BankCardSecondCell";

@interface BankCardVC () <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) BankCardVM *bankCardVM;

@property (weak, nonatomic) IBOutlet UITableView *firstTableView;
@property (weak, nonatomic) IBOutlet UITableView *secondTableView;

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;

@end

@implementation BankCardVC

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
    RAC(self, title) = RACObserve(_bankCardVM, title);
    
    @weakify(self)
    [RACObserve(_bankCardVM, isFirstNumber)
     subscribeNext:^(NSNumber *isFirstNumber) {
         @strongify(self)
         BOOL isFirst = [isFirstNumber boolValue];
         self.firstTableView.hidden = !isFirst;
         self.firstView.hidden = !isFirst;
         
         self.secondTableView.hidden = isFirst;
         self.secondView.hidden = isFirst;
         
         if (isFirst) {
             self.firstLabel.textColor = RGB(49, 49, 49);
             self.secondLabel.textColor = RGB(153, 153, 153);
         }
         else {
             self.firstLabel.textColor = RGB(153, 153, 153);
             self.secondLabel.textColor = RGB(49, 49, 49);
         }
     }];
}

- (void)configureData {}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_firstTableView]) {
        return [tableView dequeueReusableCellWithIdentifier:kBankCardFirstCellIdentifier];
    }
    else {
        return [tableView dequeueReusableCellWithIdentifier:kBankCardSecondCellIdentifier];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {}

#pragma mark - Private
- (void)configureNavigationController {}

#pragma mark - Event Response
- (IBAction)switchFirst:(id)sender {
    [_bankCardVM switchFirst];
}

- (IBAction)switchSecond:(id)sender {
    [_bankCardVM switchSecond];
}

@end
