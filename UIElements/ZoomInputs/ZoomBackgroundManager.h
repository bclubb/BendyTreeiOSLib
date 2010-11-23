//
//  ZoomBackgroundManager.h
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZoomBackgroundManager : NSObject {
    
    UILabel* label;
    
}

@property (retain) UIView* blackout;

+ (ZoomBackgroundManager*) current;

- (void) zoomIn:(UIView *)txt withHeight:(int)height;
- (void) zoomOut:(UIView *)txt originalSuperview:(UIView*)originalSuperview originalFrame:(CGRect)originalFrame;

@end
