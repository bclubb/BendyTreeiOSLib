//
//  PropertyMetaModel.h
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectMetaModel.h"

@interface PropertyMetaModel : NSObject {

}

@property (retain) ObjectMetaModel* _ObjectMeta;
@property (retain) NSString* Key;
@property (retain) NSString* Name;

- (UIViewController*) newEditorOfObject:(NSObject*)_obj;

- (NSString*) getValueAsString:(id)_obj;
- (bool) setValue:(NSString*)str onObject:(id)_obj;

@end
