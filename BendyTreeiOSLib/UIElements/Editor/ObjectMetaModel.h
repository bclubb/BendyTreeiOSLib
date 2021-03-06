//
//  ObjectMetaModel.h
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ObjectMetaModel : NSObject {

}

@property (retain) NSArray* Properties;
@property (retain) NSString* ClassName;
@property (retain) NSString* DescriptionFormat;

- (id) createNewInstance;
- (Class) getClass;
- (NSString*) describe:(id)obj;

@end
