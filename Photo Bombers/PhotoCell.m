//
//  PhotoCell.m
//  Photo Bombers
//
//  Created by scott harris on 12/28/14.
//  Copyright (c) 2014 scott harris. All rights reserved.
//

#import "PhotoCell.h"

#import "PhotoController.h"

@implementation PhotoCell

- (void)setPhoto:(NSDictionary *)photo {
    _photo = photo;
    
    [PhotoController imageForPhoto:_photo size:@"thumbnail" completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(like)];
        tap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tap];
        
        
        [self.contentView addSubview:self.imageView];
        
    }
    
    return self;
}




-(void) layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.bounds;
}




- (void) like {
    
    NSLog(@"Link: %@", self.photo[@"link"]);
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    NSString *URLString = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/media/%@/likes?access_token=%@", self.photo[@"id"], accessToken];
    NSURL *URL = [[NSURL alloc] initWithString:URLString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    request.HTTPMethod = @"POST";
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showLikeCompletion];
        });
        
        
    }];
    
    [task resume];
    
}



- (void) showLikeCompletion {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Liked!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [alert show];
    
    double delayInSeconds = 1.0;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        
    });
}

@end
