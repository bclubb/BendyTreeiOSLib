//
//  WidgetPage.m
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 11/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WidgetPage.h"


@implementation WidgetPage

@synthesize Widgets;

- (id) init
{
    self = [super init];
    if (self != nil) {
        self.Widgets = [NSArray array];
    }
    return self;
}


- (void) dealloc
{
    self.Widgets = nil;
    
    [super dealloc];
}


@end
