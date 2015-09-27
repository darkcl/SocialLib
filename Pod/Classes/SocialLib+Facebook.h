//
//  SocialLib+Facebook.h
//  Pods
//
//  Created by Yeung Yiu Hung on 27/9/15.
//
//

#import "SocialLib.h"


@protocol FBSDKSharingDelegate;

static NSString *kSocialLibPlatformFacebook = @"Facebook";

@interface SocialLib (Facebook) <FBSDKSharingDelegate>

@end
