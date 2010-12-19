    //
//  QuickEditorController.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QuickEditorController.h"
#import "ObjectMetaModel.h"
#import "PropertyMetaModel.h"
#import "ExpandableController.h"
#import "AlertService.h"

@implementation QuickEditorController

@synthesize objectMeta, expandable, object, navController;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id) initWithObjectMeta:(ObjectMetaModel*)_objectMeta object:(id)_obj {
    if ((self = [super init])) {
        
        self.objectMeta = _objectMeta;
        self.object = _obj;
        
    }
    return self;
}

- (UINavigationController*) getNavController
{
    if(self.navigationController)
        return self.navigationController;
    
    return self.navController;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(!self.getNavController)
    {
        [AlertService show:@"ERROR: QuickEditorController must be in a nav controller"];
        NSLog(@"QuickEditorController must be inside a navigationController");
    }
    
    NSMutableArray* controllers = [NSMutableArray array];
    
    for(PropertyMetaModel* property in self.objectMeta.Properties){
        UIViewController* controller = [property newEditorOfObject:self.object navController:self.getNavController];
        [controllers addObject:controller];
    }
    
    self.expandable = [[[ExpandableController alloc] initWithControllers:controllers height:480-(20+44)] autorelease];
    self.view = self.expandable.view;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.expandable viewWillAppear:animated];
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
    self.objectMeta = nil;
    self.expandable = nil;
    self.object = nil;
    self.navController = nil;
    
    [super dealloc];
}


@end
