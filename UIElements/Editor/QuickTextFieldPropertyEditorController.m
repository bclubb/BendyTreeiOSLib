//
//  QuickTextFieldPropertyEditorController.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 12/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QuickTextFieldPropertyEditorController.h"
#import "ZoomTextField.h"
#import "BTJSON.h"
#import "AlertService.h"

@implementation QuickTextFieldPropertyEditorController

@synthesize object, property;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithProperty:(PropertyMetaModel*)_property onObject:(NSObject*)_obj navController:(UINavigationController*)_navController {
    if ((self = [super initWithNibName:@"QuickTextFieldPropertyEditorController" bundle:nil])) {
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
}


- (void) textFinished
{
    id val;
    if([self.property.TypeKey isEqualToString:PropertyMetaModelTypeKey_StringSingleLine]){
        val = txt.text;
    }else{
        NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
        val = [formatter numberFromString:txt.text];
        [formatter release];
    }
    
    if(val){
        [self.property setValue:val onObject:self.object];
    }else{
        [AlertService show:@"Invalid data"];
        txt.text = [[self.property getValueOnObject:self.object] description];        
    }
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
