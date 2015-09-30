//
//  SocialLib+Tumblr.h
//  Pods
//
//  Created by Yeung Yiu Hung on 28/9/15.
//
//

#import "SocialLib.h"

static NSString *kSocialLibPlatformTumblr = @"Tumblr";
/**
 *  Success block of getting blogs information
 *
 *  @param blogs Array of blogs host, return from tumblr
 */
typedef void(^SLTumblrGetInfoSuccess)(NSArray *blogs);

/**
 *  Failure block of getting blogs information
 *
 *  @param error Error contain server message
 */
typedef void(^SLTumblrGetInfoFailure)(NSError *error);

/**
 *  Tumblr message type
 */
typedef NS_ENUM(NSInteger, SocialLibTumblrMessageType){
    /**
     *  Text post on tumblr, will use content, title in <SocialLibMessage>
     */
    SocialLibTumblrMessageTypeText,
    /**
     *  Photo post on tumblr, will use images in <SocialLibMessage>
     */
    SocialLibTumblrMessageTypePhoto,
    /**
     *  Quote post on tumblr, will use content and contentURL in <SocialLibMessage>
     */
    SocialLibTumblrMessageTypeQuote,
    /**
     *  Link post on tumblr, will use contentURL, title and content in <SocialLibMessage>
     */
    SocialLibTumblrMessageTypeLink,
    /**
     *  Not implement yet
     */
    SocialLibTumblrMessageTypeAudio,
    /**
     *  Not implement yet
     */
    SocialLibTumblrMessageTypeVideo
};

@protocol SocialLibTumblrMessage <SocialLibMessage>

@required
- (SocialLibTumblrMessageType)tumblrMessageType;

@end

@interface SocialLib (Tumblr)

/**
 *  Get list of tumblr blogs after authorization
 *
 *  @param successBlock Success block after sucessfully getting blogs list
 *  @param failureBlock Failure block after fail getting blogs list
 */
+ (void)getTumblrBlogsWithSuccess:(SLTumblrGetInfoSuccess)successBlock
                          failure:(SLTumblrGetInfoFailure)failureBlock;

/**
 *  Set tumblr blog for SocialLib to share, if not set, the defaut is the first blog return from tumblr API
 *
 *  @param blog Blog host, eg: darkcl.tumblr.com
 */
+ (void)setTumblrBlog:(NSString *)blog;

@end
