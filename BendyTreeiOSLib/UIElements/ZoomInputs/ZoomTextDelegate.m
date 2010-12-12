//
//  ZoomTextViewDelegate.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ZoomTextDelegate.h"
#import "ZoomBackgroundManager.h"
#import "IZoomable.h"

@implementation ZoomTextDelegate

@synthesize txt, originalFrame, originalSuperview;

- (id) initWithZoomTextElement:(UIView<IZoomable>*)_txt
{
    self = [super init];
    if (self != nil) {
        self.txt = _txt;
    }
    return self;
}


#pragma mark Text View Specific
- (void)textViewDidBeginEditing:(UITextView *)ignore           // became first responder
{
    self.originalFrame = self.txt.frame;
    self.originalSuperview = self.txt.superview;
    
    [[ZoomBackgroundManager current] zoomIn:self];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {    
    return YES;
}


#pragma mark Text Field Specific

- (void)textFieldDidBeginEditing:(id)ignore           // became first responder
{
    self.originalFrame = self.txt.frame;
    self.originalSuperview = self.txt.superview;
    
    [[ZoomBackgroundManager current] zoomIn:self]; //withHeight:self.txt.frame.size.height
}

- (BOOL)textFieldShouldReturn:(id)ignore              // called when 'return' key pressed. return NO to ignore.
{
    [[ZoomBackgroundManager current] pressedDone];
    //[self.txt resignFirstResponder];
    return YES;  
}


#pragma mark Events

- (void) onZoomOutComplete
{    
    [[[self.txt zoomInfo] onComplete] execute];
}


- (void) dealloc
{    
    self.txt = nil;
    self.originalSuperview = nil;
    
    [super dealloc];
}

@end
