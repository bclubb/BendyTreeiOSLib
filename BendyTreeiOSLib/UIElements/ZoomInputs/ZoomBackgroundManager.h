//
//  ZoomBackgroundManager.h
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Callback.h"
#import "ZoomTextDelegate.h"

@interface ZoomBackgroundManager : NSObject {
    UILabel* label;
    UIButton* btnPrev;
    UIButton* btnNext;
}

@property (retain) UIView* blackout;
@property (assign) ZoomTextDelegate* txtDelegate;

+ (ZoomBackgroundManager*) current;

- (void) zoomIn:(ZoomTextDelegate*)_txtDelegate;
- (void) pressedDone;

@end
