//
//  PrimitivePropertyMetaModel.m
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 12/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PrimitivePropertyMetaModel.h"
#import "PropertyMetaModel.h"
#import "QuickTextFieldPropertyEditorController.h"

@implementation PrimitivePropertyMetaModel

@synthesize Type;


- (UIViewController*) newEditorOfObject:(NSObject*)_obj
{
    return [[[QuickTextFieldPropertyEditorController alloc] initWithProperty:self onObject:_obj] autorelease];
}


- (void) dealloc
{
    self.Type = nil;
    
    [super dealloc];
}


@end
