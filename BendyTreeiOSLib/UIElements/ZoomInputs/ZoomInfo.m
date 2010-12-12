//
//  ZoomInfo.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ZoomInfo.h"
#import "IZoomable.h"

@implementation ZoomInfo

@synthesize onComplete, title, next, previous;

- (id) init
{
    self = [super init];
    if (self != nil) {
        
    }
    return self;
}

+ (void) arrange:(id) first, ...
{
    id eachObject;
    va_list argumentList;
    NSMutableArray* elements = [NSMutableArray array];
    if (first)                      // The first argument isn't part of the varargs list,
    {                                   // so we'll handle it separately.
        [elements addObject: first];
        va_start(argumentList, first);          // Start scanning for arguments after firstObject.
        while (eachObject = va_arg(argumentList, id)) // As many times as we can get an argument of type "id"
            [elements addObject: eachObject];               // that isn't nil, add it to self's contents.
        va_end(argumentList);
    }
    
    if([elements count] <= 1)
        return;
    
    for(int i=0; i<[elements count]; i++){
        id<IZoomable> el = [elements objectAtIndex:i];
        
        if(i != [elements count]-1)
            el.zoomInfo.next = [elements objectAtIndex:i+1];
        
        if(i != 0)
            el.zoomInfo.previous = [elements objectAtIndex:i-1];
    }
    
    
}



- (void) dealloc
{
    self.title = nil;
    self.onComplete = nil;
    self.next = nil;
    self.previous = nil;
    
    [super dealloc];
}



@end
