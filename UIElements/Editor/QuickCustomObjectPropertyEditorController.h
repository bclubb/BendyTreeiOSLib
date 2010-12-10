//
//  QuickCustomObjectPropertyEditorController.h
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomObjectPropertyMetaModel.h"


@interface QuickCustomObjectPropertyEditorController : UIViewController {
    
    IBOutlet UILabel* lbl;
    
}

- (id)initWithProperty:(CustomObjectPropertyMetaModel*)_property onObject:(NSObject*)_obj;

@property (retain) NSObject* object;
@property (retain) CustomObjectPropertyMetaModel* property;

- (IBAction) pressedButton;

@end
