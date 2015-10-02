//
//  InfoModal.m
//  SocialLib
//
//  Created by Yeung Yiu Hung on 27/9/15.
//  Copyright © 2015 Yeung Yiu Hung. All rights reserved.
//

#import "InfoModal.h"


@implementation InfoModal

- (id)init{
    if (self = [super init]) {
        _imageType = SocialLibInstagramMessageTypeLocal;
    }
    return self;
}

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

- (SocialLibInstagramMessageType)instagramMessageType{
    return _imageType;
}

- (NSString *)socialLibInstagramURL{
    return @"http://www.joomlaworks.net/images/demos/galleries/abstract/7.jpg";
}

- (UIImage *)socialLibInstagramImage{
    UIImage *anImage = [UIImage imageNamed:@"example.jpg"];
    
    return anImage;
}
@end
