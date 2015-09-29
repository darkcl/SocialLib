//
//  SocialLib+Weixin.h
//  Pods
//
//  Created by Yeung Yiu Hung on 29/9/15.
//
//

#import "SocialLib.h"

typedef NS_ENUM(NSInteger, SocialLibWeixinMessageType) {
    SocialLibWeixinMessageTypeText,
    SocialLibWeixinMessageTypeImage
};

typedef NS_ENUM(NSInteger, SocialLibWeixinScene) {
    SocialLibWeixinSceneSession,
    SocialLibWeixinSceneTimeline,
    SocialLibWeixinSceneFavorite
};

static NSString *kSocialLibPlatformWeixin = @"Weixin";

@protocol SocialLibWeixinMessage <SocialLibMessage>

@required
- (SocialLibWeixinMessageType)weixinMessageType;

@end

@protocol WXApiDelegate;

@interface SocialLib (Weixin) <WXApiDelegate>

+ (void)setWeixinScene:(SocialLibWeixinScene)scene;

@end
