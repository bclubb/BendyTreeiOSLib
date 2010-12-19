//
//  QuickEditorController.h
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectMetaModel.h"
#import "ExpandableController.h"

@interface QuickEditorController : UIViewController {

}

@property (retain) ObjectMetaModel* objectMeta;
@property (retain) NSObject* object;
@property (retain) ExpandableController* expandable;
@property (retain) UINavigationController* navController;

- (id) initWithObjectMeta:(ObjectMetaModel*)_objectMeta object:(id)_obj;

@end
