//
//  AlertCommand.m
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 1/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AlertCommand.h"
#import "AlertService.h"

@implementation AlertCommand

+ (NSString*) key
{
    return @"alert";
}

- (id) execute
{
    if([self.args count] == 1){
        [AlertService show:[[self.args objectAtIndex:0] description]];
    }else{
        [AlertService show:[[self.args objectAtIndex:0] description] withMessage:[[self.args objectAtIndex:1] description]];   
    }
    return nil;
}

@end
