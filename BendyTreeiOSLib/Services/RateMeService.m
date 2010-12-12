//
//  RateMeService.m
//  MemorEyes
//
//  Created by JOSHUA WRIGHT on 6/17/10.
//  Copyright 2010 Eye Skills. All rights reserved.
//

#import "RateMeService.h"

@implementation RateMeService


+ (void) showProAlert:(NSString*)title withMessage:(NSString*)message cancel:(NSString*)cancelTitle show:(NSString*)showTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:showTitle, nil];
    [alert show];
    [alert release];                          
}

+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
	if(buttonIndex==1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=374252907&mt=8&s=143441"]];
	}
	
}


+ (void) possiblyShowAlerts
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString* viewCountStr = [prefs stringForKey:@"viewCount"];
    int viewCount = 0;
    if(viewCountStr != nil && [viewCountStr length] > 0)
        viewCount = [viewCountStr intValue];
    viewCount += 1;
    
    [prefs setObject:[NSString stringWithFormat:@"%d", viewCount] forKey:@"viewCount"];
    [prefs synchronize];
    
    
    //if([AppType isFree]){
        
        if(viewCount % 10 == 0)
        {
            [RateMeService showProAlert:@"Want to Upgrade?" withMessage:@"Get more speed/letter options and a reading test to measure your skills." cancel:@"No" show:@"Yes"];
        }
        
    //}else {
        if(viewCount == 10)
        {
            [RateMeService showProAlert:@"Like MemorEYES?" withMessage:@"Tell the world with a 5-star rating! (we won't ask again)" cancel:@"No" show:@"Yes"];   
        }
    //}
    
}



@end
