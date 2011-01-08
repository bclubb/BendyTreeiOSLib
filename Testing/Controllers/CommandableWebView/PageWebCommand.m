//
//  PageWebCommand.m
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 1/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PageWebCommand.h"
#import "WebCommand.h"

@implementation PageWebCommand

- (void) initialize
{
    self.key = @"page";
}

- (id) execute
{
    return [NSNumber numberWithInt:([[self.args objectAtIndex:1] intValue] + 1)];
}


@end
