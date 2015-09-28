//
//  SocialLib+Facebook.h
//  Pods
//
//  Created by Yeung Yiu Hung on 27/9/15.
//
//

#import "SocialLib.h"

typedef NS_ENUM(NSInteger, SocialLibFacebookMessageType) {
    SocialLibFacebookMessageTypeText,
    SocialLibFacebookMessageTypeLink,
    SocialLibFacebookMessageTypePhoto,
    SocialLibFacebookMessageTypeVideo
};

@protocol FBSDKSharingDelegate;

@protocol SocialLibFacebookMessage <SocialLibMessage>

@required
- (SocialLibFacebookMessageType)fbMessageType;

@end

static NSString *kSocialLibPlatformFacebook = @"Facebook";

@interface SocialLib (Facebook) <FBSDKSharingDelegate>

@end
