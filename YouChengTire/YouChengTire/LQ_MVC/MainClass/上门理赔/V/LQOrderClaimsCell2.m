//
//  LQOrderClaimsCell2.m
//  YouChengTire
//
//  Created by liqiang on 16/4/25.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQOrderClaimsCell2.h"

@interface LQOrderClaimsCell2()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *huaWenTextField;

@end

@implementation LQOrderClaimsCell2


+ (LQOrderClaimsCell2 *)cellWithTableView:(UITableView *)tableView
{
    UINib *nib = [UINib nibWithNibName:@"LQOrderClaimsCell2" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"LQOrderClaimsCell2"];
    
    LQOrderClaimsCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"LQOrderClaimsCell2"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setHuaWenStr:(NSString *)huaWenStr
{
    _huaWenStr = huaWenStr;
    
    self.huaWenTextField.text = huaWenStr;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *toBeStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.textFieldDidChange) {
        self.textFieldDidChange(toBeStr);
    }
    
    return YES;
}

@end
