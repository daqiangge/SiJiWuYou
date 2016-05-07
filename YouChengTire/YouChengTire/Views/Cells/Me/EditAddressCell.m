//
//  EditAddressCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/11.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "EditAddressCell.h"
// Pods
#import "RMPickerViewController.h"
#import "RMDateSelectionViewController.h"
// Tools
#import "ZPAreasManager.h"
// ViewModels
#import "EditAddressVM.h"
// Models
#import "ReceiptAddressM.h"

@interface EditAddressCell () <
UIPickerViewDelegate,
UIPickerViewDataSource,
UITextFieldDelegate
>

@property (nonatomic, strong) EditAddressVM *viewModel;

@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UITextField *mobileTextField;
@property (nonatomic, weak) IBOutlet UITextField *addressTextField;
@property (nonatomic, weak) IBOutlet UITextField *detailTextField;

@property (nonatomic, weak) IBOutlet UIButton *defaultButton;

@property (nonatomic, strong) UITextField *tempTextField;

@property (nonatomic, strong) ReceiptAddressItemM *model;

@end

@implementation EditAddressCell

- (void)bindViewModel:(EditAddressVM *)viewModel {
    _viewModel = viewModel;
    
    RAC(viewModel.receiptAddressItemM, name) = _nameTextField.rac_textSignal;
    RAC(viewModel.receiptAddressItemM, mobile) = _mobileTextField.rac_textSignal;
    RAC(viewModel.receiptAddressItemM, detail) = _detailTextField.rac_textSignal;
}

- (void)configureCell:(ReceiptAddressItemM *)model {
    _model = model;
    _nameTextField.text = model.name;
    _mobileTextField.text = model.mobile;
    if (model.province
        || model.city
        || model.county) {
        _addressTextField.text = [NSString stringWithFormat:@"%@ %@ %@",
                                  model.province,
                                  model.city,
                                  model.county];
    }
    _detailTextField.text = model.detail;
    if ([model.isDefault boolValue]) {
        [_defaultButton setTitle:@"取消默认" forState:UIControlStateNormal];
    }
    else {
        [_defaultButton setTitle:@"设为默认" forState:UIControlStateNormal];
    }
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    UIToolbar *keyBoard = [[NSBundle mainBundle] loadNibNamed:@"KeyBoardToolView"
                                                        owner:self
                                                      options:nil][0];
    textField.inputAccessoryView = keyBoard;
    self.tempTextField = textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:_nameTextField]) {
        [_mobileTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_mobileTextField]) {
        [_detailTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return NO;
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


- (IBAction)didSelectAreas:(id)sender {
    [self touchUpInside_keyBoardExit:nil];
    
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
                                  self.viewModel.receiptAddressItemM.province = provinceStr;
                                  self.viewModel.receiptAddressItemM.city = cityStr;
                                  self.viewModel.receiptAddressItemM.county = districtStr;
                                  self.addressTextField.text = [NSString stringWithFormat: @"%@ %@ %@", provinceStr, cityStr, districtStr];
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
    [_viewModel.viewController presentViewController:pickerController
                                            animated:YES
                                          completion:nil];
}

- (IBAction)didSelectDefault:(id)sender {
    _model.isDefault = [NSString stringWithFormat:@"%d", ![_model.isDefault boolValue]];
    if ([_model.isDefault boolValue]) {
        [_defaultButton setTitle:@"取消默认" forState:UIControlStateNormal];
    }
    else {
        [_defaultButton setTitle:@"设为默认" forState:UIControlStateNormal];
    }
}

- (IBAction)touchUpInside_keyBoardExit:(id)sender {
    [_tempTextField resignFirstResponder];
}

@end
