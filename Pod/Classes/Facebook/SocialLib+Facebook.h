//
//  SocialLib+Facebook.h
//  Pods
//
//  Created by Yeung Yiu Hung on 27/9/15.
//
//

#import "SocialLib.h"

/**
 *  SocialLib Facebook message type
 */
typedef NS_ENUM(NSInteger, SocialLibFacebookMessageType){
    /**
     * Facebook message contain text only, will use content in <SocialLibMessage>
     */
    SocialLibFacebookMessageTypeText,
    /**
     * Facebook message contain link, will use title, content, contentURL, thumbnailImageURL in <SocialLibMessage>
     */
    SocialLibFacebookMessageTypeLink,
    /**
     * Facebook message contain photo, will use images in <SocialLibMessage>
     */
    SocialLibFacebookMessageTypePhoto,
    /**
     * Facebook message contain video, will use videoURL in <SocialLibMessage>
     */
    SocialLibFacebookMessageTypeVideo
};

@protocol FBSDKSharingDelegate;

/**
 *  SocialLib Facebook message protocol
 */
@protocol SocialLibFacebookMessage <SocialLibMessage>

@required

/**
 *  Facebook message type of share modal
 *
 *  @return Message type of share modal
 */
- (SocialLibFacebookMessageType)fbMessageType;

@end

static NSString *kSocialLibPlatformFacebook = @"Facebook";

@interface SocialLib (Facebook) <FBSDKSharingDelegate>

@end
