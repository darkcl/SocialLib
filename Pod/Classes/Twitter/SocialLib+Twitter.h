//
//  SocialLib+Twitter.h
//  Pods
//
//  Created by Yeung Yiu Hung on 27/9/15.
//
//

#import "SocialLib.h"

typedef NS_ENUM(NSInteger, SocialLibTwitterMessageType) {
    SocialLibTwitterMessageTypeText,
    SocialLibTwitterMessageTypeImage
};

@protocol SocialLibTwitterMessage <SocialLibMessage>

@required
- (SocialLibTwitterMessageType)twitterMessageType;
- (NSString *)tweetContent;

@end

static NSString *kSocialLibPlatformTwitter = @"Twitter";

@interface SocialLib (Twitter)

@end
