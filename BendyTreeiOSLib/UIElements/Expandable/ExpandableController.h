//
//  ExpandableController.h
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 10/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ExpandableController : UIViewController {
    
    int fullHeight;
    
}

- (NSArray*) controllers;
@property (retain) NSArray* _controllers;
@property (retain) UIScrollView* scroller;

- (id) initWithControllers:(NSArray*)_controllers height:(int)_height;

- (void) performSelectorOnControllers:(SEL)selector;
- (void) updateHeight:(int)_height;

+ (void) repositionParentOf:(UIViewController*)controller;

@end
