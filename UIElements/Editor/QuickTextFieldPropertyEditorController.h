//
//  QuickTextFieldPropertyEditorController.h
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyMetaModel.h"
#import "ZoomTextField.h"

@interface QuickTextFieldPropertyEditorController : UIViewController {

    IBOutlet UILabel* lblName;
    IBOutlet ZoomTextField* txt;
    
}

- (id)initWithProperty:(PropertyMetaModel*)_property onObject:(NSObject*)_obj;

@property (retain) NSObject* object;
@property (retain) PropertyMetaModel* property;

@end
