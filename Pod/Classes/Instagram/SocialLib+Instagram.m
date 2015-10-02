//
//  SocialLib+Instagram.m
//  Pods
//
//  Created by Yeung Yiu Hung on 28/9/15.
//
//

#import "SocialLib+Instagram.h"

@implementation SocialLib (Instagram)

static UIDocumentInteractionController *dic;

+ (void)load{
    [self addPlatform:kSocialLibPlatformInstagram withKey:@"instagram"];
}

+ (BOOL)connectInstagramWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return YES;
}

+ (BOOL)Instagram_handleOpenURL:(UIApplication *)application
                     openURL:(NSURL *)url
           sourceApplication:(NSString *)sourceApplication
                  annotation:(id)annotation{
    return YES;
}

+ (void)Instagram_applicationDidBecomeActie:(UIApplication *)application{
    
}

+ (void)shareModalToInstagram:(id<SocialLibInstagramMessage>)obj
                   success:(SLShareSuccess)successBlock
                   failure:(SLShareFailure)failureBlock{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"instagram://app"]]) {
        if (obj.instagramMessageType == SocialLibInstagramMessageTypeURL) {
            NSURL *imgURL = [NSURL URLWithString:obj.socialLibInstagramURL];
            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:imgURL
                                                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                                  timeoutInterval:39]
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                       if (connectionError) {
                                           failureBlock(nil, connectionError);
                                       }else{
                                           // Create path.
                                           NSString* imagePath = [NSString stringWithFormat:@"%@/instagramShare.igo", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
                                           [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
                                           UIImage *image = [UIImage imageWithData:data];
                                           [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
                                           NSLog(@"Image Size >>> %@", NSStringFromCGSize(image.size));
                                           
                                           dic=[UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:imagePath]];
                                           dic.delegate = [SocialLib sharedInstance];
                                           dic.UTI = @"com.instagram.exclusivegram";
                                           UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
                                           
                                           [dic presentOpenInMenuFromRect:controller.view.frame inView:controller.view animated:YES];
                                           
                                           successBlock(nil);
                                       }
                                   }];
        }else{
            // Create path.
            NSString* imagePath = [NSString stringWithFormat:@"%@/instagramShare.igo", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
            [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
            UIImage *image = obj.socialLibInstagramImage;
            [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
            NSLog(@"Image Size >>> %@", NSStringFromCGSize(image.size));
            
            dic=[UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:imagePath]];
            dic.delegate = [SocialLib sharedInstance];
            dic.UTI = @"com.instagram.exclusivegram";
            UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
            
            [dic presentOpenInMenuFromRect:controller.view.frame inView:controller.view animated:YES];
            
            successBlock(nil);
        }
    }else{
        NSError *error = [NSError errorWithDomain:@"SocialLib"
                                             code:9
                                         userInfo:@{NSLocalizedDescriptionKey : @"Instagram not install"}];
        failureBlock(nil, error);
    }
}

@end
