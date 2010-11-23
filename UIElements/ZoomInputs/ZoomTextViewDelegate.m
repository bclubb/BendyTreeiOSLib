//
//  ZoomTextViewDelegate.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ZoomTextViewDelegate.h"
#import "ZoomManager.h"

@implementation ZoomTextViewDelegate

@synthesize zoomManager;

- (id) init
{
    self = [super init];
    if (self != nil) {
        self.zoomManager = [[[ZoomManager alloc] init] autorelease];
    }
    return self;
}


- (void)textViewDidBeginEditing:(UITextView *)textView           // became first responder
{
    [self.zoomManager zoomIn:textView withHeight:180];
}

/*
- (BOOL)textViewShouldReturn:(UITextView *)textView              // called when 'return' key pressed. return NO to ignore.
{
    [self.zoomManager zoomOut:textView];
    [textView resignFirstResponder];
    return YES;  
}
*/

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [self.zoomManager zoomOut:textView];
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


- (void) dealloc
{    
    self.zoomManager = nil;
    
    [super dealloc];
}


@end
