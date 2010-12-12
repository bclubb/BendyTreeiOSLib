//
//  MotionWindow.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 10/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MotionWindow.h"


@implementation MotionWindow

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DeviceShaken" object:self];
    }
}


@end
