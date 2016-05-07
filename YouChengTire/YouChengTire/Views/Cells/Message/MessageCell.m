//
//  MessageCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/4.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "MessageCell.h"

@interface MessageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;

@end

@implementation MessageCell

#pragma mark - public
- (void)configureCell:(NSDictionary *)model {
    _logoImageView.image = GETIMAGE(model[@"kLogo"]);
    _titleLabel.text = model[@"kTitle"];
    _subtitleLabel.text = model[@"kSubtitle"];
    _dateTimeLabel.text = model[@"kDateTime"];
}

@end
