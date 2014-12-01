//
//  ConnectionManager.h
//  RedditMegaSupaClient
//
//  Created by Alejandro Tami on 29/11/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConnectionManagerDelegate

- (void) responseWithJSON:(NSData *) json;

@end

@interface ConnectionManager : NSObject

@property id <ConnectionManagerDelegate> delegate;

- (void) connect;
- (void) downloadImageFromURL: (NSURL*)url withCompletionHandler:(void (^) (NSData *rawImage))completionHandler;


@end
