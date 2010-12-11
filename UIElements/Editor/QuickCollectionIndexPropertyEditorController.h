//
//  QuickCollectionIndexPropertyEditorController.h
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 12/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyMetaModel.h"

@interface QuickCollectionIndexPropertyEditorController : UITableViewController<UIActionSheetDelegate> {

}

- (id)initWithCollection:(NSMutableArray*)_collection property:(PropertyMetaModel*)_property;

@property (retain) NSMutableArray* collection;
@property (retain) PropertyMetaModel* property;
@property (retain) NSMutableDictionary* primitiveValueContainer;
@property (assign) int editingIndex;
@property (assign) bool wasEditing;

@end
