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
- (NSString *)title{
    return _infoTitle;
}

- (NSString *)content{
    return _infoContent;
}

- (NSString *)contentURL{
    return _infoContentURL;
}

- (NSArray *)images{
    return _infoImages;
}

- (NSString *)thumbnailImageURL{
    return _infoThumbnailImageURL;
}

- (NSString *)videoURL{
    return _infoVideoURL;
}

- (SocialLibFacebookMessageType)fbMessageType{
    return SocialLibFacebookMessageTypeLink;
}

- (NSString *)tweetContent{
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
