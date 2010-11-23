//
//  ZoomTextFieldDelegate.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ZoomTextFieldDelegate.h"
#import "ZoomTextField.h"
#import "UIView+Position.h"
#import "ZoomManager.h"

@implementation ZoomTextFieldDelegate

@synthesize zoomManager;

- (id) init
{
    self = [super init];
    if (self != nil) {
        self.zoomManager = [[[ZoomManager alloc] init] autorelease];
    }
    return self;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    [self.zoomManager zoomIn:textField withHeight:textField.frame.size.height];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField              // called when 'return' key pressed. return NO to ignore.
{
    [self.zoomManager zoomOut:textField];
    [textField resignFirstResponder];
    return YES;  
}

- (void) dealloc
{    
    self.zoomManager = nil;
    
    [super dealloc];
}


@end
