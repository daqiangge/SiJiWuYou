//
//  OrderAddRemarkCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/5/1.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "OrderAddRemarkCell.h"
// Tools
#import "ZPMarkStarV.h"
// Models
#import "OrderFrameM.h"
// ViewModels
#import "OrderAddRemarkVM.h"

#import "MLPhotoBrowserViewController.h"

@implementation OrderAddRemarkCell

@end

/*****************************************************************************************
 * 一
 *****************************************************************************************/
@interface OrderAddRemarkFirstCell ()

@property (nullable, nonatomic, weak) IBOutlet UILabel *belongNameLabel;

@end

@implementation OrderAddRemarkFirstCell

- (void)configureCell:(NSDictionary *)model {
    OrderFrameM *orderFrameM = model[kModel];
    _belongNameLabel.text = orderFrameM.belongName;
}

@end

/*****************************************************************************************
 * 二
 *****************************************************************************************/
@interface OrderAddRemarkSecondCell ()

@property (nullable, nonatomic, weak) IBOutlet UIImageView *logoImageView;

@property (nullable, nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nullable, nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nullable, nonatomic, weak) IBOutlet UILabel *countLabel;

@end

@implementation OrderAddRemarkSecondCell

- (void)configureCell:(NSDictionary *)model {
    NSDictionary *dictionary = model[kModel];
    _countLabel.text = [NSString stringWithFormat:@"x %@", dictionary[@"count"]];
    OrderFrameProductM *orderFrameProductM = [OrderFrameProductM yy_modelWithDictionary:dictionary[@"product"]];
    [_logoImageView yy_setImageWithURL:[NSURL URLWithString:orderFrameProductM.photo]
                           placeholder:nil];
    _titleLabel.text = orderFrameProductM.name;
    _priceLabel.text = [NSString stringWithFormat:@"￥ %@", orderFrameProductM.price];
}

@end

/*****************************************************************************************
 * 三
 *****************************************************************************************/
@interface OrderAddRemarkThirdCell () <
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
MLPhotoBrowserViewControllerDataSource,
MLPhotoBrowserViewControllerDelegate
>

@property (nullable, nonatomic, weak) IBOutlet UIView *starContentV;
@property (nullable, nonatomic, weak) IBOutlet UIView *textContentV;

@property (nullable, nonatomic, weak) IBOutlet UITextView *remarkTextView;
@property (nullable, nonatomic, weak) IBOutlet UITextField *opinionTextField;

@property (nullable, nonatomic, weak) IBOutlet OrderAddRemarkThirdV *firstV;
@property (nullable, nonatomic, weak) IBOutlet OrderAddRemarkThirdV *secondV;
@property (nullable, nonatomic, weak) IBOutlet OrderAddRemarkThirdV *thirdV;
@property (nullable, nonatomic, weak) IBOutlet OrderAddRemarkThirdV *fourthV;
@property (nullable, nonatomic, weak) IBOutlet OrderAddRemarkThirdV *fifthV;

@property (nullable, nonatomic, strong) ZPMarkStarV *markStarV;
@property (nullable, nonatomic, strong) OrderAddRemarkVM *viewModel;
@property (nullable, nonatomic, strong) NSArray<OrderAddRemarkThirdV *> *vArray;

@end

@implementation OrderAddRemarkThirdCell

- (void)awakeFromNib {
    // Initialization code
    _markStarV = [[ZPMarkStarV alloc] initWithStarSize:CGSizeMake(20.f, 20.f)
                                                             space:2
                                                      numberOfStar:5];
    _markStarV.initScore = 0.f;
    [_starContentV addSubview:_markStarV];
    [_markStarV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_starContentV);
    }];
    
    _textContentV.layer.borderWidth = 1;
    _textContentV.layer.cornerRadius = 6;
    _textContentV.layer.borderColor = RGB(204, 204, 204).CGColor;
    
    UIToolbar *keyBoard = [[NSBundle mainBundle] loadNibNamed:@"KeyBoardToolView"
                                                        owner:self
                                                      options:nil][0];
    _remarkTextView.inputAccessoryView = keyBoard;
}

#pragma mark - Override
- (void)bindViewModel:(OrderAddRemarkVM *)viewModel {
    _viewModel = viewModel;
    RAC(viewModel, remark) = _remarkTextView.rac_textSignal;
    RAC(_opinionTextField, hidden) = viewModel.validPlaceholderSignal;
    [_markStarV setScore:^(NSNumber *data) {
        viewModel.score = [data stringValue];
    }];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //
    [_viewModel.imageMutableArray addObject:image];
    for (int i = 0; i < _viewModel.imageMutableArray.count; i++) {
        OrderAddRemarkThirdV *v = self.vArray[i];
        v.logoImage = _viewModel.imageMutableArray[i];
    }
    if (_viewModel.imageMutableArray.count < self.vArray.count) {
        OrderAddRemarkThirdV *v = self.vArray[_viewModel.imageMutableArray.count];
        v.hidden = NO;
    }
    //
    [self.viewModel.masterVC dismissViewControllerAnimated:YES
                                                completion:^{}];
}

