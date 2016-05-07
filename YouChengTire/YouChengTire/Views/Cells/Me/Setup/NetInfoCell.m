//
//  NetInfoCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/14.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "NetInfoCell.h"
// ViewModels
#import "NetInfoVM.h"
#import "PersonalDataVM.h"

@interface NetInfoCell ()

@property (nonatomic, weak) IBOutlet NetInfoItemView *itemView01;
@property (nonatomic, weak) IBOutlet NetInfoItemView *itemView02;
@property (nonatomic, weak) IBOutlet NetInfoItemView *itemView03;
@property (nonatomic, weak) IBOutlet NetInfoItemView *itemView04;

@property (nonatomic, weak) IBOutlet UIView *nameView;
@property (nonatomic, weak) IBOutlet UIView *contactView;
@property (nonatomic, weak) IBOutlet UIView *phoneView;
@property (nonatomic, weak) IBOutlet UIView *brandView;
@property (nonatomic, weak) IBOutlet UIView *scopeView;
@property (nonatomic, weak) IBOutlet UIView *chargeView;
@property (nonatomic, weak) IBOutlet UIView *freightView;
@property (nonatomic, weak) IBOutlet UIView *setupPriceView;
@property (nonatomic, weak) IBOutlet UIView *positionView;

@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UITextField *contactTextField;
@property (nonatomic, weak) IBOutlet UITextField *phoneTextField;
@property (nonatomic, weak) IBOutlet UITextField *brandTextField;
@property (nonatomic, weak) IBOutlet UITextField *scopeTextField;
@property (nonatomic, weak) IBOutlet UITextField *chargeTextField;
@property (nonatomic, weak) IBOutlet UITextField *freightPriceTextField;
@property (nonatomic, weak) IBOutlet UITextField *setupPriceTextField;
@property (nonatomic, weak) IBOutlet UITextField *positionTextField;

@property (nonatomic, strong) NetInfoVM *viewModel;

@property (nonatomic, strong) UITextField *tempTextField;
@property (nonatomic, strong) NSArray<NetInfoItemView *> *array;

@end

@implementation NetInfoCell

- (void)awakeFromNib {
    // Initialization code
    [self configureBorder:_nameView];
    [self configureBorder:_contactView];
    [self configureBorder:_phoneView];
    [self configureBorder:_brandView];
    [self configureBorder:_scopeView];
    [self configureBorder:_chargeView];
    [self configureBorder:_freightView];
    [self configureBorder:_setupPriceView];
    [self configureBorder:_positionView];
}

- (void)bindViewModel:(NetInfoVM *)viewModel {
    _viewModel = viewModel;
}

- (void)configureCell:(PointM *)model {
    NSArray<SysType *> *sysPointTypeArray = [UserM getUserM].sysPointTypeArray;
    for (NSInteger i = 0; i < sysPointTypeArray.count; i++) {
        if (i == 4) {
            break;
        }
        SysType *sysType = sysPointTypeArray[i];
        NetInfoItemView *itemView = self.array[i];
        itemView.sysType = sysType;
        itemView.hidden = NO;
        itemView.label.text = sysType.label;
    }
    
    NSArray<NSString *> *typeArray = @[];
    if (model.type.length > 0) {
        typeArray = [model.type componentsSeparatedByString:@","];
        for (NSInteger i = 0; i < typeArray.count; i++) {
            for (NetInfoItemView *itemView in self.array) {
                if ([typeArray[i] isEqualToString:itemView.sysType.value]) {
                    itemView.isSelect = YES;
                    break;
                }
            }
        }
    }
    
    _nameTextField.text = model.name;
    _contactTextField.text = model.contact;
    _phoneTextField.text = model.phone;
    _brandTextField.text = model.brand;
    _scopeTextField.text = model.scope;
    _chargeTextField.text = model.charge;
    _freightPriceTextField.text = model.freightPrice;
    _setupPriceTextField.text = model.setupPrice;
    _positionTextField.text = model.position;
    
    [[_nameTextField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(id x) {
         model.name = x;
     }];
    [[_contactTextField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(id x) {
         model.contact = x;
     }];
    [[_phoneTextField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(id x) {
         model.phone = x;
     }];
    [[_brandTextField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(id x) {
         model.brand = x;
     }];
    [[_scopeTextField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(id x) {
         model.scope = x;
     }];
    [[_chargeTextField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(id x) {
         model.charge = x;
     }];
    [[_freightPriceTextField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(id x) {
         model.freightPrice = x;
     }];
    [[_setupPriceTextField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(id x) {
         model.setupPrice = x;
     }];
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
        [_contactTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_contactTextField]) {
        [_phoneTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_phoneTextField]) {
        [_brandTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_brandTextField]) {
        [_scopeTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_scopeTextField]) {
        [_chargeTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_chargeTextField]) {
        [_freightPriceTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_freightPriceTextField]) {
        [_setupPriceTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return NO;
}

- (NSString *)sysPointType {
    NSString *sysPointType = @"";
    for (NetInfoItemView *itemView in self.array) {
        if (itemView.isSelect) {
            sysPointType = [sysPointType stringByAppendingFormat:@"%@,", itemView.sysType.value];
        }
    }
    if (sysPointType.length > 0) {
        sysPointType = [sysPointType substringToIndex:sysPointType.length - 1];
    }
    
    return sysPointType;
}

- (void)configureBorder:(UIView *)view {
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 4;
    view.layer.borderColor = RGB(153, 153, 153).CGColor;
}

- (NSArray<NetInfoItemView *> *)array {
    if (!_array) {
        _array = @[
                   _itemView01,
                   _itemView02,
                   _itemView03,
                   _itemView04
                   ];
    }
    return _array;
}

- (IBAction)touchUpInside_keyBoardExit:(id)sender {
    [_tempTextField resignFirstResponder];
}

- (IBAction)pointType:(id)sender {
    UIButton *button = (UIButton *)sender;
    NetInfoItemView *itemView = self.array[button.tag];
    itemView.isSelect = !itemView.isSelect;
}

- (IBAction)mapLocation:(id)sender {
    [_viewModel.masterVC performSegueWithIdentifier:@"netMapVC"
                                             sender:nil];
}

@end

@implementation NetInfoItemView

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    if (isSelect) {
        _imageView.image = GETIMAGE(@"ic_checkbox-click");
    }
    else {
        _imageView.image = GETIMAGE(@"ic_checkbox-nml");
    }
}

@end
