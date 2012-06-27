//
//  MyTweetCell.h
//  Networked TableView
//
//  Created by Douglas Edmonson on 6/27/12.
//  Copyright (c) 2012 Clemson University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTweetCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *avatar;
@property (nonatomic, strong) IBOutlet UILabel *userName;
@property (nonatomic, strong) IBOutlet UITextView *tweetText;

@end
