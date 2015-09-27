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
static BOOL isLogin;
static NSString *twitterToken;
static NSString *twitterVerifier;

static SLShareSuccess _twitterSuccessBlock;
static SLShareFailure _twitterFailureBlock;
static id<SocialLibMessage> twitterShareMsg;

+ (void)load{
    
    isLogin = NO;
    
    [self addPlatform:kSocialLibPlatformTwitter withKey:@""];
}

+ (BOOL)connectTwitterWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return YES;
}

+ (void)Twitter_applicationDidBecomeActie:(UIApplication *)application{
    
}

+ (NSDictionary *)parametersDictionaryFromQueryString:(NSString *)queryString {
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    
    NSArray *queryComponents = [queryString componentsSeparatedByString:@"&"];
    
    for(NSString *s in queryComponents) {
        NSArray *pair = [s componentsSeparatedByString:@"="];
        if([pair count] != 2) continue;
        
        NSString *key = pair[0];
        NSString *value = pair[1];
        
        md[key] = value;
    }
    
    return md;
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
    
    if (!isLogin) {
        [twitter postAccessTokenRequestWithPIN:twitterVerifier
                                  successBlock:^(NSString *oauthToken, NSString *oauthTokenSecret, NSString *userID, NSString *screenName) {
                                      
                                      [twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
                                          isLogin = YES;
                                          [self shareModalToTwitter:twitterShareMsg
                                                            success:_twitterSuccessBlock
                                                            failure:_twitterFailureBlock];
                                      }
                                                                          errorBlock:^(NSError *error) {
                                                                              isLogin = NO;
                                                                              _twitterFailureBlock(nil, error);
                                                                          }];
                                      
                                  }
                                    errorBlock:^(NSError *error) {
                                        isLogin = NO;
                                        _twitterFailureBlock(nil, error);
                                    }];
    }
    return YES;
}

+ (void)shareModalToTwitter:(id<SocialLibMessage>)obj
                    success:(SLShareSuccess)successBlock
                    failure:(SLShareFailure)failureBlock{
    if (!isLogin) {
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
        if ([obj respondsToSelector:@selector(tweetContent)] && obj.tweetContent.length != 0) {
            if (obj.tweetContent.length >= 140) {
                NSError *error = [NSError errorWithDomain:@"SocailLib"
                                                     code:4
                                                 userInfo:@{NSLocalizedDescriptionKey : @"Tweet length reach maxium character"}];
                failureBlock(nil, error);
            }else{
                NSString *tweetConent = obj.tweetContent;
                NSArray *images;
                if ([obj respondsToSelector:@selector(images)] && obj.images.count != 0) {
                    images = obj.images;
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
                }
            }
        }else{
            NSError *error = [NSError errorWithDomain:@"SocailLib"
                                                 code:5
                                             userInfo:@{NSLocalizedDescriptionKey : @"Modal doesn't have tweet content"}];
            failureBlock(nil, error);
        }
        
    }
}

@end
