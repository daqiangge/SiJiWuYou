//
//  LQOrderClaimsCell1.m
//  YouChengTire
//
//  Created by liqiang on 16/4/25.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQOrderClaimsCell1.h"

@interface LQOrderClaimsCell1()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *pingPaiTextField;
@end

@implementation LQOrderClaimsCell1


+ (LQOrderClaimsCell1 *)cellWithTableView:(UITableView *)tableView
{
    UINib *nib = [UINib nibWithNibName:@"LQOrderClaimsCell1" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"LQOrderClaimsCell1"];
    
    LQOrderClaimsCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"LQOrderClaimsCell1"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setPingPaiStr:(NSString *)pingPaiStr
{
    _pingPaiStr = pingPaiStr;
    
    self.pingPaiTextField.text = pingPaiStr;
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
