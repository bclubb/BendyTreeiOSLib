//
//  App.m
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 11/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppModel.h"


@implementation AppModel

@synthesize Id, Name, Sequence, IsActive, CreatedOn, Pages;

- (id) init
{
    self = [super init];
    if (self != nil) {
        self.Pages = [NSArray array];
    }
    return self;
}


- (void) dealloc
{
    self.Id = 0;
    self.Name = nil;
    self.Sequence = 0;
    self.IsActive = NO;
    self.CreatedOn = nil;
    self.Pages = nil;
    
    [super dealloc];
}


@end
