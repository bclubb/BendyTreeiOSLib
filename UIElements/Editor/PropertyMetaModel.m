//
//  PropertyMetaModel.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PropertyMetaModel.h"
#import "CustomEditorManager.h"
#import "ObjectMetaModel.h"


NSString * const PropertyMetaModelTypeKey_StringSingleLine = @"StringSingleLine";
NSString * const PropertyMetaModelTypeKey_StringMultipleLine = @"StringMultipleLine";
NSString * const PropertyMetaModelTypeKey_NSDate = @"NSDate";
NSString * const PropertyMetaModelTypeKey_NSNumber = @"NSNumber";
NSString * const PropertyMetaModelTypeKey_bool = @"bool";
NSString * const PropertyMetaModelTypeKey_int = @"int";
NSString * const PropertyMetaModelTypeKey_float = @"float";
NSString * const PropertyMetaModelTypeKey_double = @"double";
NSString * const PropertyMetaModelTypeKey_CustomObject = @"CustomObject";


@implementation PropertyMetaModel

@synthesize Name, TypeKey, TypeMeta, PropertyKey, _ObjectMeta;


- (id) init
{
    self = [super init];
    if (self != nil) {

    }
    return self;
}

- (UIViewController*) newEditorOfObject:(NSObject*)_obj navController:(UINavigationController*)_navController
{
    return [[CustomEditorManager current] getEditorForProperty:self object:_obj navController:_navController];
}

- (id) getValueOnObject:(id)_obj
{
    return [_obj valueForKey:self.PropertyKey];
}

- (void) setValue:(id)val onObject:(id)_obj
{
    [_obj setValue:val forKey:self.PropertyKey];
}


- (void) dealloc
{
    self.Name = nil;
    self.TypeKey = nil;
    self.TypeMeta = nil;
    self.PropertyKey = nil;
    self._ObjectMeta = nil;
    
    [super dealloc];
}


@end
