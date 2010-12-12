//
//  ZoomTextField.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ZoomTextField.h"
#import "IZoomable.h"
#import "ZoomTextDelegate.h"

@implementation ZoomTextField

@synthesize zoomInfo;

- (id)initWithCoder:(NSCoder *)inCoder;
{
    self = [super initWithCoder:inCoder];
    if (self != nil) {
        
        self.delegate = [[ZoomTextDelegate alloc] initWithZoomTextElement:self];
        self.zoomInfo = [[[ZoomInfo alloc] init] autorelease];
        
        [self setReturnKeyType:UIReturnKeyDone];
        
    }
    return self;
}

- (CGSize) zoomedSize
{
    return CGSizeMake(300, self.frame.size.height);
}

- (void) dealloc
{
    [self.delegate release]; //not (retain) so manual release
    self.delegate = nil;
    self.zoomInfo = nil;
    
    [super dealloc];
}

@end
