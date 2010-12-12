//
//  BendyTreeiPhoneLibTestingAppDelegate.m
//  BendyTreeiPhoneLibTesting
//
//  Created by JOSHUA WRIGHT on 11/21/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "BendyTreeiPhoneLibTestingAppDelegate.h"

#import "AppModel.h"
#import "WidgetPage.h"
#import "WebPage.h"
#import "BTJSON.h"
#import "Observee.h"

#import "QuickEditorController.h"
#import "ObjectMetaModel.h"
#import "PropertyMetaModel.h"
#import "UIView+Position.h"

#import "StringFormatting.h"

@implementation BendyTreeiPhoneLibTestingAppDelegate

@synthesize window;



#pragma mark -
#pragma mark Application lifecycle

- (void) testSerialization
{
    [[BTSerializer current] registerClasses:[NSArray arrayWithObjects:[AppModel class], [Page class], [WidgetPage class], [WebPage class], nil]];

    AppModel* app = [[[AppModel alloc] init] autorelease];
    app.Id = 346782;
    app.Name = @"Pocket Tap";
    app.Sequence = [NSNumber numberWithInt:3];
    app.IsActive = YES;
    app.CreatedOn = [NSDate date];

    WidgetPage* page1 = [[[WidgetPage alloc] init] autorelease];
    page1.Name = @"First Page";
    page1.Widgets = [NSArray array];
    WebPage* page2 = [[[WebPage alloc] init] autorelease];
    page2.Name = @"Second Page";
    page2.Url = @"http://www.google.com";
    app.Pages = [NSArray arrayWithObjects:page1, page2, nil];



    NSString* json = [app serialize];
    NSLog(@"ORIGINAL JSON: %@", json);


    AppModel* app2 = [json deserialize:[AppModel class]];
    NSString* json2 = [app2 serialize];
    NSLog(@"RE-DONE  JSON: %@", json2);
}


- (void) testEditor
{
    NSMutableDictionary* addressDic = [NSMutableDictionary dictionary];
    ObjectMetaModel* addressObjectMeta = [[[ObjectMetaModel alloc] init] autorelease];
    addressObjectMeta.DescriptionFormat = @"#{City}, #{Street}";
    PropertyMetaModel* addressProp1 = [[[PropertyMetaModel alloc] init] autorelease];
    addressProp1.Name = @"Street";
    addressProp1.PropertyKey = @"Street";
    addressProp1.TypeKey = PropertyMetaModelTypeKey_StringSingleLine;
    [addressDic setValue:@"4208 Brownwood Lane" forKey:@"Street"];
    PropertyMetaModel* addressProp2 = [[[PropertyMetaModel alloc] init] autorelease];
    addressProp2.Name = @"City";
    addressProp2.PropertyKey = @"City";
    addressProp2.TypeKey = PropertyMetaModelTypeKey_StringSingleLine;
    [addressDic setValue:@"Norman" forKey:@"City"];
    addressObjectMeta.Properties = [NSArray arrayWithObjects:addressProp1, addressProp2, nil];
    
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    PropertyMetaModel* prop1 = [[[PropertyMetaModel alloc] init] autorelease];
    prop1.Name = @"Field Alpha String (1 line)";
    prop1.PropertyKey = @"A";
    prop1.TypeKey = PropertyMetaModelTypeKey_StringSingleLine;
    [dic setValue:@"1" forKey:@"A"];
    PropertyMetaModel* prop2 = [[[PropertyMetaModel alloc] init] autorelease];
    prop2.Name = @"Field Beta Number";
    prop2.PropertyKey = @"B";
    prop2.TypeKey = PropertyMetaModelTypeKey_NSNumber;
    [dic setValue:[NSNumber numberWithInt:2] forKey:@"B"];
    PropertyMetaModel* prop3 = [[[PropertyMetaModel alloc] init] autorelease];
    prop3.Name = @"Address Field";
    prop3.PropertyKey = @"Address";
    prop3.TypeKey = PropertyMetaModelTypeKey_CustomObject;
    prop3.TypeMeta = addressObjectMeta;
    [dic setValue:addressDic forKey:@"Address"];
    PropertyMetaModel* prop4 = [[[PropertyMetaModel alloc] init] autorelease];
    prop4.Name = @"Field Delta Bool";
    prop4.PropertyKey = @"D";
    prop4.TypeKey = PropertyMetaModelTypeKey_bool;
    [dic setValue:[NSNumber numberWithBool:NO] forKey:@"D"];
    PropertyMetaModel* prop5 = [[[PropertyMetaModel alloc] init] autorelease];
    prop5.Name = @"Field Elpha String (* lines)";
    prop5.PropertyKey = @"E";
    prop5.TypeKey = PropertyMetaModelTypeKey_StringMultipleLine;
    [dic setValue:@"The first line" forKey:@"E"];
    PropertyMetaModel* prop6 = [[[PropertyMetaModel alloc] init] autorelease];
    prop6.Name = @"Field Foofa Custom Obj Collection";
    prop6.PropertyKey = @"F";
    prop6.TypeKey = PropertyMetaModelTypeKey_Collection;
    prop6.TypeMeta = addressObjectMeta;
    prop6.SubTypeKey = PropertyMetaModelTypeKey_CustomObject;
    [dic setValue:[NSMutableArray arrayWithObjects: nil] forKey:@"F"];
    PropertyMetaModel* prop7 = [[[PropertyMetaModel alloc] init] autorelease];
    prop7.Name = @"Field Gata String Collection";
    prop7.PropertyKey = @"G";
    prop7.TypeKey = PropertyMetaModelTypeKey_Collection;
    prop7.SubTypeKey = PropertyMetaModelTypeKey_StringSingleLine;
    [dic setValue:[NSMutableArray arrayWithObjects:@"Number One", @"Number Two", nil] forKey:@"G"];
    ObjectMetaModel* objectMeta = [[[ObjectMetaModel alloc] init] autorelease];
    objectMeta.Properties = [NSMutableArray arrayWithObjects:prop1, prop2, prop3, prop4, prop5, prop6, prop7, nil];

    QuickEditorController* controller = [[[QuickEditorController alloc] initWithObjectMeta:objectMeta object:dic] autorelease];
    
    UINavigationController* navController = [[[UINavigationController alloc] initWithRootViewController:controller] autorelease];
    
    [window addSubview:navController.view];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.	
    [window makeKeyAndVisible];
	
    [self testEditor];    
    
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
