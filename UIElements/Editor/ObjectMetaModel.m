//
//  ObjectMetaModel.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ObjectMetaModel.h"
#import "PropertyMetaModel.h"

@implementation ObjectMetaModel

@synthesize Properties;

- (id) init
{
    self = [super init];
    if (self != nil) {
        
        [self addObserver:self forKeyPath:@"Properties" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
        
        self.Properties = [NSMutableArray array];
        
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



- (void) dealloc
{
    [self removeObserver:self forKeyPath:@"Properties"];
    
    self.Properties = nil;
    
    [super dealloc];
}



@end
