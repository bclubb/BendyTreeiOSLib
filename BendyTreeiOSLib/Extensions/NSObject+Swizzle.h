//
//  NSObject+Swizzle.h
//  AllStarApps
//
//  Created by JOSHUA WRIGHT on 1/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (Swizzle)

+ (BOOL)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector;

@end
