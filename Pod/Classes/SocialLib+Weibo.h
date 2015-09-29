//
//  SocialLib+Weibo.h
//  Pods
//
//  Created by Yeung Yiu Hung on 29/9/15.
//
//

#import "SocialLib.h"

typedef NS_ENUM(NSInteger, SocialLibWeiboMessageType) {
    SocialLibWeiboMessageTypeText,
    SocialLibWeiboMessageTypeImage
};

static NSString *kSocialLibPlatformWeibo = @"Weibo";

@protocol SocialLibWeiboMessage <SocialLibMessage>

@required
- (SocialLibWeiboMessageType)weiboMessageType;

@end

@protocol WeiboSDKDelegate;

@interface SocialLib (Weibo) <WeiboSDKDelegate>

+ (void)text;

@end
