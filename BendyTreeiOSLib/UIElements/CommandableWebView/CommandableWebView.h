//
//  CommandableWebView.h
//  AllStarApps
//
//  Created by JOSHUA WRIGHT on 12/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CommandableWebView : UIWebView<UIWebViewDelegate> {

}

@property (retain) id<UIWebViewDelegate> delegate2;
@property (retain) NSMutableDictionary* schemeToCommandClasses;
@property (retain) UIViewController* anchorController;

- (void) registerSchemeToCommandClasses:(NSString*)_scheme commands:(NSArray*)_commandClasses;
- (void) injectScript:(NSString*)_name extension:(NSString*)_extension;
- (void) respondToWeb:(NSString*)callbackId with:(id)val;

@end
