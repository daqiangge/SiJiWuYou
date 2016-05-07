//
//  InviteFriendsCell.h
//  YouChengTire
//
//  Created by WangZhipeng on 16/2/4.
//  Copyright © 2016年 WangZhipeng. All rights reserved.
//

#import "BaseCell.h"

@protocol InviteFriendsCellDelegate <NSObject>

- (void)inviteFriends;

@end

@interface InviteFriendsCell : BaseCell

@property (weak, nonatomic) id<InviteFriendsCellDelegate> delegate;

@end
