//
//  SLViewController.m
//  SocialLib
//
//  Created by Yeung Yiu Hung on 09/27/2015.
//  Copyright (c) 2015 Yeung Yiu Hung. All rights reserved.
//

#import "SLViewController.h"
#import "InfoModal.h"
#import "UIActionSheet+Blocks.h"

@interface SLViewController ()

@end

@implementation SLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareToFacebook:(id)sender {
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
}

- (IBAction)shareToTwitter:(id)sender {
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
}

- (IBAction)shareToTumblr:(id)sender {
//    [SocialLib shareModal:nil
//               toPlatform:kSocialLibPlatformTumblr
//                  success:^(NSDictionary *message) {
//                      NSLog(@"%@", message);
//                  }
//                  failure:^(NSDictionary *message, NSError *error) {
//                      NSLog(@"%@", error);
//                  }];
    InfoModal *info = [[InfoModal alloc] init];
    info.infoTitle = @"SocialLib";
    info.infoContent = @"Share via SocialLib";
    info.infoContentURL = @"http://darkcl.github.io/SocialLib";
    
    [SocialLib getTumblrBlogsWithSuccess:^(NSArray *blogs) {
        [UIActionSheet presentOnView:self.view
                           withTitle:@"Select Blog"
                        cancelButton:@"Cancel"
                   destructiveButton:nil
                        otherButtons:blogs
                            onCancel:^(UIActionSheet *actionSheet) {
                                
                            }
                       onDestructive:^(UIActionSheet *actionSheet) {
                           
                       }
                     onClickedButton:^(UIActionSheet *actionSheet, NSUInteger buttonIndex) {
                         NSString *selectedBlog = [actionSheet buttonTitleAtIndex:buttonIndex];
                                                          [SocialLib setTumblrBlog:selectedBlog];
                                                          [SocialLib shareModal:info
                                                                     toPlatform:kSocialLibPlatformTumblr
                                                                        success:^(NSDictionary *message) {
                                                                            NSLog(@"%@", message);
                                                                        }
                                                                        failure:^(NSDictionary *message, NSError *error) {
                                                                            NSLog(@"%@", error);
                                                                        }];
                     }];
    }
                                 failure:^(NSError *error) {
                                     
                                 }];
    
    
}

- (IBAction)shareToWeibo:(id)sender {
    InfoModal *info = [[InfoModal alloc] init];
    info.infoTitle = @"SocialLib";
    info.infoContent = @"Share via SocialLib";
    info.infoContentURL = @"http://darkcl.github.io/SocialLib";
    [SocialLib shareModal:info
               toPlatform:kSocialLibPlatformWeibo
                  success:^(NSDictionary *message) {
                      NSLog(@"%@", message);
                  }
                  failure:^(NSDictionary *message, NSError *error) {
                      NSLog(@"%@", error);
                  }];
}

- (IBAction)shareToWeixin:(id)sender {
    InfoModal *info = [[InfoModal alloc] init];
    info.infoTitle = @"SocialLib";
    info.infoContent = @"Share via SocialLib";
    info.infoContentURL = @"http://darkcl.github.io/SocialLib";
    [SocialLib shareModal:info
               toPlatform:kSocialLibPlatformWeixin
                  success:^(NSDictionary *message) {
                      NSLog(@"%@", message);
                  }
                  failure:^(NSDictionary *message, NSError *error) {
                      NSLog(@"%@", error);
                  }];
}

@end
