//
//  QuickBoolPropertyEditorController.h
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyMetaModel.h"
#import "ZoomTextField.h"

@interface QuickBoolPropertyEditorController : UIViewController<IPropertyEditorController> {

    IBOutlet UILabel* lblName;
    IBOutlet UISwitch* uiSwitch;
    
}

@property (retain) NSObject* object;
@property (retain) PropertyMetaModel* property;

- (IBAction) switchChanged;

@end
