//
//  RedditViewModel.m
//  RedditMegaSupaClient
//
//  Created by Alejandro Tami on 30/11/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "RedditViewModel.h"
#import "ConnectionManager.h"
#import "Common.h"
#import "RedditFeed.h"

@interface RedditViewModel() <ConnectionManagerDelegate>

@property ConnectionManager *connectionManager;

@end

@implementation RedditViewModel


static RedditViewModel *redditViewModel = nil;

/* Could use dispatch_once to make it thread safe, but for sake of simplicity...
   Also, I should not use singletons in a class like this, but for "showing off" purposes... 
 */
+ (instancetype) sharedInstance
{
    if (!redditViewModel)
    {
        redditViewModel = [super new];
    }
    
    return redditViewModel;
    
}

- (void) initialize
{
    self.connectionManager = [ConnectionManager new];
    self.connectionManager.delegate = self;
    [self.connectionManager connect];
}

- (void) responseWithJSON:(NSData *) json
{
    NSDictionary *dict;
    dict = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:nil];
    
    [self getArrayFromJSON:dict];
    
}

- (void) getArrayFromJSON: (NSDictionary*)dict
{
    
    NSArray *feeds = [[dict objectForKey: dataKey] objectForKey:childrenKey];
    NSMutableArray *redditFeedsArray = [NSMutableArray array];
    RedditFeed *feed;
    
    for (int i = 0; i < (feeds.count > feedsAmount? feedsAmount : feeds.count); i++) {
        
        feed = [RedditFeed new];
        feed.title = [[[feeds objectAtIndex:i] objectForKey:dataKey] objectForKey:titleKey];
        feed.author = [[[feeds objectAtIndex:i] objectForKey:dataKey] objectForKey:authorKey];
        feed.commentsNum = [[[[feeds objectAtIndex:i] objectForKey:dataKey] objectForKey:commentsNumnKey] description];
        feed.commentsNum = [NSString stringWithFormat:@"%@ comments", feed.commentsNum];
        feed.createdOn = [[[[feeds objectAtIndex:i] objectForKey:dataKey] objectForKey:createdKey] description];
        
        int hoursForCreation = (int) (([feed.createdOn longLongValue] / (60*60)));
        int hoursTilNow = (int) ([[NSDate date] timeIntervalSince1970] / (60*60));
        
        feed.createdOn = [NSString stringWithFormat:@"%d hours ago",(hoursTilNow - hoursForCreation)];
        feed.thumbnailImageURL = [[[feeds objectAtIndex:i] objectForKey:dataKey] objectForKey:thumbnailKey];
        [redditFeedsArray addObject:feed];
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:JSONObtainedNotification object:redditFeedsArray];
    
}

- (void) getImageFromURL: (NSURL*)url withCompletionHandler:(void (^) (NSData *rawImage))completionHandler
{
    url = [NSURL URLWithString:(NSString*)url];
    [self.connectionManager downloadImageFromURL:url withCompletionHandler:^(NSData *rawImage) {
        
        completionHandler(rawImage);

    }];
}



@end
