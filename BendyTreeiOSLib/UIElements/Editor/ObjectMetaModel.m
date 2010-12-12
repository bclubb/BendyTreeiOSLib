//
//  ObjectMetaModel.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ObjectMetaModel.h"
#import "PropertyMetaModel.h"
#import "StringFormatting.h"

@implementation ObjectMetaModel

@synthesize Properties, ClassName, DescriptionFormat;

- (id) init
{
    self = [super init];
    if (self != nil) {
        
        [self addObserver:self forKeyPath:@"Properties" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
        
        self.Properties = [NSMutableArray array];
        self.ClassName = [[NSMutableDictionary class] description];
        
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqual:@"Properties"]){
        for(PropertyMetaModel* property in self.Properties){
            property._ObjectMeta = self;
        }
    }
}

- (Class) getClass
{    
    return NSClassFromString(self.ClassName);
}

- (id) createNewInstance
{
    return [[[[self getClass] alloc] init] autorelease];
}

- (NSString*) describe:(id)obj
{
    if(self.DescriptionFormat)
        return [self.DescriptionFormat format:obj];
    
    return [obj description];
}

- (void) dealloc
{
    [self removeObserver:self forKeyPath:@"Properties"];
    
    self.Properties = nil;
    self.ClassName = nil;
    self.DescriptionFormat = nil;
    
    [super dealloc];
}



@end
