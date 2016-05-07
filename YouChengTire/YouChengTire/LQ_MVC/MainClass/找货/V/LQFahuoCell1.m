//
//  LQFahuoCell1.m
//  YouChengTire
//
//  Created by liqiang on 16/4/30.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQFahuoCell1.h"

@interface LQFahuoCell1()<UITextFieldDelegate>

@end

@implementation LQFahuoCell1


+ (LQFahuoCell1 *)cellWithTableView:(UITableView *)tableView
{
    UINib *nib = [UINib nibWithNibName:@"LQFahuoCell1" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"LQFahuoCell1"];
    
    LQFahuoCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"LQFahuoCell1"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.textFieldChange) {
        self.textFieldChange(str);
    }
    
    return YES;
}

@end
