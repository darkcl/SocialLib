//
//  SocialLib.m
//  Pods
//
//  Created by Yeung Yiu Hung on 27/9/15.
//
//

#import "SocialLib.h"

@implementation SocialLib

static NSMutableDictionary *supportedPlatform;

+ (instancetype)sharedInstance{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)addPlatform:(NSString *)platform withKey:(NSString *)key{ 
    if (!supportedPlatform) {
        supportedPlatform = [[NSMutableDictionary alloc] init];
    }
    [supportedPlatform setObject:key forKey:platform];
}

+ (NSString *)apiKeyForPlatform:(NSString *)platform{
    return [supportedPlatform objectForKey:platform];
}

+ (void)applicationDidBecomeActie:(UIApplication *)application{
    for (NSString *key in supportedPlatform.allKeys) {
        SEL sel=NSSelectorFromString([NSString stringWithFormat:@"%@_applicationDidBecomeActie:", key]);
        if ([self respondsToSelector:sel]) {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                                        [self methodSignatureForSelector:sel]];
            [invocation setSelector:sel];
            [invocation setTarget:self];
            
            id arg1 = application;
            
            [invocation setArgument:&arg1 atIndex:2];
            [invocation invoke];
        }else{
            NSLog(@"fatal error: %@ is should have a method: %@",key ,[NSString stringWithFormat:@"%@_applicationDidBecomeActie:", key]);
        }
    }
}

+ (BOOL)connectSocialPlatformWithApplication:(UIApplication *)application
               didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    BOOL returnValue = YES;
    for (NSString *key in supportedPlatform.allKeys) {
        SEL sel=NSSelectorFromString([NSString stringWithFormat:@"connect%@WithApplication:didFinishLaunchingWithOptions:", key]);
        if ([self respondsToSelector:sel]) {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                                        [self methodSignatureForSelector:sel]];
            [invocation setSelector:sel];
            [invocation setTarget:self];
            
            id arg1 = application;
            id arg2 = launchOptions;
            
            [invocation setArgument:&arg1 atIndex:2];
            [invocation setArgument:&arg2 atIndex:3];
            [invocation invoke];
            BOOL result = NO;
            [invocation getReturnValue:&result];
            if (!result) {
                returnValue = NO;
            }
        }else{
            NSLog(@"fatal error: %@ is should have a method: %@",key ,[NSString stringWithFormat:@"connect%@WithApplication:didFinishLaunchingWithOptions:", key]);
        }
    }
    return returnValue;
}

+ (BOOL)handleOpenURL:(UIApplication *)application
              openURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation{
    BOOL returnValue = YES;
    for (NSString *key in supportedPlatform.allKeys) {
        SEL sel=NSSelectorFromString([key stringByAppendingString:@"_handleOpenURL:openURL:sourceApplication:annotation:"]);
        if ([self respondsToSelector:sel]) {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                                        [self methodSignatureForSelector:sel]];
            [invocation setSelector:sel];
            [invocation setTarget:self];
            
            id arg1 = application;
            id arg2 = url;
            id arg3 = sourceApplication;
            id arg4 = annotation;
            
            [invocation setArgument:&arg1 atIndex:2];
            [invocation setArgument:&arg2 atIndex:3];
            [invocation setArgument:&arg3 atIndex:4];
            [invocation setArgument:&arg4 atIndex:5];
            [invocation invoke];
            
            BOOL result = NO;
            [invocation getReturnValue:&returnValue];
            if (!result) {
                returnValue = NO;
            }
        }else{
            NSLog(@"fatal error: %@ is should have a method: %@",key,[key stringByAppendingString:@"_handleOpenURL"]);
        }
    }
    return returnValue;
}

+ (void)shareModal:(id<SocialLibMessage>)obj
        toPlatform:(NSString *)platform
           success:(SLShareSuccess)successBlock
           failure:(SLShareFailure)failureBlock{
    SEL sel=NSSelectorFromString([NSString stringWithFormat:@"shareModalTo%@:success:failure:", platform]);
    if ([self respondsToSelector:sel]) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                                    [self methodSignatureForSelector:sel]];
        [invocation setSelector:sel];
        [invocation setTarget:self];
        
        id arg1 = obj;
        id arg2 = successBlock;
        id arg3 = failureBlock;
        
        [invocation setArgument:&arg1 atIndex:2];
        [invocation setArgument:&arg2 atIndex:3];
        [invocation setArgument:&arg3 atIndex:4];
        [invocation invoke];
    }else{
        NSError *error = [NSError errorWithDomain:@"SocialLib"
                                             code:0
                                         userInfo:@{NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Unsupported Platform : %@", platform]}];
        
        failureBlock(nil, error);
    }
    
}

@end
