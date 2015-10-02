//
//  SocialLib+Instagram.h
//  Pods
//
//  Created by Yeung Yiu Hung on 28/9/15.
//
//

#import "SocialLib.h"

static NSString *kSocialLibPlatformInstagram = @"Instagram";

/**
 *  Instagram Message type
 */
typedef NS_ENUM(NSInteger, SocialLibInstagramMessageType){
    /**
     *  Local message, use socialLibInstagramImage
     */
    SocialLibInstagramMessageTypeLocal,
    /**
     *  URL message, use socialLibInstagramURL
     */
    SocialLibInstagramMessageTypeURL
};


@protocol SocialLibInstagramMessage <SocialLibMessage>

@optional

/**
 *  URL to download image and upload to instagram
 *
 *  @return URL to the image
 */
- (NSString *)socialLibInstagramURL;

/**
 *  UIImage to upload to instagram
 *
 *  @return UIImage object
 */
- (UIImage *)socialLibInstagramImage;

@required
/**
 *  Share modal type for instagram, local or remote
 *
 *  @return Share modal type
 */
- (SocialLibInstagramMessageType)instagramMessageType;

@end

@interface SocialLib (Instagram) <UIDocumentInteractionControllerDelegate>

@end
