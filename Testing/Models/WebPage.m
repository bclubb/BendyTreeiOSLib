//
//  WebPage.m
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 11/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WebPage.h"


@implementation WebPage

@synthesize Url;

- (id) init
{
    self = [super init];
    if (self != nil) {

    }
    return self;
}


- (void) dealloc
{
    self.Url = nil;
    
    [super dealloc];
}


@end
