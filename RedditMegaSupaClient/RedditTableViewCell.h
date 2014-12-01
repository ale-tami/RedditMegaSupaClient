//
//  ReditTableViewCell.h
//  RedditMegaSupaClient
//
//  Created by Alejandro Tami on 29/11/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedditTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursAgoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;

- (void) setImageURL:(NSURL *)thumbnailImageURL;


@end
