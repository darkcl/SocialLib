//
//  SocialLib+Weixin.m
//  Pods
//
//  Created by Yeung Yiu Hung on 29/9/15.
//
//

#import <WXApi.h>

#import "SocialLib+Weixin.h"

@implementation SocialLib (Weixin)

static enum WXScene weixinScene;

+ (void)load{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* weixinAppID = [infoDict objectForKey:@"WeixinAppID"];
    
    weixinScene = WXSceneTimeline;
    
    [self addPlatform:kSocialLibPlatformWeixin withKey:weixinAppID];
}

+ (void)setWeixinScene:(SocialLibWeixinScene)scene{
    switch (scene) {
        case SocialLibWeixinSceneSession:
            weixinScene = WXSceneSession;
            break;
        case SocialLibWeixinSceneTimeline:
            weixinScene = WXSceneTimeline;
            break;
        case SocialLibWeixinSceneFavorite:
            weixinScene = WXSceneFavorite;
            break;
        default:
            break;
    }
}

+ (BOOL)connectWeixinWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* weixinAppID = [infoDict objectForKey:@"WeixinAppID"];
    NSString *weixinAppName = [infoDict objectForKey:@"WeixinAppName"];
    [WXApi registerApp:weixinAppID withDescription:weixinAppName];
    
    return YES;
}

+ (BOOL)Weixin_handleOpenURL:(UIApplication *)application
                    openURL:(NSURL *)url
          sourceApplication:(NSString *)sourceApplication
                 annotation:(id)annotation{
    return [WXApi handleOpenURL:url delegate:[SocialLib sharedInstance]];
}

+ (void)Weixin_applicationDidBecomeActie:(UIApplication *)application{
    
}


+ (WXMediaMessage *)messageToShare:(id<SocialLibWeixinMessage>)weixinMessage
{
    SocialLibWeixinMessageType type = weixinMessage.weixinMessageType;
    WXMediaMessage *message = [WXMediaMessage message];
    switch (type) {
        case SocialLibWeixinMessageTypeText: {
            message.description = weixinMessage.content;
            break;
        }
        case SocialLibWeixinMessageTypeImage: {
            WXImageObject *imageObj = [WXImageObject object];
            imageObj.imageData = UIImagePNGRepresentation(weixinMessage.images[0]);
            message.mediaObject = imageObj;
            break;
        }
        case SocialLibWeixinMessageTypeLink: {
            message.title = weixinMessage.title;
            message.description = weixinMessage.content;
            WXWebpageObject *ext = [WXWebpageObject object];
            ext.webpageUrl = weixinMessage.contentURL;
            message.mediaObject = ext;
            break;
        }
        default: {
            break;
        }
    }
    
    
    return message;
}

+ (void)shareModalToWeixin:(id<SocialLibWeixinMessage>)obj
                  success:(SLShareSuccess)successBlock
                  failure:(SLShareFailure)failureBlock{
    if (![WXApi isWXAppInstalled]) {
        NSError *error = [NSError errorWithDomain:@"SocialLib"
                                             code:8
                                         userInfo:@{NSLocalizedDescriptionKey : @"WeChat Not install"}];
        failureBlock(nil, error);
    }else{
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = [self messageToShare:obj];
        req.scene = weixinScene;
        BOOL success = [WXApi sendReq:req];
        if(success){
            successBlock(nil);
        }else{
            NSError *error = [NSError errorWithDomain:@"SocialLib"
                                                 code:0
                                             userInfo:@{NSLocalizedDescriptionKey : @"WeChat Share error."}];
            failureBlock(nil, error);
        }
    }
}

@end
