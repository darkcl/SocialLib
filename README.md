# SocialLib

[![CI Status](https://travis-ci.org/darkcl/SocialLib.svg?branch=master)](https://travis-ci.org/darkcl/SocialLib)
[![Version](https://img.shields.io/cocoapods/v/SocialLib.svg?style=flat)](http://cocoapods.org/pods/SocialLib)
[![License](https://img.shields.io/cocoapods/l/SocialLib.svg?style=flat)](http://cocoapods.org/pods/SocialLib)
[![Platform](https://img.shields.io/cocoapods/p/SocialLib.svg?style=flat)](http://cocoapods.org/pods/SocialLib)

###What is  SocialLib?
SocialLib is a library that aims to share information to different social media site without getting your code messy with different social media SDKs. 

Sharing with SocialLib is simple, you can have the same modal to share to different social media.

Here is an example for the same modal to share to Twitter and Facebook.

`InfoModal.h`
```objc
#import <Foundation/Foundation.h>

@interface InfoModal : NSObject <SocialLibFacebookMessage, SocialLibTwitterMessage>{
    
}

@property (nonatomic, strong) NSString *infoTitle;
@property (nonatomic, strong) NSString *infoContent;
@property (nonatomic, strong) NSString *infoContentURL;
@property (nonatomic, strong) NSArray *infoImages;
@property (nonatomic, strong) NSString *infoThumbnailImageURL;
@property (nonatomic, strong) NSString *infoVideoURL;
```

`InfoModal.m`
```objc
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

- (NSString *)tweetContent{
    return [NSString stringWithFormat:@"%@ - %@ %@",_infoTitle, _infoContent, _infoContentURL];
}

- (SocialLibTwitterMessageType)twitterMessageType{
    return SocialLibTwitterMessageTypeText;
}

- (SocialLibFacebookMessageType)fbMessageType{
    return SocialLibFacebookMessageTypeLink;
}

@end
```

To share facebook use
```objc
InfoModal *info = [[InfoModal alloc] init];
info.infoTitle = @"SocialLib";
info.infoContent = @"Share via SocialLib";
info.infoContentURL = @"http://darkcl.github.io/SocialLib";
[SocialLib shareModal:info
           toPlatform:kSocialLibPlatformFacebook
              success:^(NSDictionary *message) {
                  NSLog(@"%@", message);
              }
              failure:^(NSDictionary *message, NSError *error) {
                  NSLog(@"%@", error);
              }];
```

To share twitter use
```objc
InfoModal *info = [[InfoModal alloc] init];
info.infoTitle = @"SocialLib";
info.infoContent = @"Share via SocialLib";
info.infoContentURL = @"http://darkcl.github.io/SocialLib";
[SocialLib shareModal:info
           toPlatform:kSocialLibPlatformTwitter
              success:^(NSDictionary *message) {
                  NSLog(@"%@", message);
              }
              failure:^(NSDictionary *message, NSError *error) {
                  NSLog(@"%@", error);
              }];
```

## Installation

SocialLib is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

Install all platform (Facebook, Twitter, Tumblr, Instagram, Weibo and Weixin)
```ruby
pod 'SocialLib'
```

For specific social platform, use subspec
```ruby
pod 'SocialLib/Facebook'
pod 'SocialLib/Twitter'
pod 'SocialLib/Tumblr'
pod 'SocialLib/Instagram'
pod 'SocialLib/Weibo'
pod 'SocialLib/Weixin'
```

## Setup Guide
You can find setup guide in the [wiki](https://github.com/darkcl/SocialLib/wiki)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.
**Demo provided Facebook, Twitter and Tumblr api keys, Weibo and Weixin api keys are empty**

## Author

Yeung Yiu Hung, hkclex@gmail.com

## License

SocialLib is available under the MIT license. See the LICENSE file for more info.


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/darkcl/sociallib/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

