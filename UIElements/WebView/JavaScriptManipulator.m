//
//  JavaScriptManipulator.m
//  BibleAppSource
//
//  Created by JOSHUA WRIGHT on 5/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "JavaScriptManipulator.h"
#import "JSON.h"

@implementation JavaScriptManipulator


- (id) initWithWebView:(UIWebView*)_web
{
    self = [super init];
    if (self != nil) {
        web = _web;
    }
    return self;
}


- (void) respondTo:(NSString*)callId with:(id)val
{
    NSMutableDictionary* responseDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys: val, @"value", nil];
    NSString* responseStr = [responseDic JSONRepresentation];
    NSString* script = [NSString stringWithFormat:@"window.AppResponseManager.set(\"%@\", %@);", callId, responseStr];
    [web stringByEvaluatingJavaScriptFromString: script];
}


@end
