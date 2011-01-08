//
//  CommandableWebView.m
//  AllStarApps
//
//  Created by JOSHUA WRIGHT on 12/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CommandableWebView.h"
#import "JSON.h"
#import "WebCommand.h"
#import "RegexKitLite.h"

#import "AlertCommand.h"

@interface CommandableWebView()
- (WebCommand*) getMatchingWebCommand:(NSURLRequest*)request;
@end


@implementation CommandableWebView

@synthesize delegate2, schemeToCommandClasses, anchorController;

#pragma mark Initialization

- (void) initialize
{
    self.delegate = self;
    self.schemeToCommandClasses = [NSMutableDictionary dictionary];
    
    [self registerSchemeToCommandClasses:@"system" commands:[NSArray arrayWithObjects:[AlertCommand class], nil]];
}

#pragma mark Delegate Events

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL* url = [request URL];
    
    /** WebCommands: If the url matches a web command, then fire the command **/
    WebCommand* command = [self getMatchingWebCommand:request];
    if (command)
    {    
        //Let another command fire
        [self stringByEvaluatingJavaScriptFromString:@"window.AppCommander.setReadyToFire(true);"];
        
        //Fire it
        id result = [command execute];

        //Callback the webview (if there's a callback id)
        NSArray* callbackMatches = [[[request URL] absoluteString] arrayOfCaptureComponentsMatchedByRegex:@"callbackId=(\\d+)"];
        if([callbackMatches count] > 0)
            [self respondToWeb:[[callbackMatches objectAtIndex:0] objectAtIndex:1] with:result];

        return NO;
    }
    
    /** Normal Url: Do the normal thing */
    else if ([url isFileURL] || [[url scheme] isEqualToString:@"http"] || [[url scheme] isEqualToString:@"https"])
    {
        if(self.delegate2 && [self.delegate2 respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)])
            return [self.delegate2 webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
        return YES;
    }
    
    /** Probably a phone call or something */
    else
    {
        [[UIApplication sharedApplication] openURL:url];
        return NO;
	}
    
    return NO;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if([self.delegate2 respondsToSelector:@selector(webViewDidStartLoad:)])
        [self.delegate2 webViewDidStartLoad:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self injectScript:@"CommandableWebView" extension:@"txt"];
    
    if([self.delegate2 respondsToSelector:@selector(webViewDidFinishLoad:)])
        [self.delegate2 webViewDidFinishLoad:webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if([self.delegate2 respondsToSelector:@selector(webView:didFailLoadWithError:)])
        [self.delegate2 webView:webView didFailLoadWithError:error];
}


#pragma mark Manage Commands

- (void) respondToWeb:(NSString*)callbackId with:(id)val
{
    if([callbackId length] > 0)
    {
        NSString* responseJson = nil;
        if([val isKindOfClass:[NSString class]] && ([(NSString*)val hasPrefix:@"{"] || [(NSString*)val hasPrefix:@"["])){
            //if response is a JSON string, send it back without messing with it
            responseJson = [NSString stringWithFormat:@"{value:%@}", val];
        }else{
            //otherwise serialize it
            NSMutableDictionary* responseDic = [NSMutableDictionary dictionaryWithObjectsAndKeys: val, @"value", nil];
            responseJson = [responseDic JSONRepresentation];
        }
        
        NSString* script = [NSString stringWithFormat:@"window.AppCommander.respondToCommand(\"%@\", %@);", callbackId, responseJson];
        [self stringByEvaluatingJavaScriptFromString: script];
    }
}

- (void) injectScript:(NSString*)_name extension:(NSString*)_extension
{    
    NSString* path = [[NSBundle mainBundle] pathForResource:_name ofType:_extension];
    NSString* origJs = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSString* newJs = [NSString stringWithFormat:@"(function(){ %@ })();", origJs];
    [self stringByEvaluatingJavaScriptFromString:newJs];    
}

- (void) registerSchemeToCommandClasses:(NSString*)_scheme commands:(NSArray*)_commandClasses
{
    [self.schemeToCommandClasses setObject:_commandClasses forKey:_scheme];
}

- (WebCommand*) getMatchingWebCommand:(NSURLRequest*)request
{
    NSString* currentScheme = [[request URL] scheme];
    
    for(NSString* scheme in [self.schemeToCommandClasses allKeys]){
        if([scheme caseInsensitiveCompare:currentScheme] == NSOrderedSame){
            //All this to deserialize the arguments
            NSString* escapedArgsString = [[[request URL] absoluteString] substringFromIndex:3 + [scheme length]];
            escapedArgsString = [[escapedArgsString componentsSeparatedByString:@"?"] objectAtIndex:0];
            if([escapedArgsString length] == 0) return nil;
            NSArray* escapedComponents = [escapedArgsString componentsSeparatedByString:@"/"];
            NSMutableArray* components = [NSMutableArray array];
            for(NSString* escapedComponent in escapedComponents)
            {
                NSString* component = [[escapedComponent stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if(![component hasPrefix:@"["] && ![component hasPrefix:@"{"] && ![component isMatchedByRegex:@"^[-+ 0-9.]*$"])
                    component = [NSString stringWithFormat:@"\"%@\"", [component stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""]];
                if([component isEqualToString:@"\"undefined\""] || [component isEqualToString:@"\"null\""])
                    component = @"null";
                [components addObject:component];
            }
            NSString* jsonArgs = [NSString stringWithFormat:@"[%@]", [components componentsJoinedByString:@", "]];            
            NSMutableArray* args = [NSMutableArray arrayWithArray:[jsonArgs JSONValue]];
            
            //Pop the key
            NSString* key = [[args objectAtIndex:0] description];
            [args removeObjectAtIndex:0];
            
            //If the anchor hasn't been set, then yell at the developer
            if(self.anchorController == nil){
                [NSException raise:@"anchorController in CommandableWebView must be set, but isn't" format:@""];
            }
            
            //look for a match
            for(Class commandClass in [self.schemeToCommandClasses objectForKey:scheme])
                if([commandClass respondsToSelector:@selector(matchesKey:)])
                    if([commandClass performSelector:@selector(matchesKey:) withObject:key])
                        return [[[commandClass alloc] initWithArgs:args web:self] autorelease];
            
        }
    }
    
    return nil;
}


#pragma mark Constructors

- (id) init
{
    self = [super init];
    if (self != nil) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self != nil) {
        [self initialize];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self initialize];
    }
    return self;
}


- (void) dealloc
{
    self.schemeToCommandClasses = nil;
    self.delegate2 = nil;
    self.anchorController = nil;
    
    [super dealloc];
}



@end
