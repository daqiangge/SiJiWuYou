//
//  LQOrderClaimsCell3.m
//  YouChengTire
//
//  Created by liqiang on 16/4/25.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQOrderClaimsCell3.h"

@interface LQOrderClaimsCell3()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *taiHaoTextField;

@end

@implementation LQOrderClaimsCell3


+ (LQOrderClaimsCell3 *)cellWithTableView:(UITableView *)tableView
{
    UINib *nib = [UINib nibWithNibName:@"LQOrderClaimsCell3" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"LQOrderClaimsCell3"];
    
    LQOrderClaimsCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"LQOrderClaimsCell3"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
