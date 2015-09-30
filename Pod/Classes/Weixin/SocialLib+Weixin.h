//
//  SocialLib+Weixin.h
//  Pods
//
//  Created by Yeung Yiu Hung on 29/9/15.
//
//

#import "SocialLib.h"

/**
 *  Weixin message type
 */
typedef NS_ENUM(NSInteger, SocialLibWeixinMessageType){
    /**
     *  Text only post on weixin, will use title, content in <SocialLibMessage>
     */
    SocialLibWeixinMessageTypeText,
    /**
     *  Image post on weixin, will use images (first item only)
     */
    SocialLibWeixinMessageTypeImage,
    /**
     *  Link post on weixin, will use title, content, contentURL
     */
    SocialLibWeixinMessageTypeLink
};

/**
 *  Weixin scene type
 */
typedef NS_ENUM(NSInteger, SocialLibWeixinScene){
    /**
     *  Session scene, share with contact
     */
    SocialLibWeixinSceneSession,
    /**
     *  Timeline scene, share to timeline
     */
    SocialLibWeixinSceneTimeline,
    /**
     *  Favourite scene, share to favourite
     */
    SocialLibWeixinSceneFavorite
};

static NSString *kSocialLibPlatformWeixin = @"Weixin";

/**
 *  Weixin Message protocol
 */
@protocol SocialLibWeixinMessage <SocialLibMessage>

@required

/**
 *  Weixin message type of share modal
 *
 *  @return Weixin Message type
 */
- (SocialLibWeixinMessageType)weixinMessageType;

@end

@protocol WXApiDelegate;

@interface SocialLib (Weixin) <WXApiDelegate>

/**
 *  Set Weixin scene, default is SocialLibWeixinSceneTimeline
 *
 *  @param scene Scene type
 */
+ (void)setWeixinScene:(SocialLibWeixinScene)scene;

@end
