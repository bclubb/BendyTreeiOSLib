//
//  AlertPrompt.m
//  Prompt
//
//  Created by Jeff LaMarche on 2/26/09.

#import "UIPromptView.h"

@implementation UIPromptView

@synthesize textField, promptDelegate;

- (id) initWithTitle:(NSString *)title value:(NSString *)val delegate:(id<UIPromptViewDelegate>)_promptDelegate cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okayButtonTitle
{
    if (self = [super initWithTitle:title message:title delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:okayButtonTitle, nil])
    {
        self.promptDelegate = _promptDelegate;
        
        UITextField *theTextField = [[[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)] autorelease]; 
        [theTextField setBackgroundColor:[UIColor whiteColor]]; 
        [self addSubview:theTextField];
        self.textField = theTextField;
        self.textField.text = val;

        [self setTransform:CGAffineTransformMakeTranslation(0.0, 40.0)];
    }
    return self;
}

- (void) show
{
    [textField becomeFirstResponder];
    [super show];
}

- (void) alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.delegate promptView:(UIPromptView*)alertView clickedButtonAtIndex:buttonIndex];
}

- (NSString*) text
{
    return textField.text;
}

- (void)dealloc
{
    self.promptDelegate = nil;
    self.textField = nil;
    
    [super dealloc];
}

@end
