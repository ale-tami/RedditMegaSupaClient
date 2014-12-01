//
//  RedditViewModel.h
//  RedditMegaSupaClient
//
//  Created by Alejandro Tami on 30/11/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedditViewModel : NSObject

+ (instancetype) sharedInstance;
- (void) initialize;
- (void) getImageFromURL: (NSURL*)url withCompletionHandler:(void (^) (NSData *rawImage))completionHandler;

- (instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));
+ (instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

@end
