//
//  AlertPrompt.h
//  Prompt
//
//  Created by Jeff LaMarche on 2/26/09.

#import <Foundation/Foundation.h>

@protocol UIPromptViewDelegate;

@interface UIPromptView : UIAlertView 
{
    
}

- (id)initWithTitle:(NSString *)title value:(NSString *)val delegate:(id)promptDelegate cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okayButtonTitle;

@property (retain) UITextField* textField;
@property (retain) id<UIPromptViewDelegate> promptDelegate;

- (NSString*) text;

@end



@protocol UIPromptViewDelegate <NSObject>
@optional

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)promptView:(UIPromptView *)promptView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end