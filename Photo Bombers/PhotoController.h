//
//  PhotoController.h
//  Photo Bombers
//
//  Created by scott harris on 1/1/15.
//  Copyright (c) 2015 scott harris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhotoController : NSObject

+ (void)imageForPhoto:(NSDictionary *)photo size:(NSString *)size completion:(void(^) (UIImage *image))completion;

@end
