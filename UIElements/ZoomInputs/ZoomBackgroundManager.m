//
//  ZoomBackgroundManager.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ZoomBackgroundManager.h"
#import "UIView+Position.h"
#import "Callback.h"
#import "ZoomTextDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation ZoomBackgroundManager

@synthesize blackout, txtDelegate;


- (id) init
{
    self = [super init];
    if (self != nil) {
        
        self.blackout = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
        [self.blackout setUserInteractionEnabled:YES];
        [self.blackout setBackgroundColor:[UIColor blackColor]];
        [self.blackout setOpaque:NO];
        
        btnPrev = [[[UIBarButtonItem alloc] initWithTitle:@"PREV" style:UIBarButtonSystemItemAction target:self action:@selector(pressedPrev)] autorelease];
        btnNext = [[[UIBarButtonItem alloc] initWithTitle:@"NEXT" style:UIBarButtonSystemItemAction target:self action:@selector(pressedNext)] autorelease];
        UIButton* spacer = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil] autorelease];
        UIButton* btnDone = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pressedDone)] autorelease];
        
        UIToolbar* toolbar = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, 20+210, 320, 34)] autorelease];
        [toolbar setTintColor:[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1]];
        [toolbar setItems:[NSArray arrayWithObjects:btnPrev, btnNext, spacer, btnDone, nil]];        
        
        [self.blackout addSubview:toolbar];
        
        label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 20)] autorelease];
        [label setText:@"This is Something"];
        [label setFont:[UIFont fontWithName:@"Helvetica" size:16]];
        [label setTextAlignment:UITextAlignmentCenter];
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


- (void) zoomIn:(ZoomTextDelegate*)_txtDelegate
{    
    self.txtDelegate = _txtDelegate;
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    ZoomInfo* info = [self.txtDelegate.txt zoomInfo];
    
    [btnPrev setEnabled:info.previous != nil];
    [btnNext setEnabled:info.next != nil];
    
    [label setText:info.title];
    
    [window addSubview:self.blackout];
    [self.blackout setAlpha:0];
    
    CGPoint newOrigin = [self.txtDelegate.txt.superview convertPoint:self.txtDelegate.txt.frame.origin toView:nil];
    [window addSubview:self.txtDelegate.txt];
    [self.txtDelegate.txt setX:newOrigin.x andY:newOrigin.y];
    
    int yOffset = 20;
    CGSize maxSize = CGSizeMake(320, 210);
    CGRect txtFrame = CGRectMake(0, 0, 0, 0);
    txtFrame.size = [self.txtDelegate.txt zoomedSize];
    txtFrame.size.height = MIN(txtFrame.size.height, maxSize.height);
    txtFrame.size.width = MIN(txtFrame.size.width, maxSize.width);
    
    //center horizontal
    txtFrame.origin.x = (maxSize.width - txtFrame.size.width)/2;
    
    //center vertical
    CGFloat lblAndTxtHeight = txtFrame.size.height + label.frame.size.height;
    if(lblAndTxtHeight <= maxSize.height){ //SHOW LABEL TOO
        CGFloat lblY = yOffset + (maxSize.height - lblAndTxtHeight)/2;
        [label setY:lblY];
        txtFrame.origin.y = lblY + label.frame.size.height;
        [label setHidden:NO];
    }else{ //DO NOT SHOW LABEL
        [label setHidden:YES];
        txtFrame.origin.y = yOffset + (maxSize.height - txtFrame.size.height)/2;
    }
    
    [UIView beginAnimations:@"ZoomTextView" context:nil];
    [UIView setAnimationDuration:.5];
    [self.blackout setAlpha:.9];
    [self.txtDelegate.txt setFrame:txtFrame];
    [UIView commitAnimations];
}

- (void) pressedPrev
{
    [self pressedDone];
    [[self.txtDelegate.txt zoomInfo].previous becomeFirstResponder];
}

- (void) pressedNext
{
    [self pressedDone];
    [[self.txtDelegate.txt zoomInfo].next becomeFirstResponder];
}

- (void) pressedDone
{
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    
    [self.txtDelegate.txt resignFirstResponder];
    
    CGPoint newOrigin = [window convertPoint:self.txtDelegate.txt.frame.origin toView:self.txtDelegate.originalSuperview];
    [self.txtDelegate.originalSuperview addSubview:self.txtDelegate.txt];
    [self.txtDelegate.txt setX:newOrigin.x andY:newOrigin.y];
    
    [UIView beginAnimations:@"ZoomTextField" context:nil];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(zoomOutCompleted)];
    [self.txtDelegate.txt setFrame:self.txtDelegate.originalFrame];
    [self.blackout setAlpha:0];
    [UIView commitAnimations];
}


- (void) zoomOutCompleted
{
    [self.txtDelegate onZoomOutComplete];
}


- (void) dealloc
{
    self.blackout = nil;
    self.txtDelegate = nil;
    
    [super dealloc];
}




@end
