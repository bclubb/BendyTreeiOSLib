//
//  QuickCustomObjectPropertyEditorController.h
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyMetaModel.h"


@interface QuickCustomObjectPropertyEditorController : UIViewController<IPropertyEditorController> {
    
    IBOutlet UILabel* lbl;
    
}

@property (retain) NSObject* object;
@property (retain) PropertyMetaModel* property;
@property (retain) UINavigationController* navController;

- (IBAction) pressedButton;

@end
