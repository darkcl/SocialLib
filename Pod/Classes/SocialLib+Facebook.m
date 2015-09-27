//
//  SocialLib+Facebook.m
//  Pods
//
//  Created by Yeung Yiu Hung on 27/9/15.
//
//

#import "SocialLib+Facebook.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@implementation SocialLib (Facebook)

static SLShareSuccess _fbsuccessBlock;
static SLShareFailure _fbfailureBlock;

+ (void)load{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* key = [infoDict objectForKey:@"FacebookAppID"];
    [self addPlatform:kSocialLibPlatformFacebook withKey:key];
}

+ (BOOL)connectFacebookWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}

+ (BOOL)Facebook_handleOpenURL:(UIApplication *)application
                       openURL:(NSURL *)url
             sourceApplication:(NSString *)sourceApplication
                    annotation:(id)annotation{
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

+ (void)Facebook_applicationDidBecomeActie:(UIApplication *)application{
    [FBSDKAppEvents activateApp];
}

+ (void)shareModalToFacebook:(id<SocialLibMessage>)obj
                     success:(SLShareSuccess)successBlock
                     failure:(SLShareFailure)failureBlock{
    _fbsuccessBlock = successBlock;
    _fbfailureBlock = failureBlock;
    if ([obj.class conformsToProtocol:@protocol(SocialLibMessage)]) {
        if ([obj respondsToSelector:@selector(contentURL)] && obj.contentURL.length != 0) {
            FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
            content.contentURL = [NSURL URLWithString:obj.contentURL];
            
            if ([obj respondsToSelector:@selector(title)]) {
                content.contentTitle = obj.title;
            }
            
            if ([obj respondsToSelector:@selector(thumbnailImageURL)]) {
                content.imageURL = [NSURL URLWithString:obj.thumbnailImageURL];
            }
            
            if ([obj respondsToSelector:@selector(content)]) {
                content.contentDescription = obj.content;
            }
            
            [FBSDKShareDialog showFromViewController:nil
                                         withContent:content
                                            delegate:[SocialLib sharedInstance]];
        }else if ([obj respondsToSelector:@selector(videoURL)] && obj.videoURL.length != 0) {
            FBSDKShareVideoContent *content = [[FBSDKShareVideoContent alloc] init];
            FBSDKShareVideo *video = [[FBSDKShareVideo alloc] init];
            video.videoURL = [NSURL URLWithString:obj.videoURL];
            content.video = video;
            
            [FBSDKShareDialog showFromViewController:nil
                                         withContent:content
                                            delegate:[SocialLib sharedInstance]];
        }else if ([obj respondsToSelector:@selector(images)] && obj.images.count != 0) {
            NSMutableArray *imagesArray = [[NSMutableArray alloc] init];
            for (UIImage *image in obj.images) {
                FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
                photo.image = image;
                photo.userGenerated = YES;
                [imagesArray addObject:photo];
            }
            FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
            content.photos = imagesArray;
            [FBSDKShareDialog showFromViewController:nil
                                         withContent:content
                                            delegate:[SocialLib sharedInstance]];
        }else{
            NSError *error = [NSError errorWithDomain:@"SocialLib"
                                                 code:3
                                             userInfo:@{NSLocalizedDescriptionKey: @"Modal doesn't have enough information"}];
            failureBlock(nil, error);
        }
    }else{
        NSError *error = [NSError errorWithDomain:@"SocialLib"
                                             code:3
                                         userInfo:@{NSLocalizedDescriptionKey: @"Modal doesn't conforms SocailLibMessage Protocol"}];
        failureBlock(nil, error);
    }
    
}

#pragma mark - FBSDKSharingDelegate
- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results{
    _fbsuccessBlock(results);
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error{
    _fbfailureBlock(nil, error);
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer{
    NSError *error = [NSError errorWithDomain:@"SocialLib"
                                         code:1
                                     userInfo:@{NSLocalizedDescriptionKey : @"Facebook share did cancel"}];
    
    _fbfailureBlock(nil, error);
}

@end
