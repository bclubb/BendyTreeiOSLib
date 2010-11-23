//
//  ZoomManager.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ZoomBackgroundManager.h"
#import "ZoomManager.h"
#import "UIView+Position.h"


@implementation ZoomManager

- (void) zoomIn:(UIView*)txt withHeight:(int)height
{
    if(originalSuperview == nil)
    {
        originalFrame = txt.frame;
        originalSuperview = txt.superview;
    }
    [[ZoomBackgroundManager current] zoomIn:txt withHeight:height];
}


- (void) zoomOut:(UIView *)txt
{
    [[ZoomBackgroundManager current] zoomOut:txt originalSuperview:originalSuperview originalFrame:originalFrame];
}


- (void) dealloc
{    
    [super dealloc];
}


@end
