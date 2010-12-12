//
//  QuickCustomObjectPropertyEditorController.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QuickCustomObjectPropertyEditorController.h"
#import "PropertyMetaModel.h"
#import "BTJSON.h"
#import "AlertService.h"
#import "QuickEditorController.h"

@implementation QuickCustomObjectPropertyEditorController

@synthesize object, property, navController;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithProperty:(PropertyMetaModel*)_property onObject:(NSObject*)_obj navController:(UINavigationController*)_navController {
    if ((self = [super initWithNibName:@"QuickCustomObjectPropertyEditorController" bundle:nil])) {
        self.property = _property;
        self.object = _obj;
        self.navController = _navController;
    }
    return self;
}

- (void) updateLabel
{    
    lbl.text = self.property.Name;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    [self updateLabel];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateLabel];
}


- (IBAction) pressedButton
{
    QuickEditorController* controller = [[[QuickEditorController alloc] initWithObjectMeta:self.property.TypeMeta object:[self.property getValueOnObject:self.object]] autorelease];
    [self.navController pushViewController:controller animated:YES];
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
    self.navController = nil;
    
    [super dealloc];
}


@end
