//
//  MeCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/23.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "MeCell.h"

@implementation MeCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Static Private
+ (NSArray *)loadNib {
    return [self loadNibNamed:@"MeCell"];
}

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface MeFirstCell ()

@property (weak, nonatomic) IBOutlet UIView *noLoginView;
@property (weak, nonatomic) IBOutlet UIView *loginView;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;

@end

@implementation MeFirstCell : MeCell

- (void)awakeFromNib {
    // Initialization code
    [self configureView];
}

#pragma mark - Override
+ (id)createCell {
    return [self loadNib][0];
}

- (void)setDictionary:(NSDictionary *)dictionary {
    [super setDictionary:dictionary];
    UserDetailsM *userDetailsM = dictionary[@"kUserDetailsM"];
    if (userDetailsM) {
        // 已登录
        [_headImageView yy_setImageWithURL:[NSURL URLWithString:userDetailsM.appPhoto]
                               placeholder:GETIMAGE(@"me_cell_head")];
        
        _noLoginView.hidden = YES;
        _loginView.hidden = NO;
        _nickname.text = userDetailsM.loginName;
        _phoneNumber.text = userDetailsM.mobile;
    }
    else {
        // 未登录
        _headImageView.image = GETIMAGE(@"me_cell_head");
        
        _noLoginView.hidden = NO;
        _loginView.hidden = YES;
        _nickname.text = @"";
        _phoneNumber.text = @"";
    }
}

- (CGFloat)height { return 80.f; }

- (void)configureView {
    [self configureImageView];
}

#pragma mark - Private
- (void)configureImageView {
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 55.f / 2;
}

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface MeSecondCell ()

@property (nullable, nonatomic, weak) IBOutlet UILabel *deliverFindLabel;

@end

@implementation MeSecondCell : MeCell

#pragma mark - Override
+ (id)createCell {
    return [self loadNib][1];
}

- (void)setDictionary:(NSDictionary *)dictionary {
    [super setDictionary:dictionary];
    // 发货收货
    UserM *userM = [UserM getUserM];
    // 服务网点（发货）
    if ([@"3" isEqualToString:userM.userDetailsM.userType]) {
        _deliverFindLabel.text = @"发货";
    }
    // 网络客户、网络车队（找货）
    else {
        _deliverFindLabel.text = @"找货";
    }
}

- (CGFloat)height { return 144.f; }

- (IBAction)didSelect:(id)sender {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(didSelectSecondCell:)]) {
            [self.delegate didSelectSecondCell:sender];
        }
    }
}

@end

/*****************************************************************************************
 * 三
 *****************************************************************************************/
@interface MeThirdCell ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation MeThirdCell : MeCell

#pragma mark - Override
+ (id)createCell {
    return [self loadNib][2];
}

- (void)setDictionary:(NSDictionary *)dictionary {
    [super setDictionary:dictionary];
    _logoImageView.image = GETIMAGE(dictionary[@"kLogoImage"]);
    _titleLabel.text = dictionary[@"kTitle"];
}

- (CGFloat)height { return 44.f; }

@end

/*****************************************************************************************
 * 四
 *****************************************************************************************/
@interface MeFourthCell ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation MeFourthCell : MeCell

#pragma mark - Override
+ (id)createCell {
    return [self loadNib][3];
}

- (void)setDictionary:(NSDictionary *)dictionary {
    [super setDictionary:dictionary];
    _logoImageView.image = GETIMAGE(dictionary[@"kLogoImage"]);
    _titleLabel.text = dictionary[@"kTitle"];
}

- (CGFloat)height { return 44.f; }

@end

/*****************************************************************************************
 * 五
 *****************************************************************************************/
@interface MeFifthCell ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation MeFifthCell : MeCell

#pragma mark - Override
+ (id)createCell {
    return [self loadNib][4];
}

- (void)setDictionary:(NSDictionary *)dictionary {
    [super setDictionary:dictionary];
    _logoImageView.image = GETIMAGE(dictionary[@"kLogoImage"]);
    _titleLabel.text = dictionary[@"kTitle"];
}

- (CGFloat)height { return 44.f; }

@end
