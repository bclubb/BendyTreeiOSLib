//
//  Callback.h
//  BibleAppSource
//
//  Created by JOSHUA WRIGHT on 5/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Callback : NSObject {

    id obj;
    SEL sel;
    
}

- (id) initWithObject:(id)_obj andSelector:(SEL)_sel;

+ (id) fromObject:(id)obj andSelector:(SEL)sel;

- (void) execute;
- (void) executeWithObject:(id)arg;

@end
