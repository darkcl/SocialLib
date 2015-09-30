//
//  SocialLib+Tumblr.m
//  Pods
//
//  Created by Yeung Yiu Hung on 28/9/15.
//
//

#import "SocialLib+Tumblr.h"
#import "AFOAuth1Client.h"
#import "AFJSONRequestOperation.h"

typedef void(^SLTumblrAuthSuccess)(void);
typedef void(^SLTumblrAuthFailure)(NSError *error);

@implementation SocialLib (Tumblr)

static AFOAuth1Client *tumblrClient;
static AFOAuth1Token *tumblrOAuthToken;

static bool isTumblrLogin;
static SLShareSuccess _tumblrSuccessBlock;
static SLShareFailure _tumblrFailureBlock;

static NSString *tumblrToken;
static NSString *tumblrVerifier;

static NSString *tumblrBlog;

+ (void)load{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* consumerKey = [infoDict objectForKey:@"TumblrConsumerKey"];
    NSString* consumerSecret = [infoDict objectForKey:@"TumblrConsumerSecret"];
    
    tumblrClient = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://www.tumblr.com/"]
                                                       key:consumerKey
                                                    secret:consumerSecret];
    [tumblrClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    isTumblrLogin = NO;
    
    [self addPlatform:kSocialLibPlatformTumblr withKey:@"tumblr"];
}

+ (void)setTumblrBlog:(NSString *)blog{
    tumblrBlog = blog;
}

+ (void)getTumblrBlogsWithSuccess:(SLTumblrGetInfoSuccess)successBlock
                          failure:(SLTumblrGetInfoFailure)failureBlock{
    [self loginWithTumblr:^{
        [tumblrClient getPath:@"https://api.tumblr.com/v2/user/info"
                   parameters:nil
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                          NSError *error;
                          NSDictionary* jsonFromData = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
                          if (!error) {
                              NSMutableArray *allBlogs = [[NSMutableArray alloc] init];
                              for (NSDictionary *blogs in jsonFromData[@"response"][@"user"][@"blogs"]) {
                                  NSString *blogUrl = blogs[@"url"];
                                  NSURL *url = [NSURL URLWithString:blogUrl];
                                  
                                  NSString *host = [url host];
                                  [allBlogs addObject:host];
                              }
                              successBlock(allBlogs);
                          }else{
                              failureBlock(error);
                          }
                      }
                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                          failureBlock(error);
                      }];
    }
                  failure:^(NSError *error) {
                      failureBlock(error);
                  }];
}

+ (BOOL)connectTumblrWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return YES;
}

+ (BOOL)Tumblr_handleOpenURL:(UIApplication *)application
                     openURL:(NSURL *)url
           sourceApplication:(NSString *)sourceApplication
                  annotation:(id)annotation{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* twitterURL = [infoDict objectForKey:@"TumblrCallbackURL"];
    if ([[url scheme] isEqualToString:twitterURL] == NO)
        return NO;
    NSNotification *notification = [NSNotification notificationWithName:kAFApplicationLaunchedWithURLNotification object:nil userInfo:[NSDictionary dictionaryWithObject:url forKey:kAFApplicationLaunchOptionsURLKey]];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    return YES;
}

+ (void)Tumblr_applicationDidBecomeActie:(UIApplication *)application{
    
}

+ (void)loginWithTumblr:(SLTumblrAuthSuccess)successBlock failure:(SLTumblrAuthFailure)failureBlock{
    if (!isTumblrLogin) {
        NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString* callbackURL = [infoDict objectForKey:@"TumblrCallbackURL"];
        
        [tumblrClient authorizeUsingOAuthWithRequestTokenPath:@"/oauth/request_token"
                                        userAuthorizationPath:@"/oauth/authorize"
                                                  callbackURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://success",callbackURL]]
                                              accessTokenPath:@"/oauth/access_token"
                                                 accessMethod:@"POST"
                                                        scope:nil
                                                      success:^(AFOAuth1Token *accessToken, id responseObject) {
                                                          isTumblrLogin = YES;
                                                          successBlock();
                                                      }
                                                      failure:^(NSError *error) {
                                                          failureBlock(error);
                                                      }];
    }else{
        successBlock();
    }
}

