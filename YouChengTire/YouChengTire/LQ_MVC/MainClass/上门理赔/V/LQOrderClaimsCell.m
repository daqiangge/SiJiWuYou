//
//  LQOrderClaimsCell.m
//  YouChengTire
//
//  Created by liqiang on 16/4/25.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "LQOrderClaimsCell.h"

@interface LQOrderClaimsCell()
@property (weak, nonatomic) IBOutlet UIButton *guiGeBtn;
@property (weak, nonatomic) IBOutlet UIButton *xingHaoBtn;

@end


@implementation LQOrderClaimsCell


+ (LQOrderClaimsCell *)cellWithTableView:(UITableView *)tableView
{
    UINib *nib = [UINib nibWithNibName:@"LQOrderClaimsCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"LQOrderClaimsCell"];
    
    LQOrderClaimsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQOrderClaimsCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (IBAction)didClickGuiGeBtn:(id)sender
{
    if (self.clickGuiGeBtn)
    {
        self.clickGuiGeBtn();
    }
}

- (IBAction)didClickXingHaoBtn:(id)sender
{
    if (self.clickXingHaoBtn)
    {
        self.clickXingHaoBtn();
    }
}

- (void)setGuiGeStr:(NSString *)guiGeStr
{
    _guiGeStr = guiGeStr;
    
    [self.guiGeBtn setTitle:guiGeStr forState:UIControlStateNormal];
}

- (void)setGuiGeStr2:(NSString *)guiGeStr2
{
    _guiGeStr2 = guiGeStr2;
    
    [self.xingHaoBtn setTitle:guiGeStr2 forState:UIControlStateNormal];
}

@end
