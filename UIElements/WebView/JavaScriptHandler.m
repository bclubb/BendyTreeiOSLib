//
//  JavaScriptHandler.m
//  BibleAppSource
//
//  Created by JOSHUA WRIGHT on 5/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "JavaScriptHandler.h"
#import "JSON.h"
#import "JavaScriptManipulator.h"

@implementation JavaScriptHandler

- (id) initWithManipulator:(JavaScriptManipulator*)_manipulator
{
    self = [super init];
    if (self != nil) {
        manipulator = _manipulator;
    }
    return self;
}



- (BOOL) webView:(UIWebView *)wv shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* url = [[request URL] absoluteString];
    NSString* selectorStr = [[url substringFromIndex:21] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSMutableArray* info = [NSMutableArray arrayWithArray:[selectorStr JSONValue]];
    
    NSString* callId = [info objectAtIndex:0];
    [info removeObjectAtIndex:0];
    
    NSString* methodName = [info objectAtIndex:0];
    [info removeObjectAtIndex:0];
    
    SEL selector = NSSelectorFromString(methodName);
    id result;
    if([self respondsToSelector:selector])
    {
        result = [self performSelector:selector];
    }
    else
    {
        selector = NSSelectorFromString([NSString stringWithFormat:@"%@:", methodName]);
        if([self respondsToSelector:selector])
            result = [self performSelector:selector withObject:info];
    }
    
    if([callId length] > 0)
        [manipulator respondTo: callId with: result];
    
    return NO;
}

@end
