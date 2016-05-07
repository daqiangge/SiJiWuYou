//
//  EditVehicleCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/11.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "EditVehicleCell.h"
// Pods
#import "RMPickerViewController.h"
#import "RMDateSelectionViewController.h"
// ViewModels
#import "EditVehicleVM.h"
// Models
#import "VehicleManagerM.h"

@interface EditVehicleCell () <
UIPickerViewDataSource,
UIPickerViewDelegate,
UITextFieldDelegate
>

@property (nonatomic, strong) EditVehicleVM *viewModel;

@property (nonatomic, weak) IBOutlet UITextField *brandTextField;
@property (nonatomic, weak) IBOutlet UITextField *modelTextField;
@property (nonatomic, weak) IBOutlet UITextField *driveTextField;
@property (nonatomic, weak) IBOutlet UITextField *numberTextField;
@property (nonatomic, weak) IBOutlet UITextField *engineTextField;

@property (nonatomic, weak) IBOutlet UIButton *defaultButton;

@property (nonatomic, strong) UITextField *tempTextField;

@property (nonatomic, strong) VehicleTruckM *model;
@property (nonatomic, strong) NSArray<VehicleBrandM *> *childrenArray;

@end

@implementation EditVehicleCell

- (void)bindViewModel:(EditVehicleVM *)viewModel {
    _viewModel = viewModel;
    
    RAC(viewModel.vehicleTruckM, drive) = _driveTextField.rac_textSignal;
    RAC(viewModel.vehicleTruckM, number) = _numberTextField.rac_textSignal;
    RAC(viewModel.vehicleTruckM, engine) = _engineTextField.rac_textSignal;
}

- (void)configureCell:(VehicleTruckM *)model {
    _model = model;
    
    _brandTextField.text = model.brand;
    _modelTextField.text = model.model;
    _driveTextField.text = model.drive;
    _numberTextField.text = model.number;
    _engineTextField.text = model.engine;
    
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
    if ([textField isEqual:_driveTextField]) {
        [_numberTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_numberTextField]) {
        [_engineTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return NO;
}

#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (pickerView.tag) {
        case 1: {
            // 品牌
            return _viewModel.brandArray.count;
        }
            break;
            
        case 2: {
            // 车型
            return _childrenArray.count;
        }
            break;
            
        default:
            return 0;
            break;
    }
}

#pragma mark UIPickerViewDelegate
//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (pickerView.tag) {
        case 1: {
            // 品牌
            return _viewModel.brandArray[row].name;
        }
            break;
            
        case 2: {
            // 车型
            return _childrenArray[row].name;
        }
            break;
            
        default:
            return 0;
            break;
    }
}

- (void)selectBrand {
    @weakify(self)
    RMAction *selectAction = [RMAction
                              actionWithTitle:@"确定"
                              style:RMActionStyleDone
                              andHandler:^(RMActionController *controller) {
                                  @strongify(self)
                                  NSInteger row = [((RMPickerViewController *)controller).picker selectedRowInComponent:0];
                                  self.viewModel.vehicleTruckM.brand = _viewModel.brandArray[row].name;
                                  self.brandTextField.text = _viewModel.brandArray[row].name;
                                  self.childrenArray = _viewModel.brandArray[row].childrenArray;
                              }];
    
    
    RMAction *cancelAction = [RMAction
                              actionWithTitle:@"取消"
                              style:RMActionStyleCancel
                              andHandler:^(RMActionController *controller) {
                              }];
    
    //Create picker view controller
    RMPickerViewController *pickerController = [RMPickerViewController
                                                actionControllerWithStyle:RMActionControllerStyleDefault
                                                selectAction:selectAction andCancelAction:cancelAction];
    pickerController.disableBlurEffects = YES;
    pickerController.picker.tag = 1;
    pickerController.picker.delegate = self;
    pickerController.picker.dataSource = self;
    
    //Now just present the picker controller using the standard iOS presentation method
    [_viewModel.viewController presentViewController:pickerController
                                            animated:YES
                                          completion:nil];
}

- (void)selectModel {
    @weakify(self)
    RMAction *selectAction = [RMAction
                              actionWithTitle:@"确定"
                              style:RMActionStyleDone
                              andHandler:^(RMActionController *controller) {
                                  @strongify(self)
                                  NSInteger row = [((RMPickerViewController *)controller).picker selectedRowInComponent:0];
                                  self.viewModel.vehicleTruckM.model = self.childrenArray[row].name;
                                  self.modelTextField.text = self.childrenArray[row].name;
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
    pickerController.picker.tag = 2;
    pickerController.picker.delegate = self;
    pickerController.picker.dataSource = self;
    
    //Now just present the picker controller using the standard iOS presentation method
    [_viewModel.viewController presentViewController:pickerController
                                            animated:YES
                                          completion:nil];
}

- (void)requestGetBrands {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_viewModel requestGetBrands:^(id object) {
        @strongify(self)
        [self selectBrand];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (IBAction)didSelectBrand:(id)sender {
    [self touchUpInside_keyBoardExit:nil];
    
    if (_viewModel.brandArray) {
        [self selectBrand];
    }
    else {
        [self requestGetBrands];
    }
}

- (IBAction)didSelectModel:(id)sender {
    [self touchUpInside_keyBoardExit:nil];
    
    if (_childrenArray.count > 0) {
        [self selectModel];
    }
    else {
        kMRCInfo(@"请选择品牌");
    }
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
