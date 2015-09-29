//
//  SocialLib.h
//  Pods
//
//  Created by Yeung Yiu Hung on 27/9/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^SLShareSuccess)(NSDictionary* message);
typedef void (^SLShareFailure)(NSDictionary* message, NSError* error);

@protocol SocialLibMessage <NSObject>

@optional
- (NSString *)title;
- (NSString *)content;
- (NSString *)contentURL;

/**
 *  Images array, store UIImage only
 *
 *  @return Array of UIImage to share
 */
- (NSArray *)images;
- (NSString *)thumbnailImageURL;

- (NSString *)videoURL;
- (UIImage *)videoThumbnail;

- (NSString *)tweetContent;

@end

@interface SocialLib : NSObject

+ (instancetype)sharedInstance;

/**
 *  Add a social platform with corresponding api key
 *
 *  @param platform Social platform name, For example : Facebook
 *  @param key      API Key from the social platform
 */
+ (void)addPlatform:(NSString *)platform withKey:(NSString *)key;

/**
 *  Return API key from social platform
 *
 *  @param platform Social platform name
 *
 *  @return API Key
 */
+ (NSString *)apiKeyForPlatform:(NSString *)platform;

/**
 *  Connect A social platform when the application finish launching
 *
 *  @param application   Your singleton app object.
 *  @param launchOptions A dictionary indicating the reason the app was launched (if any). The contents of this dictionary may be empty in situations where the user launched the app directly.
 *
 *  @return NO if the app cannot handle the URL resource or continue a user activity, otherwise return YES.
 */
+ (BOOL)connectSocialPlatformWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

+ (BOOL)handleOpenURL:(UIApplication *)application
              openURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation;

+ (void)applicationDidBecomeActie:(UIApplication *)application;

+ (void)shareModal:(id<SocialLibMessage>)obj toPlatform:(NSString *)platform success:(SLShareSuccess)successBlock failure:(SLShareFailure)failureBlock;

+ (NSDictionary *)parametersDictionaryFromQueryString:(NSString *)queryString;

+ (NSString *)imageToString:(UIImage *)image;

@end
