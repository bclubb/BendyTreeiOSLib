//
//  ColorService.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ColorService.h"

@implementation NSString (Color)

- (UIColor*) hexStringToColor
{
    return [ColorService convertHexStringToColor:self];
}

@end


@implementation ColorService

+ (UIColor*) convertHexStringToColor:(NSString*)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSString *rString = [cString substringWithRange:NSMakeRange(0, 2)];
    NSString *gString = [cString substringWithRange:NSMakeRange(2, 2)];
    NSString *bString = [cString substringWithRange:NSMakeRange(4, 2)];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    unsigned int a = 255;
    if([cString length] >= 8){
        NSString *aString = [cString substringWithRange:NSMakeRange(6, 2)];
        [[NSScanner scannerWithString:aString] scanHexInt:&a];        
    }
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:((float) a / 255.0f)]; 
}

@end
