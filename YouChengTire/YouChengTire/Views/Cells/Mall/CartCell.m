//
//  CartCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/11.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "CartCell.h"
// Vendors
#import "NSString+WPAttributedMarkup.h"
#import "WPAttributedStyleAction.h"
#import "WPHotspotLabel.h"
// Models
#import "CartM.h"
// ViewModels
#import "CartVM.h"

@implementation CartCell

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface CartFirstCell ()

@property (nonatomic, weak) IBOutlet UIButton *selectButton;
@property (nonatomic, weak) IBOutlet UILabel *shopNameLabel;

@property (nullable, nonatomic, strong) CartM *model;

@end

@implementation CartFirstCell

- (void)configureCell:(CartM *)model {
    _model = model;
    
    _shopNameLabel.text = model.shopName;
    [self configureImageView:_model.isSelectNumber];
}

- (void)configureImageView:(NSNumber *)isSelectNumber {
    if ([isSelectNumber boolValue]) {
        [_selectButton setImage:GETIMAGE(@"me_option_red_big")
                       forState:UIControlStateNormal];
    }
    else {
        [_selectButton setImage:GETIMAGE(@"me_option_grey_big")
                       forState:UIControlStateNormal];
    }
}

- (IBAction)select:(id)sender {
    _model.isSelectNumber = @(![_model.isSelectNumber boolValue]);
    [self configureImageView:_model.isSelectNumber];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(didSelectSection:isSelect:)]) {
            [self.delegate didSelectSection:self isSelect:_model.isSelectNumber];
        }
    }
}

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface CartSecondCell ()

@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UIButton *selectButton;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UILabel *countLabel;
@property (nonatomic, weak) IBOutlet UIView *editView;
@property (nonatomic, weak) IBOutlet UITextField *countTextField;

@property (nullable, nonatomic, strong) CartVM *viewModel;
@property (nullable, nonatomic, strong) CartProductM *model;

@end

@implementation CartSecondCell

- (void)bindViewModel:(CartVM *)viewModel {
    _viewModel = viewModel;
    @weakify(self)
    [RACObserve(viewModel, isEditNumber) subscribeNext:^(NSNumber *isEditNumber) {
        @strongify(self)
        self.editView.hidden = ![isEditNumber boolValue];
    }];
}

- (void)configureCell:(CartProductM *)model {
    _model = model;
    [_logoImageView yy_setImageWithURL:[NSURL URLWithString:model.product.appPhoto]
                           placeholder:nil];
    _nameLabel.text = model.product.name;    
    NSDictionary *priceStyle = @{ @"price" :
                                      @[[UIFont systemFontOfSize:12.f],
                                        RGB(153, 153, 153),
                                        @{ NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle) }]
                                  };
    _priceLabel.attributedText = [[NSString stringWithFormat:@"￥ %.2f  <price>￥ %.2f</price>",
                                   [model.product.price floatValue],
                                   [model.product.oldPrice floatValue]] attributedStringWithStyleBook:priceStyle];
    
    _countLabel.text = [NSString stringWithFormat:@"x %@", model.count];
    
    _countTextField.text = model.count;
    
    [self configureImageView:_model.isSelectNumber];
}

- (void)configureImageView:(NSNumber *)isSelectNumber {
    if ([isSelectNumber boolValue]) {
        [_selectButton setImage:GETIMAGE(@"me_option_red")
                       forState:UIControlStateNormal];
    }
    else {
        [_selectButton setImage:GETIMAGE(@"me_option_grey")
                       forState:UIControlStateNormal];
    }
}

- (void)requestSaveCartCount {
    [MBProgressHUD showHUDAddedTo:_viewModel.masterVC.navigationController.view
                         animated:NO];
    [_viewModel requestSaveCartCount:^(id object) {
        NSString *productCount = _viewModel.productCount;
        _countTextField.text = productCount;
        _countLabel.text = [NSString stringWithFormat:@"x %@", productCount];
        _model.count = productCount;
    } error:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } failure:^(NSError *error) {
        kMRCError(error.localizedDescription);
    } completion:^{
        [MBProgressHUD hideHUDForView:_viewModel.masterVC.navigationController.view
                             animated:YES];
    }];
}

- (IBAction)select:(id)sender {
    _model.isSelectNumber = @(![_model.isSelectNumber boolValue]);
    [self configureImageView:_model.isSelectNumber];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(didSelectRow:isSelect:)]) {
            [self.delegate didSelectRow:self isSelect:_model.isSelectNumber];
        }
    }
}

- (IBAction)plus:(id)sender {
    if (![_model.count isEqualToString:@"99"]) {
        NSInteger count = [_model.count integerValue];
        count = count + 1;
        _viewModel.productId = _model.sId;
        _viewModel.productCount = [NSString stringWithFormat:@"%ld", (long)count];
        [self requestSaveCartCount];
    }
}

- (IBAction)reduce:(id)sender {
    if (![_model.count isEqualToString:@"1"]) {
        NSInteger count = [_model.count integerValue];
        count = count - 1;
        _viewModel.productId = _model.sId;
        _viewModel.productCount = [NSString stringWithFormat:@"%ld", (long)count];
        [self requestSaveCartCount];
    }
}

@end
