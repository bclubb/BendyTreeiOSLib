//
//  TestCommandableWebViewController.m
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 1/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestCommandableWebViewController.h"
#import "CommandableWebView.h"
#import "PageWebCommand.h"

@implementation TestCommandableWebViewController


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)init {
    if ((self = [super initWithNibName:@"TestCommandableWebViewController" bundle:nil])) {
        // Custom initialization
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [web registerSchemeToCommandClasses:@"birdie" commands:[NSArray arrayWithObject:[PageWebCommand class]]];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"TestCommandableWebViewController" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path isDirectory:NO];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    //[web loadRequest:request];
    
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]]];
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
    [super dealloc];
}


@end
