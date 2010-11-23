//
//  JavaScriptManipulator.h
//  BibleAppSource
//
//  Created by JOSHUA WRIGHT on 5/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JavaScriptManipulator : NSObject {

    UIWebView* web;
    
}

- (id) initWithWebView:(UIWebView*)_web;

- (void) respondTo:(NSString*)callId with:(id)val;

@end
