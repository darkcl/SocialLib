//
//  InfoModal.m
//  SocialLib
//
//  Created by Yeung Yiu Hung on 27/9/15.
//  Copyright © 2015 Yeung Yiu Hung. All rights reserved.
//

#import "InfoModal.h"


@implementation InfoModal

#pragma mark - SocialLibMessage
- (NSString *)socialLibTitle{
    return _infoTitle;
}

- (NSString *)socialLibContent{
    return _infoContent;
}

- (NSString *)socialLibContentURL{
    return _infoContentURL;
}

- (NSArray *)socialLibImages{
    return _infoImages;
}

- (NSString *)socialLibThumbnailImageURL{
    return _infoThumbnailImageURL;
}

- (NSString *)socialLibVideoURL{
    return _infoVideoURL;
}

- (SocialLibFacebookMessageType)fbMessageType{
    return SocialLibFacebookMessageTypeLink;
}

- (NSString *)socialLibTweetContent{
    return [NSString stringWithFormat:@"%@ - %@ %@",_infoTitle, _infoContent, _infoContentURL];
}

- (SocialLibTwitterMessageType)twitterMessageType{
    return SocialLibTwitterMessageTypeText;
}

- (SocialLibTumblrMessageType)tumblrMessageType{
    return SocialLibTumblrMessageTypeLink;
}

- (SocialLibWeiboMessageType)weiboMessageType{
    return SocialLibWeiboMessageTypeText;
}

- (SocialLibWeixinMessageType)weixinMessageType{
    return SocialLibWeixinMessageTypeLink;
}
@end
