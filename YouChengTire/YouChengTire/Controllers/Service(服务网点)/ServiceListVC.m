//
//  ServiceListVC.m
//  YouChengTire
//
//  Created by Baby on 16/2/29.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "ServiceListVC.h"
#import "ServiceCell.h"
#import "ServiceVM.h"
#import "AppDelegate.h"
#import "ZPAreasManager.h"
#import "RMPickerViewController.h"
#import "LQServiceDetailVC.h"

#define TYPESTABLECELL_HEIGHT   44

@interface ServiceListVC ()<UIPickerViewDelegate,UIPickerViewDataSource,ServiceFirstCellDelegate>
{
    NSArray * areaArray;
    NSArray * typesArray;
}

@property (nonatomic, strong) ServiceVM * serviceVM;
@property (nonatomic, strong) NearbyPointM *nearbyPointM;
@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (copy, nonatomic) NSString * lat;
@property (copy, nonatomic) NSString * lng;


@property (weak, nonatomic) IBOutlet UIButton *areaButton;
@property (weak, nonatomic) IBOutlet UIButton *typeButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typesTableHeightConstraint;
@property (weak, nonatomic) IBOutlet UITableView *typesTable;
@property (weak, nonatomic) IBOutlet UITableView *contentTable;

@property (copy, nonatomic) NSString * proviceStr;
@property (copy, nonatomic) NSString * cityStr;
@property (copy, nonatomic) NSString * districtStr;
@property (copy, nonatomic) NSString * typeStr;
@end

@implementation ServiceListVC


- (void)selectedArea{
    @weakify(self)
    RMAction *selectAction = [RMAction
                              actionWithTitle:@"确定"
                              style:RMActionStyleDone
                              andHandler:^(RMActionController *controller) {
                                  @strongify(self)
                                  UIPickerView *picker = ((RMPickerViewController *)controller).picker;
                                  NSInteger provinceIndex = [picker selectedRowInComponent: PROVINCE_COMPONENT];
                                  NSInteger cityIndex = [picker selectedRowInComponent: CITY_COMPONENT];
                                  NSInteger districtIndex = [picker selectedRowInComponent: DISTRICT_COMPONENT];
                                  
                                  NSString *provinceStr = [ZPAreasManager sharedManager].province[provinceIndex];
                                  NSString *cityStr = [ZPAreasManager sharedManager].city[cityIndex];
                                  NSString *districtStr = [ZPAreasManager sharedManager].district[districtIndex];
                                  
                                  if ([provinceStr isEqualToString: cityStr] && [cityStr isEqualToString: districtStr]) {
                                      cityStr = @"";
                                      districtStr = @"";
                                  }
                                  else if ([cityStr isEqualToString: districtStr]) {
                                      districtStr = @"";
                                  }
                                  self.proviceStr = provinceStr;
                                  self.cityStr = cityStr;
                                  self.districtStr = districtStr;
                                  [self requestService];
                              }];
    
    
    RMAction *cancelAction = [RMAction
                              actionWithTitle:@"取消"
                              style:RMActionStyleCancel
                              andHandler:^(RMActionController *controller) {
                                  // TODO
                              }];
    
    //Create picker view controller
    RMPickerViewController *pickerController = [RMPickerViewController
                                                actionControllerWithStyle:RMActionControllerStyleDefault
                                                selectAction:selectAction andCancelAction:cancelAction];
    pickerController.disableBlurEffects = YES;
    pickerController.picker.delegate = self;
    pickerController.picker.dataSource = self;
    
    //Now just present the picker controller using the standard iOS presentation method
    [self presentViewController:pickerController
                                            animated:YES
                                          completion:nil];
}

- (void)requestService{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.lng forKey:@"lng"];
    [param setValue:self.lat forKey:@"lat"];
    [param setValue:self.typeStr forKey:@"type"];
    [param setValue:self.proviceStr forKey:@"province"];
    [param setValue:self.cityStr forKey:@"city"];
    [param setValue:self.districtStr forKey:@"county"];
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [self.serviceVM requestGetPointList:^(id object) {
        @strongify(self)
        self.nearbyPointM = object;
        [self.contentTable reloadData];
    } data:param error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.contentTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    areaArray = @[@"选择地区"];
    typesArray = @[@"全部",@"产品销售",@"救援",@"车辆修理"];
    _typesTableHeightConstraint.constant = 0;
    self.serviceVM = [[ServiceVM alloc] init];
    
    self.location = [AppDelegate appDelegete].loc;
    self.lat = [NSString stringWithFormat:@"%f",self.location.latitude];
    self.lng = [NSString stringWithFormat:@"%f",self.location.longitude];
    self.typeStr = @"1";
    self.proviceStr = [AppDelegate appDelegete].locState;
    self.cityStr = [AppDelegate appDelegete].locCity;
    self.districtStr = [AppDelegate appDelegete].locSubLocality;
    [self requestService];
}


