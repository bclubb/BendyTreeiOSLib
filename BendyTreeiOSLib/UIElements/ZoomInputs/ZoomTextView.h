//
//  ZoomTextView.h
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Callback.h"
#import "IZoomable.h"
#import "ZoomInfo.h"

@interface ZoomTextView : UITextView<IZoomable> {

}

@property (retain) ZoomInfo* zoomInfo;

@end
