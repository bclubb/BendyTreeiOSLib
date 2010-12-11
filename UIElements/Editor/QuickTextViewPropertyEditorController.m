//
//  QuickTextViewPropertyEditorController.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QuickTextViewPropertyEditorController.h"
#import "ZoomTextField.h"
#import "BTJSON.h"
#import "AlertService.h"
#import <QuartzCore/QuartzCore.h>

@implementation QuickTextViewPropertyEditorController

@synthesize object, property;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithProperty:(PropertyMetaModel*)_property onObject:(NSObject*)_obj navController:(UINavigationController*)_navController {
    if ((self = [super initWithNibName:@"QuickTextViewPropertyEditorController" bundle:nil])) {
        self.property = _property;
        self.object = _obj;
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    lblName.text = self.property.Name;
    txt.zoomInfo.title = self.property.Name;
    [txt.zoomInfo setOnComplete:[Callback fromObject:self andSelector:@selector(textFinished)]];
    txt.text = [[self.property getValueOnObject:self.object] description];
    [txt.layer setBorderWidth:1];
}


- (void) textFinished
{
    [self.property setValue:txt.text onObject:self.object];    
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
