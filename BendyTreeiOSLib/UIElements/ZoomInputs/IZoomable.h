//
//  IZoomable.h
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZoomInfo.h"

@protocol IZoomable

- (ZoomInfo*) zoomInfo;

- (CGSize) zoomedSize;


@end
