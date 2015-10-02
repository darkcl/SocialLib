//
//  SocialLib+Twitter.m
//  Pods
//
//  Created by Yeung Yiu Hung on 27/9/15.
//
//

#import "SocialLib+Twitter.h"
#import <STTwitter/STTwitter.h>
#import <Accounts/Accounts.h>

@implementation SocialLib (Twitter)

static STTwitterAPI *twitter;
static ACAccountStore *accountStore;
static NSArray *iOSAccounts;
static BOOL isTwitterLogin;
static NSString *twitterToken;
static NSString *twitterVerifier;

static SLShareSuccess _twitterSuccessBlock;
static SLShareFailure _twitterFailureBlock;
static id<SocialLibTwitterMessage> twitterShareMsg;

+ (void)load{
    
    isTwitterLogin = NO;
    
    [self addPlatform:kSocialLibPlatformTwitter withKey:@""];
}

+ (BOOL)connectTwitterWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return YES;
}

+ (void)Twitter_applicationDidBecomeActie:(UIApplication *)application{
    
}

+ (BOOL)Twitter_handleOpenURL:(UIApplication *)application
                      openURL:(NSURL *)url
            sourceApplication:(NSString *)sourceApplication
                   annotation:(id)annotation{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* twitterURL = [infoDict objectForKey:@"TwitterCallbackURL"];
    if ([[url scheme] isEqualToString:twitterURL] == NO)
        return NO;
    
    NSDictionary *d = [self parametersDictionaryFromQueryString:[url query]];
    
    twitterToken = d[@"oauth_token"];
    twitterVerifier = d[@"oauth_verifier"];
    
    if (!isTwitterLogin) {
        [twitter postAccessTokenRequestWithPIN:twitterVerifier
                                  successBlock:^(NSString *oauthToken, NSString *oauthTokenSecret, NSString *userID, NSString *screenName) {
                                      
                                      [twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
                                          isTwitterLogin = YES;
                                          [self shareModalToTwitter:twitterShareMsg
                                                            success:_twitterSuccessBlock
                                                            failure:_twitterFailureBlock];
                                      }
                                                                          errorBlock:^(NSError *error) {
                                                                              isTwitterLogin = NO;
                                                                              _twitterFailureBlock(nil, error);
                                                                          }];
                                      
                                  }
                                    errorBlock:^(NSError *error) {
                                        isTwitterLogin = NO;
                                        _twitterFailureBlock(nil, error);
                                    }];
    }
    return YES;
}

+ (void)shareModalToTwitter:(id<SocialLibTwitterMessage>)obj
                    success:(SLShareSuccess)successBlock
                    failure:(SLShareFailure)failureBlock{
    if (!isTwitterLogin) {
        NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString* consumerKey = [infoDict objectForKey:@"TwitterConsumerKey"];
        NSString* consumerSecret = [infoDict objectForKey:@"TwitterConsumerSecret"];
        
        twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:consumerKey
                                                consumerSecret:consumerSecret];
        _twitterSuccessBlock = successBlock;
        _twitterFailureBlock = failureBlock;
        twitterShareMsg = obj;
        NSString* twitterURL = [infoDict objectForKey:@"TwitterCallbackURL"];
        [twitter postTokenRequest:^(NSURL *url, NSString *oauthToken) {
            [[UIApplication sharedApplication] openURL:url];
        }
   authenticateInsteadOfAuthorize:NO
                       forceLogin:@(YES)
                       screenName:nil
                    oauthCallback:[NSString stringWithFormat:@"%@://twitter_access_tokens/", twitterURL]
                       errorBlock:^(NSError *error) {
                           failureBlock(nil, error);
                       }];
    }else{
        if ([obj.class conformsToProtocol:@protocol(SocialLibTwitterMessage)]) {
            SocialLibTwitterMessageType type = obj.twitterMessageType;
            if (obj.socialLibTweetContent.length >= 140) {
                NSError *error = [NSError errorWithDomain:@"SocailLib"
                                                     code:4
                                                 userInfo:@{NSLocalizedDescriptionKey : @"Tweet length reach maxium character"}];
                failureBlock(nil, error);
            }else{
                if (type == SocialLibTwitterMessageTypeText) {
                    NSString *tweetConent = obj.socialLibTweetContent;
                    [twitter postStatusUpdate:tweetConent
                            inReplyToStatusID:nil
                                     latitude:nil
                                    longitude:nil
                                      placeID:nil
                           displayCoordinates:nil
                                     trimUser:nil
                                 successBlock:^(NSDictionary *status) {
                                     successBlock(status);
                                 }
                                   errorBlock:^(NSError *error) {
                                       failureBlock(nil, error);
                                   }];
                }else if (type == SocialLibTwitterMessageTypeImage) {
                    NSString *tweetConent = obj.socialLibTweetContent;
                    NSArray *images;
                    if ([obj respondsToSelector:@selector(socialLibImages)] && obj.socialLibImages.count != 0) {
                        images = obj.socialLibImages;
                        [twitter postStatusUpdate:tweetConent
                                   mediaDataArray:images
                                possiblySensitive:nil
                                inReplyToStatusID:nil
                                         latitude:nil
                                        longitude:nil
                                          placeID:nil
                               displayCoordinates:nil
                              uploadProgressBlock:^(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
                                  
                              } successBlock:^(NSDictionary *status) {
                                  successBlock(status);
                              } errorBlock:^(NSError *error) {
                                  failureBlock(nil, error);
                              }];
                    }else{
                    
                    }
                }
            }
        }
    }
}

@end
