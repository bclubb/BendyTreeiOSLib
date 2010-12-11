//
//  StringFormatting.h
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 12/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Formatting)

- (NSString*) format:(id)obj;

@end


@interface StringFormattingService : NSObject {

}

+ (NSString*) formatString:(NSString*)str withObject:(id)obj;

@end


