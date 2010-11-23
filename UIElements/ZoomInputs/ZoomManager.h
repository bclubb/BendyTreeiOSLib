//
//  ZoomManager.h
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZoomManager : NSObject {

    CGRect originalFrame;
    UIView* originalSuperview;
    
}

- (void) zoomIn:(UIView*)txt withHeight:(int)height;
- (void) zoomOut:(UIView *)txt;

@end
