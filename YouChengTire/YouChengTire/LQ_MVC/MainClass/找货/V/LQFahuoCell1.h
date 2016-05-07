//
//  LQFahuoCell1.h
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^textFieldChange)(NSString *str);

@interface LQFahuoCell1 : UITableViewCell

@property (nonatomic, copy) textFieldChange textFieldChange;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
+ (LQFahuoCell1 *)cellWithTableView:(UITableView *)tableView;

@end
