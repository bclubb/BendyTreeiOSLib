//
//  QuickCollectionPropertyEditorController.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QuickCollectionPropertyEditorController.h"
#import "PropertyMetaModel.h"
#import "QuickEditorController.h"
#import "QuickCollectionIndexPropertyEditorController.h"

@implementation QuickCollectionPropertyEditorController

@synthesize object, property, navController;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithProperty:(PropertyMetaModel*)_property onObject:(NSObject*)_obj navController:(UINavigationController*)_navController {
    if ((self = [super initWithNibName:@"QuickCollectionPropertyEditorController" bundle:nil])) {
        self.property = _property;
        self.object = _obj;
        self.navController = _navController;
        
        id collection = [self.property getValueOnObject:self.object];
        if(!collection)
            [self.property setValue:[NSMutableArray array] onObject:self.object];

        if(![collection isKindOfClass:[NSMutableArray class]])
            [NSException raise:@"QuickEditor requires collections to be NSMutableArray" format:@""];
    }
    return self;
}

- (void) updateLabel
{
    int len = [[self.property getValueOnObject:self.object] count];
    lbl.text = [NSString stringWithFormat:@"%@ (%i)", self.property.Name, len];
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
    NSMutableArray* collection = [self.property getValueOnObject:self.object];
    QuickCollectionIndexPropertyEditorController* controller = [[[QuickCollectionIndexPropertyEditorController alloc] initWithCollection:collection property:self.property] autorelease];
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
