//
//  ZoomInfo.h
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Callback.h"

@interface ZoomInfo : NSObject {

}

@property (assign) UIResponder* next;
@property (assign) UIResponder* previous;

@property (retain) Callback* onComplete;
@property (retain) NSString* title;

+ (void) arrange:(id) first, ...;

@end
