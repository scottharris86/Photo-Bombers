//
//  DismissDetailTransition.m
//  Photo Bombers
//
//  Created by scott harris on 1/1/15.
//  Copyright (c) 2015 scott harris. All rights reserved.
//

#import "DismissDetailTransition.h"

@implementation DismissDetailTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *detail = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        detail.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [detail.view removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

@end
