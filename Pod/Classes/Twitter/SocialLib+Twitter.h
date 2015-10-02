//
//  SocialLib+Twitter.h
//  Pods
//
//  Created by Yeung Yiu Hung on 27/9/15.
//
//

#import "SocialLib.h"

/**
 *  Twitter message type
 */
typedef NS_ENUM(NSInteger, SocialLibTwitterMessageType){
    /**
     *  Tweet text only, will use tweetContent in <SocialLibTwitterMessage>
     */
    SocialLibTwitterMessageTypeText,
    /**
     *  Tweet text only, will use tweetContent in <SocialLibTwitterMessage> and images in <SocialLibMessage>
     */
    SocialLibTwitterMessageTypeImage
};

/**
 *  SocialLib Twitter message protocol
 */
@protocol SocialLibTwitterMessage <SocialLibMessage>

@required
/**
 *  Twitter message type of share modal
 *
 *  @return Twitter message type
 */
- (SocialLibTwitterMessageType)twitterMessageType;

/**
 *  Tweet content of share modal
 *
 *  @return Tweet content of share modal, length need to less than 140
 */
- (NSString *)socialLibTweetContent;

@end

static NSString *kSocialLibPlatformTwitter = @"Twitter";

@interface SocialLib (Twitter)

@end
