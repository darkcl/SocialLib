//
//  InfoModal.h
//  SocialLib
//
//  Created by Yeung Yiu Hung on 27/9/15.
//  Copyright © 2015 Yeung Yiu Hung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocialLib/SocialLib.h>

@interface InfoModal : NSObject <SocialLibMessage>{
    
}

@property (nonatomic, strong) NSString *infoTitle;
@property (nonatomic, strong) NSString *infoContent;
@property (nonatomic, strong) NSString *infoContentURL;
@property (nonatomic, strong) NSArray *infoImages;
@property (nonatomic, strong) NSString *infoThumbnailImageURL;
@property (nonatomic, strong) NSString *infoVideoURL;

@end
