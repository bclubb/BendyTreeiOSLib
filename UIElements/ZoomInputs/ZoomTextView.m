//
//  ZoomTextView.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ZoomTextView.h"
#import "ZoomTextViewDelegate.h"


@implementation ZoomTextView

@synthesize delegateReference;

- (id)initWithCoder:(NSCoder *)inCoder;
{
    self = [super initWithCoder:inCoder];
    if (self != nil) {
        
        self.delegate = [[[ZoomTextViewDelegate alloc] init] autorelease];
        self.delegateReference = self.delegate;
        
        [self setReturnKeyType:UIReturnKeyDone];
        
    }
    return self;
}

- (void) dealloc
{
    self.delegateReference = nil;
    
    [super dealloc];
}



@end
