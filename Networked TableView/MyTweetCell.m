//
//  MyTweetCell.m
//  Networked TableView
//
//  Created by Douglas Edmonson on 6/27/12.
//  Copyright (c) 2012 Clemson University. All rights reserved.
//

#import "MyTweetCell.h"

@implementation MyTweetCell

@synthesize avatar = _avatar;
@synthesize userName= _userName;
@synthesize tweetText = _tweetText;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
