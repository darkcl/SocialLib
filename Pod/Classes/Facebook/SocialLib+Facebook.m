//
//  SocialLib+Facebook.m
//  Pods
//
//  Created by Yeung Yiu Hung on 27/9/15.
//
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

#import "SocialLib+Facebook.h"

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

+ (void)shareModalToFacebook:(id<SocialLibFacebookMessage>)obj
                     success:(SLShareSuccess)successBlock
                     failure:(SLShareFailure)failureBlock{
    _fbsuccessBlock = successBlock;
    _fbfailureBlock = failureBlock;
    if ([obj.class conformsToProtocol:@protocol(SocialLibFacebookMessage)]) {
        SocialLibFacebookMessageType type = obj.fbMessageType;
        switch (type) {
            case SocialLibFacebookMessageTypeText:{
                FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
                
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

            }
                break;
            case SocialLibFacebookMessageTypePhoto:{
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
            }
                break;
            case SocialLibFacebookMessageTypeVideo:{
                FBSDKShareVideoContent *content = [[FBSDKShareVideoContent alloc] init];
                FBSDKShareVideo *video = [[FBSDKShareVideo alloc] init];
                video.videoURL = [NSURL URLWithString:obj.videoURL];
                content.video = video;
                
                [FBSDKShareDialog showFromViewController:nil
                                             withContent:content
                                                delegate:[SocialLib sharedInstance]];
            }
                break;
            case SocialLibFacebookMessageTypeLink:{
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
            }
                break;
            default:{
                NSError *error = [NSError errorWithDomain:@"SocialLib"
                                                     code:3
                                                 userInfo:@{NSLocalizedDescriptionKey: @"Modal doesn't have enough information"}];
                failureBlock(nil, error);
            }
                break;
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
