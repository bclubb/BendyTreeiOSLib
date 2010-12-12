//
//  App.h
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 11/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AppModel : NSObject {

}

@property (assign) int Id;
@property (retain) NSString* Name;
@property (retain) NSNumber* Sequence;
@property (assign) bool IsActive;
@property (retain) NSDate* CreatedOn;
@property (retain) NSArray* Pages;

@end
