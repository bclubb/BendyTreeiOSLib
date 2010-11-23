//
//  ZoomBackgroundManager.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ZoomBackgroundManager.h"
#import "UIView+Position.h"

@implementation ZoomBackgroundManager

@synthesize blackout;


- (id) init
{
    self = [super init];
    if (self != nil) {
        
        self.blackout = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
        [self.blackout setUserInteractionEnabled:YES];
        [self.blackout setBackgroundColor:[UIColor blackColor]];
        [self.blackout setOpaque:NO];
        label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 20)] autorelease];
        [label setText:@"This is Something"];
        [label setTextColor:[UIColor whiteColor]];
        [label setOpaque:NO];
        [label setBackgroundColor:[UIColor clearColor]];
        [self.blackout addSubview:label];
        
    }
    return self;
}



// Singleton
static ZoomBackgroundManager* _current = NULL;
+ (ZoomBackgroundManager*) current
{
    @synchronized(self)
    {
        if(_current == NULL)
            _current = [[self alloc] init];
    }
    return _current;
}


- (void) zoomIn:(UIView*)txt withHeight:(int)height
{    
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    
    [window addSubview:self.blackout];
    [self.blackout setAlpha:0];
    
    CGPoint newOrigin = [txt.superview convertPoint:txt.frame.origin toView:nil];
    [window addSubview:txt];
    [txt setX:newOrigin.x andY:newOrigin.y];
    
    int fullHeight = 245;
    height = MIN(height, fullHeight - label.frame.size.height);
    int top = 20;
    int padding = (fullHeight - (height + label.frame.size.height)) / 2;
    [label setY:top + padding];
        
    [UIView beginAnimations:@"ZoomTextField" context:nil];
    [UIView setAnimationDuration:.5];
    [self.blackout setAlpha:.9];
    [txt setFrame:CGRectMake(10, top+padding+label.frame.size.height, 300, height)];
    [UIView commitAnimations];
}


- (void) zoomOut:(UIView *)txt originalSuperview:(UIView*)originalSuperview originalFrame:(CGRect)originalFrame
{
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    
    CGPoint newOrigin = [window convertPoint:txt.frame.origin toView:originalSuperview];
    [originalSuperview addSubview:txt];
    [txt setX:newOrigin.x andY:newOrigin.y];
    
    [UIView beginAnimations:@"ZoomTextField" context:nil];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationDidStopSelector:@selector(zoomOutCompleted)];
    [txt setFrame:originalFrame];
    [self.blackout setAlpha:0];
    [UIView commitAnimations];
}

- (void) zoomOutCompleted
{
    [self.blackout removeFromSuperview];
}


- (void) dealloc
{
    self.blackout = nil;
    
    [super dealloc];
}


@end
