//
//  QuickCustomObjectPropertyEditorController.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QuickCustomObjectPropertyEditorController.h"
#import "CustomObjectPropertyMetaModel.h"
#import "BTJSON.h"
#import "AlertService.h"

@implementation QuickCustomObjectPropertyEditorController

@synthesize object, property;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithProperty:(CustomObjectPropertyMetaModel*)_property onObject:(NSObject*)_obj {
    if ((self = [super initWithNibName:@"QuickCustomObjectPropertyEditorController" bundle:nil])) {
        self.property = _property;
        self.object = _obj;
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    lbl.text = self.property.Name;
}

- (IBAction) pressedButton
{
    
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    self.property = nil;
    self.object = nil;
    
    [super dealloc];
}


@end
