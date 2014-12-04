//
//  ReditTableViewCell.m
//  RedditMegaSupaClient
//
//  Created by Alejandro Tami on 29/11/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "RedditTableViewCell.h"
#import "RedditViewModel.h"
#import "Common.h"


@interface RedditTableViewCell ()

@property UIActivityIndicatorView *activityIndicator;

@end

@implementation RedditTableViewCell


- (void) setImageURL:(NSURL *)thumbnailImageURL
{
    [self.activityIndicator startAnimating];
    [[RedditViewModel sharedInstance] getImageFromURL:thumbnailImageURL withCompletionHandler:^(NSData *rawImage) {
        [self performSelector:@selector(setImage:) withObject:[UIImage imageWithData:rawImage]];
    }];
}

- (void)awakeFromNib {
    self.thumbnailImageView.image = [UIImage imageNamed:@"Placeholder"];
    self.thumbnailImageView.contentMode = UIViewContentModeScaleAspectFit;
  //  [self.thumbnailImageView setNeedsDisplay];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.alpha = 1.0;
    self.activityIndicator.center = self.thumbnailImageView.center;
    self.activityIndicator.hidesWhenStopped = YES;
    [self.thumbnailImageView addSubview:self.activityIndicator];

}

- (void) setImage:(UIImage*) image
{
   
    self.thumbnailImageView.image = (image)? image : [UIImage imageNamed:@"Placeholder"];
  //  self.thumbnailImageView.image = image;

    [self.activityIndicator stopAnimating];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
