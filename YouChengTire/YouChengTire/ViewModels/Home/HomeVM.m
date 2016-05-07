//
//  HomeVM.m
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/10.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "HomeVM.h"
// Cells
#import "HomeCell.h"
// Models
#import "HomeM.h"

@interface HomeVM ()

@property (nullable, nonatomic, strong, readwrite) HomeM *homeM;

@end

@implementation HomeVM

#pragma mark - Override
- (void)initialize {
    self.title = @"司机无忧";
    self.array = [self configureCell:nil];
}

#pragma mark - Public
- (void)requestRefreshData:(void (^)(id object))success
                     error:(void (^)(NSError *error))error
                   failure:(void (^)(NSError *error))failure
                completion:(void (^)(void))completion {
    [ZPHTTP wPost:@"/app/sys/init/getBootList"
       parameters:nil
          success:^(NSDictionary *object) {
              if ([object[@"msgCode"] isEqualToString:kRequestSuccess]) {
                  self.homeM = [HomeM yy_modelWithJSON:object[@"data"]];
                  self.array = [self configureCell:self.homeM];
                  success(nil);
                  completion();
              }
              else {
                  NSInteger errnoInteger = [object[@"msgCode"] integerValue];
                  NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : object[@"msg"] };
                  NSError *uError = [NSError errorWithDomain:@"ZPCustom"
                                                        code:errnoInteger
                                                    userInfo:userInfo];
                  error(uError);
                  completion();
              }
          } failure:^(NSError *error) {
              failure(error);
              completion();
          }];
}

- (NSArray *)configureCell:(HomeM *)homeM {
//    HomeFirstCell *cell_01 = [HomeFirstCell createCell];
//    NSArray *sectionArray_01 = @[
//                                 cell_01
//                                 ];
    
//    HomeSecondCell *cell_02 = [HomeSecondCell createCell];
//    NSArray *sectionArray_02 = @[
//                                 cell_02
//                                 ];
    
//    HomeFifthCell *cell_03 = [HomeFifthCell createCell];
//    cell_03.dictionary = @{
//                           @"kTitle" : @"商城推荐",
//                           @"kColor" : RGB(248, 82, 96)
//                           };
//    HomeThirdCell *cell_04 = [HomeThirdCell createCell];
//    cell_04.dictionary = @{
//                           @"kArray" : homeM.pictureList1,
//                           };
//    NSArray *sectionArray_03 = @[
//                                 cell_03,
//                                 cell_04
//                                 ];
    
//    HomeFifthCell *cell_05 = [HomeFifthCell createCell];
//    cell_05.dictionary = @{
//                           @"kTitle" : @"积分兑换",
//                           @"kColor" : RGB(255, 209, 1)
//                           };
//    HomeFourthCell *cell_06 = [HomeFourthCell createCell];
//    cell_06.dictionary = @{
//                           @"kArray" : homeM.pictureList2,
//                           };
//    NSArray *sectionArray_04 = @[
//                                 cell_05,
//                                 cell_06
//                                 ];
    
//    HomeFifthCell *cell_07 = [HomeFifthCell createCell];
//    cell_07.dictionary = @{
//                           @"kTitle" : @"资讯头条",
//                           @"kColor" : RGB(69, 205, 255)
//                           };
//    HomeSixthCell *cell_08 = [HomeSixthCell createCell];
//    cell_08.dictionary = @{
//                           @"kLogo" : @"home_cell_fifth_01",
//                           @"kTitle" : @"车上哪些东西影响舒适性 轮胎减震最直接",
//                           @"kSubtitle" : @"不少人心中的好车标准，舒适性可能最重要，毕竟买车是为了享受，而不是为了受罪。驾车是为了给工作和生活带来方便和愉悦。"
//                           };
//    HomeSixthCell *cell_09 = [HomeSixthCell createCell];
//    cell_09.dictionary = @{
//                           @"kLogo" : @"home_cell_fifth_02",
//                           @"kTitle" : @"电商平台前景可观 途虎养车发布2015年度轮胎数据报告",
//                           @"kSubtitle" : @"作为中国国内最大的汽车后市商电商平台，途虎养车始终将轮胎产品作为重要业务不断加强。近日，途虎就结合了其2015年运营数据，正式对外发布了《2015年度途虎养车轮胎数据报告》。"
//                           };
//    HomeSixthCell *cell_10 = [HomeSixthCell createCell];
//    cell_10.dictionary = @{
//                           @"kLogo" : @"home_cell_fifth_03",
//                           @"kTitle" : @"春运来临 固特异轮胎助你安心回家",
//                           @"kSubtitle" : @"刚刚送走二十年一遇的大寒潮,热火朝天的春运就拉开了序幕。在中国传统观念中,回家过年是一年之中最重要的事。据有关部门统计,2016年春运全国旅客发送量预计将达到29.1亿人次,无愧于世界最大规模的迁徙活动。千万人回家的路,共同构成国人独有的春运轨迹。而这样短时间大规模的人口移动往往会给交通带来严峻的考验。"
//                           };
//    NSArray *sectionArray_05 = @[
//                                 cell_07,
//                                 cell_08,
//                                 cell_09,
//                                 cell_10
//                                 ];
    
    NSDictionary *dict_01 = @{kCell : @"HomeFirstCell"};
    NSArray *sectionArray_01 = @[dict_01];
    
    NSDictionary *dict_02 = @{kCell : @"HomeSecondCell"};
    NSArray *sectionArray_02 = @[dict_02];
    
    NSDictionary *dict_03 = @{
                              kCell : @"HomeFifthCell",
                              kTitle : @"商城推荐",
                              kColor : RGB(248, 82, 96)
                              };
    NSDictionary *dict_04 = @{
                              kCell : @"HomeThirdCell",
                              kArray : homeM ? homeM.pictureList1 : @[]
                              };
    NSArray *sectionArray_03 = @[dict_03, dict_04];
    
    NSDictionary *dict_05 = @{
                              kCell : @"HomeFifthCell",
                              kTitle : @"积分兑换",
                              kColor : RGB(255, 209, 1)
                              };
    NSDictionary *dict_06 = @{
                              kCell : @"HomeFourthCell",
                              kArray : homeM ? homeM.pictureList2 : @[]
                              };
    NSArray *sectionArray_04 = @[dict_05, dict_06];
    
    return @[
             sectionArray_01,
             sectionArray_02,
             sectionArray_03,
             sectionArray_04,
//             sectionArray_05
             ];
}

@end
