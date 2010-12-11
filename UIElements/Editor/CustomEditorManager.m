//
//  CustomEditorManager.m
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 12/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CustomEditorManager.h"
#import "PropertyMetaModel.h"

#import "QuickTextFieldPropertyEditorController.h"
#import "QuickTextViewPropertyEditorController.h"
#import "QuickCustomObjectPropertyEditorController.h"
#import "QuickBoolPropertyEditorController.h"

@implementation CustomEditorManager

@synthesize Editors;

- (id) init
{
    self = [super init];
    if (self != nil) {
        self.Editors = [NSMutableDictionary dictionary];
        
        [self registerEditor:[QuickTextFieldPropertyEditorController class] forTypeKey:PropertyMetaModelTypeKey_StringSingleLine];
        [self registerEditor:[QuickTextViewPropertyEditorController class] forTypeKey:PropertyMetaModelTypeKey_StringMultipleLine];
        [self registerEditor:[QuickTextFieldPropertyEditorController class] forTypeKey:PropertyMetaModelTypeKey_NSNumber];
        //[self registerEditor:[QuickTextFieldPropertyEditorController class] forTypeKey:PropertyMetaModelTypeKey_NSDate];
        [self registerEditor:[QuickBoolPropertyEditorController class] forTypeKey:PropertyMetaModelTypeKey_bool];
        [self registerEditor:[QuickTextFieldPropertyEditorController class] forTypeKey:PropertyMetaModelTypeKey_int];
        [self registerEditor:[QuickTextFieldPropertyEditorController class] forTypeKey:PropertyMetaModelTypeKey_float];
        [self registerEditor:[QuickTextFieldPropertyEditorController class] forTypeKey:PropertyMetaModelTypeKey_double];
        [self registerEditor:[QuickCustomObjectPropertyEditorController class] forTypeKey:PropertyMetaModelTypeKey_CustomObject];
    }
    return self;
}

// Singleton
static CustomEditorManager* _current = NULL;
+ (CustomEditorManager*) current
{
    @synchronized(self)
    {
        if(_current == NULL)
            _current = [[self alloc] init];
    }
    return _current;
}

- (void) registerEditor:(Class)_class forTypeKey:(NSString*)_key
{
    [self.Editors setObject:_class forKey:_key];
}

- (UIViewController*) getEditorForProperty:(PropertyMetaModel*)_property object:(NSObject*)_obj navController:(UINavigationController*)_navController
{
    Class cls = [self.Editors objectForKey:_property.TypeKey];
    return [[[cls alloc] initWithProperty:_property onObject:_obj navController:_navController] autorelease];
}

- (void) dealloc
{
    self.Editors = nil;
    
    [super dealloc];
}


@end
