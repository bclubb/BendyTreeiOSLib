//
//  ZoomTextView.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ZoomTextView.h"
#import "ZoomTextDelegate.h"
#import "Callback.h"

@implementation ZoomTextView

@synthesize zoomInfo;

- (id)initWithCoder:(NSCoder *)inCoder;
{
    self = [super initWithCoder:inCoder];
    if (self != nil) {
        
        self.delegate = [[ZoomTextDelegate alloc] initWithZoomTextElement:self];
        self.zoomInfo = [[[ZoomInfo alloc] init] autorelease];
        
    }
    return self;
}

- (CGSize) zoomedSize
{
    return CGSizeMake(320, INT_MAX);
}

- (void) dealloc
{
    [self.delegate release]; //not (retain) so manual release
    self.delegate = nil;
    self.zoomInfo = nil;
    
    [super dealloc];
}

@end
