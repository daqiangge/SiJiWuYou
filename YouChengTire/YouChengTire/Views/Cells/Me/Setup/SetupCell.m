//
//  SetupCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/1/24.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "SetupCell.h"

@implementation SetupCell

#pragma mark - Static Private
+ (NSArray *)loadNib {
    return [self loadNibNamed:@"SetupCell"];
}

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface SetupFirstCell ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation SetupFirstCell

#pragma mark - Override
+ (id)createCell {
    return [self loadNib][0];
}

- (void)setDictionary:(NSDictionary *)dictionary {
    [super setDictionary:dictionary];
    _logoImageView.image = GETIMAGE(dictionary[@"kLogoImage"]);
    _titleLabel.text = dictionary[@"kTitle"];
}

- (CGFloat)height { return 44.f; }

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@implementation SetupSecondCell

#pragma mark - Override
+ (id)createCell {
    return [self loadNib][1];
}

- (void)setDictionary:(NSDictionary *)dictionary {
    [super setDictionary:dictionary];
}

- (CGFloat)height { return 44.f; }

@end
