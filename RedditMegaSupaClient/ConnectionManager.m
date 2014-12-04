//
//  ConnectionManager.m
//  RedditMegaSupaClient
//
//  Created by Alejandro Tami on 29/11/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ConnectionManager.h"

#define URL @"http://www.reddit.com/top.json"

@implementation ConnectionManager

- (void) connect
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURL *url = [NSURL URLWithString:URL];
    
    NSURLSessionDataTask *downloadTask = [session
     dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse * response, NSError *error) {
         
         dispatch_async(dispatch_get_main_queue(), ^{
             NSLog(@"Error: %@", error);
             [self.delegate responseWithJSON:data];
         });
         
     }];
    
    [downloadTask resume];
}

- (void) downloadImageFromURL: (NSURL*)url withCompletionHandler:(void (^) (NSData *rawImage))completionHandler
{
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDownloadTask *downloadPhotoTask = [session
     downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                       
         completionHandler([NSData dataWithContentsOfURL:location]);
                                                       
     }];
    
    [downloadPhotoTask resume];

}

- (void) responseWithJSON:(NSData *) json
{
    
}

@end
