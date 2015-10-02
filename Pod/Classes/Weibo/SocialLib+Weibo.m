//
//  SocialLib+Weibo.m
//  Pods
//
//  Created by Yeung Yiu Hung on 29/9/15.
//
//

#import <WeiboSDK.h>
#import "SocialLib+Weibo.h"


@implementation SocialLib (Weibo)

static NSString* wbtoken;
static NSString* wbCurrentUserID;
static NSString * const kRedirectURI = @"https://api.weibo.com/oauth2/default.html";

static SLShareSuccess _weiboSuccessBlock;
static SLShareFailure _weiboFailureBlock;
+ (void)load{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* weiboAppID = [infoDict objectForKey:@"WeiboAppID"];
    [self addPlatform:kSocialLibPlatformWeibo withKey:weiboAppID];
}

+ (BOOL)connectWeiboWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* weiboAppID = [infoDict objectForKey:@"WeiboAppID"];
#ifdef DEBUG
    [WeiboSDK enableDebugMode:YES];
#endif
    [WeiboSDK registerApp:weiboAppID];
    
    return YES;
}

+ (BOOL)Weibo_handleOpenURL:(UIApplication *)application
                    openURL:(NSURL *)url
          sourceApplication:(NSString *)sourceApplication
                 annotation:(id)annotation{
    return [WeiboSDK handleOpenURL:url delegate:[SocialLib sharedInstance]];
}

+ (void)Weibo_applicationDidBecomeActie:(UIApplication *)application{
    
}


+ (WBMessageObject *)wbMessageToShare:(id<SocialLibWeiboMessage>)weiboMessage
{
    SocialLibWeiboMessageType type = weiboMessage.weiboMessageType;
    WBMessageObject *message = [WBMessageObject message];
    
    switch (type) {
        case SocialLibWeiboMessageTypeText: {
            message.text = weiboMessage.socialLibContent;
            break;
        }
        case SocialLibWeiboMessageTypeImage: {
            message.text = weiboMessage.socialLibContent;
            if (weiboMessage.socialLibImages.count != 0) {
                WBImageObject *imageObj = [WBImageObject object];
                imageObj.imageData = UIImagePNGRepresentation(weiboMessage.socialLibImages[0]);
                message.imageObject = imageObj;
            }
            break;
        }
        default: {
            break;
        }
    }
    
    return message;
}

+ (void)shareModalToWeibo:(id<SocialLibWeiboMessage>)obj
                  success:(SLShareSuccess)successBlock
                  failure:(SLShareFailure)failureBlock{
    if (!wbtoken) {
        _weiboSuccessBlock = successBlock;
        _weiboFailureBlock = failureBlock;
        WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
        authRequest.redirectURI = kRedirectURI;
        authRequest.scope = @"all";
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self wbMessageToShare:obj] authInfo:authRequest access_token:nil];
        [WeiboSDK sendRequest:request];
    }else{
        _weiboSuccessBlock = successBlock;
        _weiboFailureBlock = failureBlock;
        WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
        authRequest.redirectURI = kRedirectURI;
        authRequest.scope = @"all";
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self wbMessageToShare:obj] authInfo:authRequest access_token:wbtoken];
        [WeiboSDK sendRequest:request];
    }
}

#pragma mark - Weibo Delegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            wbtoken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            wbCurrentUserID = userID;
        }
        if(response.statusCode == 0){
            //Success
            _weiboSuccessBlock(response.requestUserInfo);
        }else{
            //Failed
            NSError *error = [NSError errorWithDomain:@"SocialLibWeibo"
                                                 code:7
                                             userInfo:@{NSLocalizedDescriptionKey : @"Weibo Share error"}];
            _weiboFailureBlock(nil, error);
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        wbtoken = [(WBAuthorizeResponse *)response accessToken];
        wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
    }
    else if ([response isKindOfClass:WBPaymentResponse.class])
    {
        
    }
}

@end
