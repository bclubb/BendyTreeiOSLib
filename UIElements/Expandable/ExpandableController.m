    //
//  ExpandableController.m
//  YourAppHereAppSource
//
//  Created by JOSHUA WRIGHT on 10/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ExpandableController.h"
#import "UIView+Position.h"

@interface ExpandableController()

+ (void) addExpandable:(ExpandableController*)expandable;
+ (void) removeExpandable:(ExpandableController*)expandable;

@end


@implementation ExpandableController

@synthesize _controllers, scroller;

- (id) initWithControllers:(NSArray*)__controllers height:(int)_height
{
    self = [super init];
    if (self != nil) {
        
        self._controllers = __controllers;
        fullHeight = _height;
        
        [ExpandableController addExpandable:self];
        
    }
    return self;
}

- (NSArray*) controllers
{
    return self._controllers;
}

- (void) reposition
{
    int height = 0;
    for(UIViewController* c in self._controllers)
    {
        [c.view setY:height];
        int viewHeight = c.view.frame.size.height;   
        NSLog(@"%i", viewHeight);
        height += viewHeight;
    }
    [self.scroller setContentSize:CGSizeMake(320, height)];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scroller = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, fullHeight)] autorelease];
    [self.view addSubview:self.scroller];
    [self.view setY:0 andHeight:fullHeight]; 
    
    [self.view setAutoresizesSubviews:NO];
    [self.scroller setAutoresizesSubviews:NO];
    
    for(UIViewController* c in self._controllers)
    {
        [self.scroller addSubview:c.view];
    }
    
    [self reposition];
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for(UIViewController* c in self._controllers)
    {
        [c viewWillAppear:animated]; 
    }    
}

- (void) performSelectorOnControllers:(SEL)selector
{
    for(id controller in self._controllers)
    {
        if(![controller respondsToSelector:selector]) continue;
        
        [controller performSelector:selector];
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
    self._controllers = nil;
    self.scroller = nil;
    [ExpandableController removeExpandable:self];
    
    [super dealloc];
}




// Singleton
static NSMutableArray* _allExpandables = NULL;
+ (NSMutableArray*) allExpandables
{
    @synchronized(self)
    {
        if(_allExpandables == NULL)
            _allExpandables = [[NSMutableArray alloc] init];
    }
    return _allExpandables;
}

+ (void) addExpandable:(ExpandableController*)expandable
{
    [[ExpandableController allExpandables] addObject:expandable];
}

+ (void) removeExpandable:(ExpandableController*)expandable
{
    [[ExpandableController allExpandables] removeObject:expandable];
}

+ (void) repositionParentOf:(UIViewController*)controller
{
    //[UIView beginAnimations:@"reposition" context:nil];
    //[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    for(ExpandableController* expandable in [self allExpandables])
    {        
        if([expandable.controllers containsObject:controller]){
            [expandable reposition];
        }
    }
    //[UIView commitAnimations];
}

@end
