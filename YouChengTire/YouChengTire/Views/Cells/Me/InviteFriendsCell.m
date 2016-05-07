//
//  InviteFriendsCell.m
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/4.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "InviteFriendsCell.h"

@interface InviteFriendsCell ()

@property (weak, nonatomic) IBOutlet UIButton *inviteFriendsButton;

@end

@implementation InviteFriendsCell

- (void)awakeFromNib {
    // Initialization code
    [self configureButton];
}

#pragma mark - private
- (void)configureButton {
    [self configureBorder:_inviteFriendsButton];
}

- (void)configureBorder:(UIView *)view {
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 6;
    view.layer.borderColor = [UIColor clearColor].CGColor;
}

#pragma mark - Event Response
- (IBAction)feedback:(id)sender {    
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(inviteFriends)]) {
            [_delegate inviteFriends];
        }
    }
}

@end
