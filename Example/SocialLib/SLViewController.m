//
//  SLViewController.m
//  SocialLib
//
//  Created by Yeung Yiu Hung on 09/27/2015.
//  Copyright (c) 2015 Yeung Yiu Hung. All rights reserved.
//

#import "SLViewController.h"
#import "InfoModal.h"
#import <SocialLib/SLGlobal.h>

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
    info.infoContentURL = @"http://darkcl.github.io";
    [SocialLib shareModal:info
               toPlatform:kSocialLibPlatformFacebook
                  success:^(NSDictionary *message) {
                      NSLog(@"%@", message);
                  }
                  failure:^(NSDictionary *message, NSError *error) {
                      NSLog(@"%@", error);
                  }];
}

@end
