//
//  Page.m
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 11/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Page.h"


@implementation Page

@synthesize Name;

- (void) dealloc
{
    self.Name = nil;
    
    [super dealloc];
}


@end
