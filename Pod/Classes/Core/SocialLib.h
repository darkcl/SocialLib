//
//  SocialLib.h
//  Pods
//
//  Created by Yeung Yiu Hung on 27/9/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  SocialLib share success block, include return message if service provided it
 *
 *  @param message Message return from social sharing service
 */
typedef void (^SLShareSuccess)(NSDictionary* message);

/**
 *  SocialLib share failure block, include error message if service provided it
 *
 *  @param message Error message from server
 *  @param error   NSError message from error message from server
 */
typedef void (^SLShareFailure)(NSDictionary* message, NSError* error);

/**
 *  SocailLib Message protocol, your share modal needs to conforms this.
 */
@protocol SocialLibMessage <NSObject>

@optional

/**
 *  Title of share modal
 *
 *  @return Title string of share modal
 */
- (NSString *)title;

/**
 *  Content text of share modal
 *
 *  @return Content text string
 */
- (NSString *)content;

/**
 *  Link of share modal
 *
 *  @return URL string of the link
 */
- (NSString *)contentURL;

/**
 *  Images array, store UIImage only
 *
 *  @return Array of UIImage to share
 */
- (NSArray *)images;

/**
 *  Thumbnail image URL
 *
 *  @return URL string for thumbnail image
 */
- (NSString *)thumbnailImageURL;

/**
 *  Video URL, need to be assest URL
 *
 *  @return Assest URL of video
 */
- (NSString *)videoURL;

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
+ (BOOL)connectSocialPlatformWithApplication:(UIApplication *)application
               didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

/**
 *  SocialLib handling for opening a resource identified by URL.
 *
 *  @param application       Your singleton app object.
 *  @param url               The URL resource to open.
 *  @param sourceApplication The bundle ID of the app that is requesting your app to open the URL (url).
 *  @param annotation        A property list object supplied by the source app to communicate information to the receiving app.
 *
 *  @return YES if SocialLib successfully handled the request or NO if the attempt to open the URL resource failed.
 */
+ (BOOL)handleOpenURL:(UIApplication *)application
              openURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation;

/**
 *  Tells SocialLib that the app has become active.
 *
 *  @param application Your singleton app object.
 */
+ (void)applicationDidBecomeActie:(UIApplication *)application;

+ (void)shareModal:(id<SocialLibMessage>)obj
        toPlatform:(NSString *)platform
           success:(SLShareSuccess)successBlock
           failure:(SLShareFailure)failureBlock;

#pragma mark - Helper function

/**
 *  Serialize url query to NSDictionary object
 *
 *  @param queryString URL query string
 *
 *  @return Dictionary of url query
 */
+ (NSDictionary *)parametersDictionaryFromQueryString:(NSString *)queryString;

/**
 *  Encode UIImage object to Base64 string
 *
 *  @param image UIImage to encode
 *
 *  @return Base64 string
 */
+ (NSString *)imageToString:(UIImage *)image;

@end