- (IBAction)typeButtonClicked:(UIButton *)sender {
    if (sender == _areaButton) {
        _areaButton.selected = !_areaButton.selected;
        _typeButton.selected = NO;
        if (_areaButton.selected) {
            //
            [self refrashTypeTableWithData:areaArray];
        }else{
            // cancel
            [self hidedTypeTable];
        }
    }
    
    if (sender == _typeButton) {
        _typeButton.selected = !_typeButton.selected;
        _areaButton.selected = NO;
        if (_typeButton.selected) {
            //
            [self refrashTypeTableWithData:typesArray];
        }else{
            // cancel
            [self hidedTypeTable];
        }
    }
}

- (void)refrashTypeTableWithData:(NSArray *)_array{
    [UIView animateWithDuration:0.35 animations:^{
         _typesTableHeightConstraint.constant = [_array count] * TYPESTABLECELL_HEIGHT;
        [self.view layoutIfNeeded];
        [_typesTable reloadData];
    }];
}

- (void)hidedTypeTable{
    [UIView animateWithDuration:0.35 animations:^{
        _typesTableHeightConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _typesTable) {
        return 1;
    }else{
        return [self.nearbyPointM.pointList count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _typesTable) {
        if (_areaButton.selected) {
            return [areaArray count];
        }
        if (_typeButton.selected) {
            return [typesArray count];
        }
        return 0;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _typesTable) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TYPES_CELL_IDENTIFIER"];
        if (_areaButton.selected) {
            cell.textLabel.text = [areaArray objectAtIndex:indexPath.row];
        }
        if (_typeButton.selected) {
            cell.textLabel.text = [typesArray objectAtIndex:indexPath.row];
        }
        return cell;
    }else{
        ServiceFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SERVICE_FIRST_CELL_IDENTIFIER"];
        cell.delegate = self;
        return cell;;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ServiceFirstCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _contentTable) {
        [cell refrashData:[self.nearbyPointM.pointList objectAtIndex:indexPath.section] index:indexPath];
    }
}

# pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _typesTable) {
        return 0.0f;
    }else{
        return 10.f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _typesTable) {
        return TYPESTABLECELL_HEIGHT;
    }else{
        return 88.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == _typesTable) {
        return 0.0f;
    }else{
        return 1.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _typesTable) {
        [self hidedTypeTable];
        if (_areaButton.selected) {
            [self selectedArea];
        }
        if (_typeButton.selected) {
            self.typeStr = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
            [self requestService];
        }
        _areaButton.selected = _typeButton.selected = NO;
        
    }else{
        NearbyPointItemM *model = [self.nearbyPointM.pointList objectAtIndex:indexPath.section];
        // 详情 section
        LQServiceDetailVC *vc = [[LQServiceDetailVC alloc] init];
        vc.serviewID = model.sId;
        [self.navigationController pushViewController:vc animated:YES];
        
        
//        [self performSegueWithIdentifier:@"SERVICE_DETAILS_VC" sender:nil];
    }
}

#pragma mark- Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == PROVINCE_COMPONENT) {
        return [ZPAreasManager sharedManager].province.count;
    }
    else if (component == CITY_COMPONENT) {
        return [ZPAreasManager sharedManager].city.count;
    }
    else {
        return [ZPAreasManager sharedManager].district.count;
    }
}

#pragma mark- Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == PROVINCE_COMPONENT) {
        return [ZPAreasManager sharedManager].province[row];
    }
    else if (component == CITY_COMPONENT) {
        return [ZPAreasManager sharedManager].city[row];
    }
    else {
        return [ZPAreasManager sharedManager].district[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSDictionary *areaDic = [ZPAreasManager sharedManager].areaDic;
    NSArray *province = [ZPAreasManager sharedManager].province;
    
    if (component == PROVINCE_COMPONENT) {
        [ZPAreasManager sharedManager].selectedProvince = [province objectAtIndex: row];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: [NSString stringWithFormat:@"%ld", (long)row]]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: [ZPAreasManager sharedManager].selectedProvince]];
        NSArray *cityArray = [dic allKeys];
        NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;//递减
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;//上升
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i=0; i<[sortedArray count]; i++) {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *temp = [[dic objectForKey: index] allKeys];
            [array addObject: [temp objectAtIndex:0]];
        }
        
        [ZPAreasManager sharedManager].city = [[NSArray alloc] initWithArray: array];
        
        NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
        [ZPAreasManager sharedManager].district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [ZPAreasManager sharedManager].city[0]]];
        [pickerView selectRow: 0 inComponent: CITY_COMPONENT animated: YES];
        [pickerView selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [pickerView reloadComponent: CITY_COMPONENT];
        [pickerView reloadComponent: DISTRICT_COMPONENT];
        
    }
    else if (component == CITY_COMPONENT) {
        NSString *provinceIndex = [NSString stringWithFormat: @"%lu", (unsigned long)[province indexOfObject: [ZPAreasManager sharedManager].selectedProvince]];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: provinceIndex]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: [ZPAreasManager sharedManager].selectedProvince]];
        NSArray *dicKeyArray = [dic allKeys];
        NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: row]]];
        NSArray *cityKeyArray = [cityDic allKeys];
        
        [ZPAreasManager sharedManager].district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityKeyArray objectAtIndex:0]]];
        [pickerView selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [pickerView reloadComponent: DISTRICT_COMPONENT];
    }
}


- (void)callClickedWithIndex:(NSIndexPath *)_index{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