#pragma mark - <MLPhotoBrowserViewControllerDataSource>
- (NSInteger)photoBrowser:(MLPhotoBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section {
    return _viewModel.imageMutableArray.count;
}

#pragma mark - 每个组展示什么图片,需要包装下MLPhotoBrowserPhoto
- (MLPhotoBrowserPhoto *) photoBrowser:(MLPhotoBrowserViewController *)browser photoAtIndexPath:(NSIndexPath *)indexPath {
    // 包装下imageObj 成 ZLPhotoPickerBrowserPhoto 传给数据源
    MLPhotoBrowserPhoto *photo = [MLPhotoBrowserPhoto photoAnyImageObjWith:_viewModel.imageMutableArray[indexPath.row]];
    OrderAddRemarkThirdV *v = self.vArray[indexPath.row];
    photo.toView = v.logoImageView;
    photo.thumbImage = v.logoImage;
    return photo;
}

#pragma mark - <MLPhotoBrowserViewControllerDelegate>
- (BOOL)photoBrowser:(MLPhotoBrowserViewController *)photoBrowser willRemovePhotoAtIndexPath:(NSIndexPath *)indexPath {
    [_viewModel.imageMutableArray removeObjectAtIndex:indexPath.row];
    OrderAddRemarkThirdV *v = self.vArray[0];
    v.logoImage = nil;
    for (int i = 1; i < self.vArray.count; i++) {
        OrderAddRemarkThirdV *v = self.vArray[i];
        v.logoImage = nil;
        v.hidden = YES;
    }
    [self configureView];
    [photoBrowser dismissViewControllerAnimated:YES
                                     completion:^{
                                         // TODO
                                     }];
    return false;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.viewModel.masterVC dismissViewControllerAnimated:YES
                                                completion:^{}];
}

- (void)configureView {
    for (int i = 0; i < _viewModel.imageMutableArray.count; i++) {
        OrderAddRemarkThirdV *v = self.vArray[i];
        v.logoImage = _viewModel.imageMutableArray[i];
    }
    if (_viewModel.imageMutableArray.count < self.vArray.count) {
        OrderAddRemarkThirdV *v = self.vArray[_viewModel.imageMutableArray.count];
        v.hidden = NO;
    }
}

- (void)photograph {
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    imagePickerController.navigationBar.barTintColor = RGB(238, 72, 72);
    imagePickerController.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor] };
    imagePickerController.navigationBar.tintColor = [UIColor whiteColor];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self.viewModel.masterVC presentViewController:imagePickerController
                                          animated:YES
                                        completion: ^{}];
}

- (void)album {
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    imagePickerController.navigationBar.barTintColor = RGB(238, 72, 72);
    imagePickerController.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor] };
    imagePickerController.navigationBar.tintColor = [UIColor whiteColor];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.viewModel.masterVC presentViewController:imagePickerController
                                          animated:YES
                                        completion: ^{}];
}

- (IBAction)touchUpInside_keyBoardExit:(id)sender {
    [_remarkTextView resignFirstResponder];
}

- (IBAction)didSelectPhoto:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (self.vArray[button.tag].logoImage) {
        // 图片游览器
        MLPhotoBrowserViewController *photoBrowser = [[MLPhotoBrowserViewController alloc] init];
        // 缩放动画
        photoBrowser.status = UIViewAnimationAnimationStatusZoom;
        // 可以删除
        photoBrowser.editing = YES;
        // 数据源/delegate
        photoBrowser.delegate = self;
        photoBrowser.dataSource = self;
        // 当前选中的值
        photoBrowser.currentIndexPath = [NSIndexPath indexPathForItem:button.tag
                                                            inSection:0];
        // 展示控制器
        [self.viewModel.masterVC presentViewController:photoBrowser
                                              animated:NO
                                            completion:nil];
    }
    else {
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
}

- (NSArray<OrderAddRemarkThirdV *> *)vArray {
    if (!_vArray) {
        _vArray = @[
                    _firstV,
                    _secondV,
                    _thirdV,
                    _fourthV,
                    _fifthV
                    ];
    }
    return _vArray;
}

@end

@implementation OrderAddRemarkThirdV

- (void)setLogoImage:(UIImage *)logoImage {
    _logoImage = logoImage;
    if (logoImage) {
        _logoImageView.image = logoImage;
    }
    else {
        _logoImageView.image = GETIMAGE(@"ic_add");
    }
}

@end
