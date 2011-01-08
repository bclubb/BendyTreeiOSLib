//
//  WebCommand.m
//  AllStarApps
//
//  Created by JOSHUA WRIGHT on 12/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WebCommand.h"


@implementation WebCommand

@synthesize args, web;

+ (NSString*) key 
{
    [NSException raise:@"'key' should be overridden" format:@""];
    return @"";
}
    

- (id) initWithArgs:(NSArray*)_args web:(CommandableWebView*)_web
{
    self = [super init];
    if (self != nil) {
        self.args = _args;
        self.web = _web;
    }
    return self;
}

+ (bool) matchesKey:(NSString*)realKey
{
    return [realKey caseInsensitiveCompare:[self key]] == NSOrderedSame;
}

- (id) execute
{    
    return nil;
}


- (void) dealloc
{
    self.args = nil;
    self.web = nil;
    
    [super dealloc];
}

@end
