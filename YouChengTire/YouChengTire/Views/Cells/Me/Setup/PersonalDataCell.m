//
//  PersonalDataCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/10.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "PersonalDataCell.h"
// Pods
#import "RMPickerViewController.h"
// Tools
#import "ZPAreasManager.h"
// ViewModels
#import "PersonalDataVM.h"

@interface PersonalDataCell () <
UIPickerViewDelegate,
UIPickerViewDataSource,
UITextFieldDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate
>

@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UITextField *loginNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UITextField *mobileTextField;
@property (nonatomic, weak) IBOutlet UITextField *phoneTextField;
@property (nonatomic, weak) IBOutlet UITextField *addressTextField;
@property (nonatomic, weak) IBOutlet UITextField *addressDetailsTextField;
@property (nonatomic, weak) IBOutlet UITextField *userTypeTextField;

@property (nonatomic, strong) UITextField *tempTextField;
@property (nonatomic, strong) PersonalDataVM *viewModel;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@end

@implementation PersonalDataCell

- (void)awakeFromNib {
    // Initialization code
    [self configureImageView];
}

- (void)bindViewModel:(PersonalDataVM *)viewModel {
    _viewModel = viewModel;
    
    RAC(viewModel.userDetailsM, loginName) = _loginNameTextField.rac_textSignal;
    RAC(viewModel.userDetailsM, name) = _nameTextField.rac_textSignal;
    RAC(viewModel.userDetailsM, mobile) = _mobileTextField.rac_textSignal;
    RAC(viewModel.userDetailsM, phone) = _phoneTextField.rac_textSignal;
    RAC(viewModel.userDetailsM, address) = _addressDetailsTextField.rac_textSignal;
}

- (void)configureCell:(UserDetailsM *)model {
    [_logoImageView yy_setImageWithURL:[NSURL URLWithString:model.appPhoto]
                           placeholder:GETIMAGE(@"me_cell_head")];
    _loginNameTextField.text = model.loginName;
    _nameTextField.text = model.name;
    _mobileTextField.text = model.mobile;
    _phoneTextField.text = model.phone;
    _addressTextField.text = [NSString stringWithFormat:@"%@ %@ %@",
                              model.province,
                              model.city,
                              model.county];
    _addressDetailsTextField.text = model.address;
    
    for (SysType *sysType in [UserM getUserM].sysUserTypeArray) {
        if ([sysType.value isEqualToString:model.userType]) {
            _userTypeTextField.text = sysType.label;
            break;
        }
    }
}

#pragma mark - Private
- (void)configureImageView {
    _logoImageView.layer.masksToBounds = YES;
    _logoImageView.layer.cornerRadius = 54.f / 2;
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
    if ([textField isEqual:_loginNameTextField]) {
        [_nameTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_nameTextField]) {
        [_mobileTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_mobileTextField]) {
        [_phoneTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_phoneTextField]) {
        [self address:nil];
    }
    else {
        [textField resignFirstResponder];
    }
    return NO;
}

- (void)photograph {
    _imagePickerController = [UIImagePickerController new];
    _imagePickerController.navigationBar.barTintColor = RGB(238, 72, 72);
    _imagePickerController.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor] };
    _imagePickerController.navigationBar.tintColor = [UIColor whiteColor];
    _imagePickerController.delegate = self;
    _imagePickerController.allowsEditing = YES;
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self.viewModel.masterVC presentViewController:_imagePickerController
                                          animated:YES
                                        completion: ^{}];
}

- (void)album {
    _imagePickerController = [UIImagePickerController new];
    _imagePickerController.navigationBar.barTintColor = RGB(238, 72, 72);
    _imagePickerController.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor] };
    _imagePickerController.navigationBar.tintColor = [UIColor whiteColor];
    _imagePickerController.delegate = self;
    _imagePickerController.allowsEditing = YES;
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.viewModel.masterVC presentViewController:_imagePickerController
                                          animated:YES
                                        completion: ^{}];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.viewModel.fileImage = image;
    _logoImageView.image = image;
    [self.viewModel.masterVC dismissViewControllerAnimated:YES
                                                completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.viewModel.masterVC dismissViewControllerAnimated:YES
                                                completion:^{}];
}

#pragma mark- Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView.tag == 1) {
        return 1;
    }
    else {
        return 3;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        return [UserM getUserM].sysUserTypeArray.count;
    }
    else {
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
}

#pragma mark- Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        return [UserM getUserM].sysUserTypeArray[row].label;
    }
    else {
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
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        
    }
    else {
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
}

#pragma mark -
- (IBAction)touchUpInside_keyBoardExit:(id)sender {
    [_tempTextField resignFirstResponder];
}

- (IBAction)photo:(id)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil
                                                                     message:nil
                                                              preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photographAction = [UIAlertAction actionWithTitle:@"拍照"
                                                               style:UIAlertActionStyleDefault
                                                             handler: ^(UIAlertAction *action) {
                                                                 [self photograph];
                                                             }];
    [alertVC addAction:photographAction];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从手机相册选取"
                                                          style:UIAlertActionStyleDefault
                                                        handler: ^(UIAlertAction *action) {
                                                            [self album];
                                                        }];
    [alertVC addAction:albumAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler: ^(UIAlertAction *action) {
                                                         }];
    [alertVC addAction:cancelAction];
    [self.viewModel.masterVC presentViewController:alertVC
                                          animated:YES
                                        completion:nil];
}

- (IBAction)address:(id)sender {
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
                                  self.viewModel.userDetailsM.province = provinceStr;
                                  self.viewModel.userDetailsM.city = cityStr;
                                  self.viewModel.userDetailsM.county = districtStr;
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
    [_viewModel.masterVC presentViewController:pickerController
                                      animated:YES
                                    completion:nil];
}

- (IBAction)userType:(id)sender {
    [self touchUpInside_keyBoardExit:nil];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    NSArray<SysType *> *array = [UserM getUserM].sysUserTypeArray;
    for (NSInteger i = 0; i < array.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:array[i].label
                                                         style:UIAlertActionStyleDefault
                                                       handler: ^(UIAlertAction *action) {
                                                           [self alertResponse:i];
                                                       }];
        [alertController addAction:action];
    }
    [_viewModel.masterVC presentViewController:alertController
                                      animated:YES
                                    completion:nil];
}

- (void)alertResponse:(NSInteger)index {
    NSString *label = [UserM getUserM].sysUserTypeArray[index].label;
    self.userTypeTextField.text = label;
    self.viewModel.userDetailsM.userType = [UserM getUserM].sysUserTypeArray[index].value;
    if ([label isEqualToString:@"服务网点"]) {
        [_viewModel.masterVC performSegueWithIdentifier:@"netInfoVC"
                                                 sender:nil];
    }
}

@end