+ (void)shareModalToTumblr:(id<SocialLibTumblrMessage>)obj
                   success:(SLShareSuccess)successBlock
                   failure:(SLShareFailure)failureBlock{
    [self
     loginWithTumblr:^{
         if (tumblrBlog == nil) {
             [self getTumblrBlogsWithSuccess:^(NSArray *blogs) {
                 if (blogs.count != 0) {
                     [self setTumblrBlog:blogs[0]];
                     [self postMessageForType:obj.tumblrMessageType
                                       toBlog:tumblrBlog
                                    withModal:obj
                                      success:^(NSDictionary *message) {
                                          successBlock(message);
                                      }
                                      failure:^(NSDictionary *message, NSError *error) {
                                          failureBlock(nil, error);
                                      }];
                 }else{
                     NSError *error = [NSError errorWithDomain:@"SocialLib"
                                                          code:6
                                                      userInfo:@{NSLocalizedDescriptionKey : @"No Tumblr blog return."}];
                     failureBlock(nil, error);
                 }
             }
                                     failure:^(NSError *error) {
                                         failureBlock(nil, error);
                                     }];
         }else{
             [self postMessageForType:obj.tumblrMessageType
                               toBlog:tumblrBlog
                            withModal:obj
                              success:^(NSDictionary *message) {
                                  successBlock(message);
                              }
                              failure:^(NSDictionary *message, NSError *error) {
                                  failureBlock(nil, error);
                              }];
         }
     }
     failure:^(NSError *error) {
         failureBlock(nil, error);
     }];
}

+ (void)postMessageForType:(SocialLibTumblrMessageType)type
                    toBlog:(NSString *)baseHost
                 withModal:(id<SocialLibTumblrMessage>)modal
                   success:(SLShareSuccess)successBlock
                   failure:(SLShareFailure)failureBlock{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    bool shareFail = NO;
    switch (type) {
        case SocialLibTumblrMessageTypeText: {
            NSString *content;
            if (modal.content != nil) {
                content = modal.content;
            }else{
                shareFail = YES;
            }
            
            NSString *title = modal.title;
            
            [param setObject:@"text" forKey:@"type"];
            [param setObject:title forKey:@"title"];
            [param setObject:content forKey:@"body"];
            
            break;
        }
        case SocialLibTumblrMessageTypePhoto: {
            [param setObject:@"photo" forKey:@"type"];
            
            if (modal.images.count == 0) {
                NSMutableArray *data = [[NSMutableArray alloc] init];
                for (UIImage *anImage in modal.images) {
                    [data addObject:[self imageToString:anImage]];
                }
                [param setObject:data forKey:@"data"];
            }else{
                shareFail = YES;
            }
            
            break;
        }
        case SocialLibTumblrMessageTypeQuote: {
            [param setObject:@"quote" forKey:@"type"];
            
            if (modal.content != nil) {
                [param setObject:modal.content forKey:@"quote"];
                
                if (modal.contentURL != nil) {
                    [param setObject:modal.contentURL forKey:@"source"];
                }
            }else{
                shareFail = YES;
            }
            
            break;
        }
        case SocialLibTumblrMessageTypeLink: {
            [param setObject:@"link" forKey:@"type"];
            
            if (modal.contentURL != nil) {
                [param setObject:modal.contentURL forKey:@"url"];
                
                if (modal.title != nil) {
                    [param setObject:modal.title forKey:@"title"];
                }
                
                if (modal.content != nil) {
                    [param setObject:modal.content forKey:@"description"];
                }
            }else{
                shareFail = YES;
            }
            break;
        }
        case SocialLibTumblrMessageTypeAudio: {
            shareFail = YES;
            break;
        }
        case SocialLibTumblrMessageTypeVideo: {
            shareFail = YES;
            break;
        }
        default: {
            break;
        }
    }
    
    if (!shareFail) {
        [tumblrClient postPath:[NSString stringWithFormat:@"https://api.tumblr.com/v2/blog/%@/post", baseHost]
                    parameters:param
                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                           successBlock(responseObject);
                       }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           failureBlock(nil, error);
                       }];
    }else{
        NSError *error = [NSError errorWithDomain:@"SocialLib"
                                             code:6
                                         userInfo:@{NSLocalizedDescriptionKey : @"Fail to share"}];
        failureBlock(nil, error);
    }
}

@end
