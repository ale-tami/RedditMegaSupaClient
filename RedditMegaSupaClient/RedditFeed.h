//
//  RedditFeed.h
//  RedditMegaSupaClient
//
//  Created by Alejandro Tami on 30/11/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RedditFeed : NSObject

@property (strong, nonatomic) NSURL *thumbnailImageURL;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *commentsNum;
@property (strong, nonatomic) NSString *createdOn;

@end
