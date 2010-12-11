//
//  PropertyMetaModel.h
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectMetaModel.h"


extern NSString* const PropertyMetaModelTypeKey_StringSingleLine;
extern NSString* const PropertyMetaModelTypeKey_StringMultipleLine;
extern NSString* const PropertyMetaModelTypeKey_NSDate;
extern NSString* const PropertyMetaModelTypeKey_NSNumber;
extern NSString* const PropertyMetaModelTypeKey_bool;
extern NSString* const PropertyMetaModelTypeKey_int;
extern NSString* const PropertyMetaModelTypeKey_float;
extern NSString* const PropertyMetaModelTypeKey_double;
extern NSString* const PropertyMetaModelTypeKey_CustomObject;
extern NSString* const PropertyMetaModelTypeKey_Collection;


@interface PropertyMetaModel : NSObject {

}

@property (retain) ObjectMetaModel* _ObjectMeta;
@property (retain) NSString* PropertyKey;
@property (retain) NSString* Name;
@property (retain) NSString* TypeKey;
@property (retain) NSString* SubTypeKey;
@property (retain) ObjectMetaModel* TypeMeta;

- (UIViewController*) newEditorOfObject:(NSObject*)_obj navController:(UINavigationController*)_navController;

- (id) getValueOnObject:(id)_obj;
- (void) setValue:(id)val onObject:(id)_obj;

@end



@protocol IPropertyEditorController

- (id)initWithProperty:(PropertyMetaModel*)_property onObject:(NSObject*)_obj navController:(UINavigationController*)_navController;

@end