# SocialLib

[![CI Status](https://travis-ci.org/darkcl/SocialLib.svg?branch=master)](https://travis-ci.org/darkcl/SocialLib)
[![Version](https://img.shields.io/cocoapods/v/SocialLib.svg?style=flat)](http://cocoapods.org/pods/SocialLib)
[![License](https://img.shields.io/cocoapods/l/SocialLib.svg?style=flat)](http://cocoapods.org/pods/SocialLib)
[![Platform](https://img.shields.io/cocoapods/p/SocialLib.svg?style=flat)](http://cocoapods.org/pods/SocialLib)

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

##General Setup
In your .pch, add following lines
```objc
//Facebook:
#import <SocialLib/SocialLib+Facebook.h>

//Twitter:
#import <SocialLib/SocialLib+Twitter.h>

//Tumblr:
#import <SocialLib/SocialLib+Tumblr.h>

//Weibo:
#import <SocialLib/SocialLib+Weibo.h>

//Weixin / WeChat:
#import <SocialLib/SocialLib+Weixin.h>
```

In your AppDelegate,
```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return [SocialLib connectSocialPlatformWithApplication:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [SocialLib applicationDidBecomeActie:application];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [SocialLib handleOpenURL:application
                            openURL:url
                  sourceApplication:sourceApplication
                         annotation:annotation];
}
```

### Facebook Setup
1. In Xcode right-click your .plist file and choose "Open As Source Code".
2. Copy & Paste the XML snippet into the body of your file `(<dict>...</dict>)`.
3. Replace:
   - fb{FACEBOOK_APP_ID} with your Facebook App ID and the prefix fb. E.g.: fb123456.
   - {FACEBOOK_APP_ID} with your Facebook App ID.
   - {Your App Name} with the Display Name you configured in the App Dashboard.

```plist
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>fb{FACEBOOK_APP_ID}</string>
    </array>
  </dict>
</array>
<key>FacebookAppID</key>
<string>{FACEBOOK_APP_ID}</string>
<key>FacebookDisplayName</key>
<string>{Your App Name}</string>
```
**For iOS 9**
```plist
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSExceptionDomains</key>
  <dict>
    <key>facebook.com</key>
    <dict>
      <key>NSIncludesSubdomains</key> <true/>        
      <key>NSExceptionRequiresForwardSecrecy</key> <false/>
    </dict>
    <key>fbcdn.net</key>
    <dict>
      <key>NSIncludesSubdomains</key> <true/>
      <key>NSExceptionRequiresForwardSecrecy</key>  <false/>
    </dict>
    <key>akamaihd.net</key>
    <dict>
      <key>NSIncludesSubdomains</key> <true/>
      <key>NSExceptionRequiresForwardSecrecy</key> <false/>
    </dict>
  </dict>
</dict>

<key>LSApplicationQueriesSchemes</key>
<array>
    <string>fbapi</string>
    <string>fbapi20130214</string>
    <string>fbapi20130410</string>
    <string>fbapi20130702</string>
    <string>fbapi20131010</string>
    <string>fbapi20131219</string>    
    <string>fbapi20140410</string>
    <string>fbapi20140116</string>
    <string>fbapi20150313</string>
    <string>fbapi20150629</string>
    <string>fbauth</string>
    <string>fbauth2</string>
    <string>fb-messenger-api20140430</string>
</array>
```
### Twitter Setup
1. In Xcode right-click your .plist file and choose "Open As Source Code".
2. Copy & Paste the XML snippet into the body of your file `(<key>CFBundleURLTypes</key>
	<array>...</array>)`.
3. Replace {URL Scheme} to what you want:

	```plist
	<dict>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>{URL Scheme}</string>
		</array>
	</dict>
	```
4. Add following lines into body of your file `(<dict>...</dict>)`
5. Replace:
   - {URL Scheme} with the same URL Scheme as above.
   - {Twitter Consumer Key} with your Twitter App Cosumer key - [Register Here](https://apps.twitter.com).
   - {Twitter Consumer Secret} with your Twitter App Cosumer Secret - [Register Here](https://apps.twitter.com).
   
	```plist
	<key>TwitterCallbackURL</key>
	<string>{URL Scheme}</string>
	<key>TwitterConsumerKey</key>
	<string>{Twitter Consumer Key}</string>
	<key>TwitterConsumerSecret</key>
	<string>{Twitter Consumer Secret}</string>
	```
*For Twitter application, you must have a valid callback url, otherwise the sharing will not work.*

###Tumblr Setup
1. In Xcode right-click your .plist file and choose "Open As Source Code".
2. Copy & Paste the XML snippet into the body of your file `(<key>CFBundleURLTypes</key>
	<array>...</array>)`.
3. Replace {URL Scheme} to what you want, must be unique:

	```plist
	<dict>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>{URL Scheme}</string>
		</array>
	</dict>
	```
	
4. Add following lines into body of your file `(<dict>...</dict>)`
5. Replace:
   - {URL Scheme} with the same URL Scheme as above.
   - {Tumblr Consumer Key} with your Tumblr App Cosumer key - [Register Here](https://www.tumblr.com/oauth/apps).
   - {Tumblr Consumer Secret} with your Tumblr App Cosumer Secret - [Register Here](https://www.tumblr.com/oauth/apps).
   
	```plist
	<key>TumblrCallbackURL</key>
	<string>{URL Scheme}</string>
	<key>TumblrConsumerKey</key>
	<string>{Tumblr Consumer Key}</string>
	<key>TumblrConsumerSecret</key>
	<string>{Tumblr Consumer Secret}</string>
	```
	
###Weibo Setup
1. In Xcode right-click your .plist file and choose "Open As Source Code".
2. Copy & Paste the XML snippet into the body of your file `(<key>CFBundleURLTypes</key>
	<array>...</array>)`.
3. Replace {WEIBO API ID} with your Weibo App ID:

	```plist
	<dict>
		<key>CFBundleTypeRole</key>
		<string>Editor</string>
		<key>CFBundleURLName</key>
		<string>com.weibo</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>{WEIBO API ID}</string>
		</array>
	</dict>
	```
	
4. Add following lines into body of your file `(<dict>...</dict>)`
5. Replace:
   - {WEIBO API ID} with your Weibo App ID.
   
	```plist
	<key>WeiboAppID</key>
	<string>{WEIBO API ID}</string>
	```

###Weixin Setup
1. In Xcode right-click your .plist file and choose "Open As Source Code".
2. Copy & Paste the XML snippet into the body of your file `(<key>CFBundleURLTypes</key>
	<array>...</array>)`.
3. Replace {WEIXIN API ID} with your Weixin App ID:

	```plist
	<dict>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>{WEIXIN API ID}</string>
		</array>
	</dict>
	```
	
4. Add following lines into body of your file `(<dict>...</dict>)`
5. Replace:
   - {WEIXIN API ID} with your Weixin App ID.
   - {WEIXIN API NAME} with your Weixin App name.
   
	```plist
	<key>WeixinAppID</key>
	<string>ENTER{WEIXIN API ID}</string>
	<key>WeixinAppName</key>
	<string>{WEIXIN API NAME}</string>
	```

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.
**Demo provided Facebook, Twitter and Tumblr api keys, Weibo and Weixin api keys are empty**
###Sharing Sample
You need a modal object to use SocialLib share

InfoModal.h
```objc
#import <Foundation/Foundation.h>

@interface InfoModal : NSObject <SocialLibFacebookMessage, SocialLibTwitterMessage, SocialLibTumblrMessage, SocialLibWeiboMessage, SocialLibWeixinMessage>{
    
}

@property (nonatomic, strong) NSString *infoTitle;
@property (nonatomic, strong) NSString *infoContent;
@property (nonatomic, strong) NSString *infoContentURL;
@property (nonatomic, strong) NSArray *infoImages;
@property (nonatomic, strong) NSString *infoThumbnailImageURL;
@property (nonatomic, strong) NSString *infoVideoURL;
```

InfoModal.m
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

## Author

Yeung Yiu Hung, hkclex@gmail.com

## License

SocialLib is available under the MIT license. See the LICENSE file for more info.
