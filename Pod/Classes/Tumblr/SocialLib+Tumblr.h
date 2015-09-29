//
//  SocialLib+Tumblr.h
//  Pods
//
//  Created by Yeung Yiu Hung on 28/9/15.
//
//

#import "SocialLib.h"

static NSString *kSocialLibPlatformTumblr = @"Tumblr";

typedef void(^SLTumblrGetInfoSuccess)(NSArray *blogs);
typedef void(^SLTumblrGetInfoFailure)(NSError *error);

typedef void(^SLTumblrAuthSuccess)(void);
typedef void(^SLTumblrAuthFailure)(NSError *error);

typedef NS_ENUM(NSInteger, SocialLibTumblrMessageType) {
    SocialLibTumblrMessageTypeText,
    SocialLibTumblrMessageTypePhoto,
    SocialLibTumblrMessageTypeQuote,
    SocialLibTumblrMessageTypeLink,
    SocialLibTumblrMessageTypeAudio,
    SocialLibTumblrMessageTypeVideo
};

@protocol SocialLibTumblrMessage <SocialLibMessage>

@required
- (SocialLibTumblrMessageType)tumblrMessageType;

@end

@interface SocialLib (Tumblr)

+ (void)getTumblrBlogsWithSuccess:(SLTumblrGetInfoSuccess)successBlock failure:(SLTumblrGetInfoFailure)failureBlock;

+ (void)setTumblrBlog:(NSString *)blog;

@end
