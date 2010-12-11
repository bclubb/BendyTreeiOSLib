//
//  CustomEditorManager.h
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 12/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyMetaModel.h"

@interface CustomEditorManager : NSObject {

}

@property (retain) NSMutableDictionary* Editors;

+ (CustomEditorManager*) current;

- (void) registerEditor:(Class)_class forTypeKey:(NSString*)_key;
- (UIViewController*) getEditorForProperty:(PropertyMetaModel*)_property object:(NSObject*)_obj navController:(UINavigationController*)_navController;

@end
