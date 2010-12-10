//
//  PropertyMetaModel.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PropertyMetaModel.h"
#import "QuickTextFieldPropertyEditorController.h"
#import "ObjectMetaModel.h"

@implementation PropertyMetaModel

@synthesize Name, Key, _ObjectMeta;


- (id) init
{
    self = [super init];
    if (self != nil) {

    }
    return self;
}

- (UIViewController*) newEditorOfObject:(NSObject*)_obj
{
    [NSException raise:@"Should be overridden" format:@"Override Me"];
}

- (NSString*) getValueAsString:(id)_obj
{
    id val = [_obj valueForKey:self.Key];
    return [val description];
}

- (bool) setValue:(NSString*)str onObject:(id)_obj
{/*
    id val;
    if(self.Type == [NSString class]){
        val = str;
    }else if(self.Type == [NSNumber class]){
        NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
        val = [formatter numberFromString:str];
        [formatter release];
    }
    
    if(val == nil)
        return NO;
        
    [_obj setValue:val forKey:self.Key];
  */
    return YES;
}

- (void) dealloc
{
    self.Name = nil;
    self.Key = nil;
    self._ObjectMeta = nil;
    
    [super dealloc];
}


@end
