//
//  Observee.m
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 11/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Observee.h"


@implementation Observee

@synthesize Name;

- (id) init
{
    self = [super init];
    if (self != nil) {
        
        [self addObserver:self forKeyPath:@"Name" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
        
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqual:@"Name"]){
        NSLog(@"Name changed to: %@", self.Name);
    }
}

- (void) dealloc
{
    self.Name = nil;
    
    [super dealloc];
}


@end
