//
//  JavaScriptHandler.h
//  BibleAppSource
//
//  Created by JOSHUA WRIGHT on 5/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JavaScriptManipulator.h"


@class BibleViewController;

@interface JavaScriptHandler : NSObject<UIWebViewDelegate> {
    
    JavaScriptManipulator* manipulator;
    
}

- (id) initWithManipulator:(JavaScriptManipulator*)_manipulator;

@end
