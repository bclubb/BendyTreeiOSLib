//
//  StringFormatting.m
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 12/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StringFormatting.h"
#import "RegexKitLite.h"

@implementation NSString (Formatting)

- (NSString*) format:(id)obj
{
    return [StringFormattingService formatString:self withObject:obj];
}

@end


@implementation StringFormattingService

+ (NSString*) formatString:(NSString*)str withObject:(id)obj
{
    NSArray* matches = [str arrayOfCaptureComponentsMatchedByRegex:@"#\\{[^}]*\\}"];
    
    for(NSArray* match in matches){
        NSString* matchStr = [match objectAtIndex:0];
        NSString* key = [matchStr substringWithRange:NSMakeRange(2, [matchStr length]-3)];
        NSString* value = [[obj valueForKey:key] description];
        str = [str stringByReplacingOccurrencesOfString:matchStr withString:value];
    }
    
    return str;
}

@end
