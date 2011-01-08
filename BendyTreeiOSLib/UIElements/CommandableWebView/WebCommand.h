//
//  WebCommand.h
//  AllStarApps
//
//  Created by JOSHUA WRIGHT on 12/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommandableWebView.h"

@interface WebCommand : NSObject {

}

@property (retain) NSArray* args;
@property (retain) CommandableWebView* web;

+ (NSString*) key;
+ (bool) matchesKey:(NSString*)realKey;

- (id) initWithArgs:(NSArray*)args web:(CommandableWebView*)_web;
- (id) execute;

@end
