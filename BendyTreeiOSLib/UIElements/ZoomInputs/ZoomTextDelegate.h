//
//  ZoomTextViewDelegate.h
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZoomTextView.h"

@protocol IZoomable;

@interface ZoomTextDelegate : NSObject<UITextViewDelegate, UITextFieldDelegate> {
    
}

@property (assign) UIView<IZoomable>* txt;
@property (assign) CGRect originalFrame;
@property (retain) UIView* originalSuperview;

- (id) initWithZoomTextElement:(UIView<IZoomable>*)_txt;
- (void) onZoomOutComplete;

@end
