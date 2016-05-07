//
//  EditTireCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/11.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "EditTireCell.h"
// Pods
#import "RMPickerViewController.h"
#import "RMDateSelectionViewController.h"
// ViewModels
#import "EditTireVM.h"
// Models
#import "VehicleManagerM.h"

@interface EditTireCell () <
UIPickerViewDataSource,
UIPickerViewDelegate,
UITextFieldDelegate
>

@property (nonatomic, strong) EditTireVM *viewModel;

@property (nonatomic, weak) IBOutlet UITextField *seriesTextField;
@property (nonatomic, weak) IBOutlet UITextField *standardTextField;

@property (nonatomic, weak) IBOutlet UITextField *brandTextField;
@property (nonatomic, weak) IBOutlet UITextField *patternTextField;

@property (nonatomic, weak) IBOutlet UIButton *defaultButton;

@property (nonatomic, strong) UITextField *tempTextField;

@property (nonatomic, strong) VehicleTireM *model;
@property (nonatomic, strong) NSArray<VehicleBrandM *> *childrenArray;

@end

@implementation EditTireCell

- (void)bindViewModel:(EditTireVM *)viewModel {
    _viewModel = viewModel;
    
    RAC(viewModel.vehicleTireM, brand) = _brandTextField.rac_textSignal;
    RAC(viewModel.vehicleTireM, pattern) = _patternTextField.rac_textSignal;
}

- (void)configureCell:(VehicleTireM *)model {
    _model = model;
    
    _seriesTextField.text = model.series;
    _standardTextField.text = model.standard;
    _brandTextField.text = model.brand;
    _patternTextField.text = model.pattern;
    
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
    if ([textField isEqual:_brandTextField]) {
        [_patternTextField becomeFirstResponder];
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
            // 系列
            return _viewModel.standardArray.count;
        }
            break;
            
        case 2: {
            // 规格
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
            // 系列
            return _viewModel.standardArray[row].name;
        }
            break;
            
        case 2: {
            // 规格
            return _childrenArray[row].name;
        }
            break;
            
        default:
            return 0;
            break;
    }
}

- (void)selectSeries {
    @weakify(self)
    RMAction *selectAction = [RMAction
                              actionWithTitle:@"确定"
                              style:RMActionStyleDone
                              andHandler:^(RMActionController *controller) {
                                  @strongify(self)
                                  NSInteger row = [((RMPickerViewController *)controller).picker selectedRowInComponent:0];
                                  self.viewModel.vehicleTireM.series = _viewModel.standardArray[row].name;
                                  self.seriesTextField.text =  _viewModel.standardArray[row].name;
                                  self.childrenArray = _viewModel.standardArray[row].childrenArray;
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
    pickerController.picker.tag = 1;
    pickerController.picker.delegate = self;
    pickerController.picker.dataSource = self;
    
    //Now just present the picker controller using the standard iOS presentation method
    [_viewModel.viewController presentViewController:pickerController
                                            animated:YES
                                          completion:nil];
}

- (void)selectStandard {
    @weakify(self)
    RMAction *selectAction = [RMAction
                              actionWithTitle:@"确定"
                              style:RMActionStyleDone
                              andHandler:^(RMActionController *controller) {
                                  @strongify(self)
                                  NSInteger row = [((RMPickerViewController *)controller).picker selectedRowInComponent:0];
                                  self.viewModel.vehicleTireM.standard = self.childrenArray[row].name;
                                  self.standardTextField.text = self.childrenArray[row].name;
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

- (void)requestGetSeries {
    [MBProgressHUD showHUDAddedTo:ZPRootView
                         animated:NO];
    @weakify(self)
    [_viewModel requestGetSeries:^(id object) {
        @strongify(self)
        [self selectSeries];
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:ZPRootView
                             animated:YES];
    }];
}

- (IBAction)didSelectSeries:(id)sender {
    [self touchUpInside_keyBoardExit:nil];
    
    if (_viewModel.standardArray) {
        [self selectSeries];
    }
    else {
        [self requestGetSeries];
    }
}

- (IBAction)didSelectStandard:(id)sender {
    [self touchUpInside_keyBoardExit:nil];
    
    if (_childrenArray.count > 0) {
        [self selectStandard];
    }
    else {
        kMRCInfo(@"请选择系列");
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
