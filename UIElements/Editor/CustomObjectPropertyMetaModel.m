//
//  CustomObjectPropertyMetaModel.m
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 12/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CustomObjectPropertyMetaModel.h"
#import "PropertyMetaModel.h"
#import "QuickCustomObjectPropertyEditorController.h"

@implementation CustomObjectPropertyMetaModel

@synthesize TypeMeta;


- (UIViewController*) newEditorOfObject:(NSObject*)_obj
{
    return [[[QuickCustomObjectPropertyEditorController alloc] initWithProperty:self onObject:_obj] autorelease];
}


- (void) dealloc
{
    self.TypeMeta = nil;
    
    [super dealloc];
}

@end
