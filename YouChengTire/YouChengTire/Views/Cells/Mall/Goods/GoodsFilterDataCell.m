//
//  GoodsFilterDataCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/4/18.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "GoodsFilterDataCell.h"
// Models
#import "GoodsFilterDataM.h"

@interface GoodsFilterDataCell ()

@property (nullable, nonatomic, weak) IBOutlet UILabel *valueLabel;
@property (nullable, nonatomic, weak) IBOutlet UIImageView *statusImageView;

@end

@implementation GoodsFilterDataCell

- (void)configureCell:(GoodsFilterDataM *)model {
    _valueLabel.text = model.name;
    
    @weakify(self)
    [[RACObserve(model, isSelectNumber)
      takeUntil:self.rac_prepareForReuseSignal]
     subscribeNext:^(NSNumber *isSelect) {
         @strongify(self)
         self.statusImageView.hidden = ![isSelect boolValue];
     }];
}

@end
