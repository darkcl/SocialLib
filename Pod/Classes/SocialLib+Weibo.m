//
//  SocialLib+Weibo.m
//  Pods
//
//  Created by Yeung Yiu Hung on 29/9/15.
//
//

#import "SocialLib+Weibo.h"

@implementation SocialLib (Weibo)

+ (void)load{
    [self addPlatform:kSocialLibPlatformWeibo withKey:@""];
}

+ (BOOL)connectWeiboWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return YES;
}

+ (BOOL)Weibo_handleOpenURL:(UIApplication *)application
                    openURL:(NSURL *)url
          sourceApplication:(NSString *)sourceApplication
                 annotation:(id)annotation{
    return YES;
}

+ (void)Weibo_applicationDidBecomeActie:(UIApplication *)application{
    
}

+ (void)shareModalToWeibo:(id<SocialLibFacebookMessage>)obj
                  success:(SLShareSuccess)successBlock
                  failure:(SLShareFailure)failureBlock{
    
}

@end
