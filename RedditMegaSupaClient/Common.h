//
//  Common.h
//  RedditMegaSupaClient
//
//  Created by Alejandro Tami on 30/11/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

#pragma mark Notifications
extern NSString *JSONObtainedNotification;
extern NSString *ThumbnailObtainedNotification;

#pragma mark Feed Related
extern int feedsAmount;
extern NSString *dataKey;
extern NSString *childrenKey;
extern NSString *titleKey;
extern NSString *authorKey;
extern NSString *commentsNumnKey;
extern NSString *createdKey;
extern NSString *thumbnailKey;

@end
