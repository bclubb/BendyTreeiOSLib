//
//  Callback.m
//  BibleAppSource
//
//  Created by JOSHUA WRIGHT on 5/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Callback.h"


@implementation Callback


- (id) initWithObject:(id)_obj andSelector:(SEL)_sel
{
    self = [super init];
    if (self != nil) {
        obj = _obj;
        sel = _sel;
    }
    return self;
}

- (void) execute
{
    [obj performSelector:sel];
}

- (void) executeWithObject:(id)arg
{
    [obj performSelector:sel withObject:arg];
}

+ (id) fromObject:(id)obj andSelector:(SEL)sel
{
    return [[[Callback alloc] initWithObject:obj andSelector:sel] autorelease];
}


@end
