//
//  HomeCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "HomeCell.h"
// Models
#import "HomeM.h"

@implementation HomeCell

#pragma mark - Static Private
+ (NSArray *)loadNib {
    return [self loadNibNamed:@"HomeCell"];
}

+ (instancetype)createCell { return nil; }

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@implementation HomeFirstCell

#pragma mark - Override
+ (instancetype)createCell {
    return [self loadNib][0];
}

- (CGFloat)height { return 110.f; }

- (IBAction)didSelect:(id)sender {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(didSelectFirstCell:)]) {
            [self.delegate didSelectFirstCell:sender];
        }
    }
}

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface HomeSecondCell()

@property (weak, nonatomic) IBOutlet UILabel *deliverFindLabel;

@end

@implementation HomeSecondCell

#pragma mark - Override
+ (instancetype)createCell {
    return [self loadNib][1];
}

- (CGFloat)height { return 144.f; }

- (IBAction)didSelect:(id)sender {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(didSelectSecondCell:)]) {
            [self.delegate didSelectSecondCell:sender];
        }
    }
}


- (void)configureCell:(NSDictionary *)dictionary
{
    self.dictionary = dictionary;
    // 发货收货
    UserM *userM = [UserM getUserM];
    // 服务网点（发货）
    if ([@"3" isEqualToString:userM.userDetailsM.userType])
    {
        _deliverFindLabel.text = @"发货";
    }
    // 网络客户、网络车队（找货）
    else
    {
        _deliverFindLabel.text = @"找货";
    }
}

@end

/*****************************************************************************************
 * 三
 *****************************************************************************************/
@interface  HomeThirdCell ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView01;
@property (nonatomic, weak) IBOutlet UIImageView *imageView02;
@property (nonatomic, weak) IBOutlet UIImageView *imageView03;
@property (nonatomic, weak) IBOutlet UIImageView *imageView04;

@property (nonatomic, strong) NSArray<UIImageView *> *imageViewArray;

@end

@implementation HomeThirdCell

#pragma mark - Override
+ (instancetype)createCell {
    return [self loadNib][2];
}

//- (void)setDictionary:(NSDictionary *)dictionary {
//    [super setDictionary:dictionary];
//    NSArray<HomePictureM *> *homePictureArray = dictionary[@"kArray"];
//    for (NSInteger i = 0; i < self.imageViewArray.count; i++) {
//        [self.imageViewArray[i] yy_setImageWithURL:[NSURL URLWithString:homePictureArray[i].path]
//                                       placeholder:nil];
//    }
//}

- (void)configureCell:(NSDictionary *)dictionary {
    self.dictionary = dictionary;
    NSArray<HomePictureM *> *homePictureArray = dictionary[kArray];
    for (NSInteger i = 0; i < homePictureArray.count; i++) {
        [self.imageViewArray[i] yy_setImageWithURL:[NSURL URLWithString:homePictureArray[i].path]
                                       placeholder:nil];
    }
}

- (CGFloat)height { return 160.f; }

- (NSArray<UIImageView *> *)imageViewArray {
    if (!_imageViewArray) {
        _imageViewArray = @[
                            _imageView01,
                            _imageView02,
                            _imageView03,
                            _imageView04
                            ];
    }
    return _imageViewArray;
}

- (IBAction)didSelect:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSArray<HomePictureM *> *homePictureArray = self.dictionary[kArray];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(didSelectThirdCell:)]) {
            [self.delegate didSelectThirdCell:homePictureArray[button.tag].target];
        }
    }
}

@end

/*****************************************************************************************
 * 四
 *****************************************************************************************/
@interface  HomeFourthCell ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView01;
@property (nonatomic, weak) IBOutlet UIImageView *imageView02;
@property (nonatomic, weak) IBOutlet UIImageView *imageView03;
@property (nonatomic, weak) IBOutlet UIImageView *imageView04;

@property (nonatomic, strong) NSArray<UIImageView *> *imageViewArray;

@end

@implementation HomeFourthCell

#pragma mark - Override
+ (instancetype)createCell {
    return [self loadNib][3];
}

//- (void)setDictionary:(NSDictionary *)dictionary {
//    [super setDictionary:dictionary];
//    NSArray<HomePictureM *> *homePictureArray = dictionary[@"kArray"];
//    for (NSInteger i = 0; i < self.imageViewArray.count; i++) {
//        [self.imageViewArray[i] yy_setImageWithURL:[NSURL URLWithString:homePictureArray[i].path]
//                                       placeholder:nil];
//    }
//}

- (void)configureCell:(NSDictionary *)dictionary {
    self.dictionary = dictionary;
    NSArray<HomePictureM *> *homePictureArray = dictionary[kArray];
    for (NSInteger i = 0; i < homePictureArray.count; i++) {
        [self.imageViewArray[i] yy_setImageWithURL:[NSURL URLWithString:homePictureArray[i].path]
                                       placeholder:nil];
    }
}

- (CGFloat)height { return 160.f; }

- (NSArray<UIImageView *> *)imageViewArray {
    if (!_imageViewArray) {
        _imageViewArray = @[
                            _imageView01,
                            _imageView02,
                            _imageView03,
                            _imageView04
                            ];
    }
    return _imageViewArray;
}

- (IBAction)didSelect:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSArray<HomePictureM *> *homePictureArray = self.dictionary[kArray];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(didSelectFourthCell:)]) {
            [self.delegate didSelectFourthCell:homePictureArray[button.tag].target];
        }
    }
}

@end

/*****************************************************************************************
 * 五
 *****************************************************************************************/
@interface HomeFifthCell ()

@property (weak, nonatomic) IBOutlet UIView *identityView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation HomeFifthCell

#pragma mark - Override
+ (instancetype)createCell {
    return [self loadNib][4];
}

//- (void)setDictionary:(NSDictionary *)dictionary {
//    [super setDictionary:dictionary];
//    _identityView.backgroundColor = dictionary[@"kColor"];
//    _titleLabel.text = dictionary[@"kTitle"];
//}

- (void)configureCell:(NSDictionary *)dictionary {
    self.dictionary = dictionary;
    _identityView.backgroundColor = dictionary[kColor];
    _titleLabel.text = dictionary[kTitle];
}

- (CGFloat)height { return 36.f; }

@end

/*****************************************************************************************
 * 六
 *****************************************************************************************/
@interface HomeSixthCell ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

@implementation HomeSixthCell : HomeCell

#pragma mark - Override
+ (instancetype)createCell {
    return [self loadNib][5];
}

//- (void)setDictionary:(NSDictionary *)dictionary {
//    [super setDictionary:dictionary];
//    _logoImageView.image = GETIMAGE(dictionary[@"kLogo"]);
//    _titleLabel.text = dictionary[@"kTitle"];
//    _subtitleLabel.text = dictionary[@"kSubtitle"];
//}

- (void)configureCell:(NSDictionary *)dictionary {
    self.dictionary = dictionary;
    _logoImageView.image = GETIMAGE(dictionary[@"kLogo"]);
    _titleLabel.text = dictionary[kTitle];
    _subtitleLabel.text = dictionary[@"kSubtitle"];
}

- (CGFloat)height { return 60.f; }

@end


