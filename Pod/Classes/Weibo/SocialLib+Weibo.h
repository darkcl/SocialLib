//
//  SocialLib+Weibo.h
//  Pods
//
//  Created by Yeung Yiu Hung on 29/9/15.
//
//

#import "SocialLib.h"
/**
 *  Weibo Message type
 */
typedef NS_ENUM(NSInteger, SocialLibWeiboMessageType){
    /**
     *  Share text only, will use content in <SocialLibMessage>
     */
    SocialLibWeiboMessageTypeText,
    /**
     *  Share image, will use content, images (first item only) in <SocialLibMessage>
     */
    SocialLibWeiboMessageTypeImage
};

static NSString *kSocialLibPlatformWeibo = @"Weibo";

/**
 *  Weibo message protocol
 */
@protocol SocialLibWeiboMessage <SocialLibMessage>

@required
/**
 *  Weibo message type of share modal
 *
 *  @return Weibo message type
 */
- (SocialLibWeiboMessageType)weiboMessageType;

@end

@protocol WeiboSDKDelegate;

@interface SocialLib (Weibo) <WeiboSDKDelegate>

@end
