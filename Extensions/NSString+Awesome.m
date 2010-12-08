//
//  NSString+Awesome.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSString+Awesome.h"


@implementation NSString (Awesome)

- (bool) contains:(NSString*)subtext
{
    return [self rangeOfString:subtext].length != 0;
}

@end
