//
//  MessageViewController.m
//  SafeHome
//
//  Created by Lindsey Yoo on 8/21/11.
//  Copyright 2011 ideaMAKR. All rights reserved.
//

#import "MessageViewController.h"

#define kOFFSET_FOR_KEYBOARD 130.0

@implementation MessageViewController

@synthesize scrollView, name, phone, email, placeholder, message, sendButton, count;

#pragma mark - IBAction

- (IBAction) sendMessage {

    if ([[name text] length] == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"이름을 입력해 주세요"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"확인", nil];
        [alert show];
        [alert release];
        
        [name becomeFirstResponder];
        
    } else if ([[email text] length] == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"이메일을 입력해 주세요."
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"확인", nil];
        [alert show];
        [alert release];
        
        [email becomeFirstResponder];

    } else if ([[phone text] length] == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"전화번호를 입력해 주세요."
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"확인", nil];
        [alert show];
        [alert release];
        
        [phone becomeFirstResponder];
        
    } else if ([[message text] length] == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"응원 메시지를 입력해 주세요."
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"확인", nil];
        [alert show];
        [alert release];
        
        [message becomeFirstResponder];
        
    } else {
        [name resignFirstResponder];
        [email resignFirstResponder];
        [phone resignFirstResponder];
        [message resignFirstResponder];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:[NSString stringWithFormat:@"이름: %@\n이메일: %@\n전화번호: %@\n메시지: %@\n", [name text], [email text], [phone text], [message text]]
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"확인", nil];
        [alert show];
        [alert release];
        
        NSLog(@"name: %@", [name text]);
        
    }
        
}

#pragma mark - Init View

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"응원메시지 보내기";
    
    name.delegate = self;
    phone.delegate = self;
    email.delegate = self;
    message.delegate = self;
    
    if ([[message text] length] == 0) {
		[placeholder setHidden:NO];
    } else {
        [placeholder setHidden:YES];
    }
    
    scrollView.frame = CGRectMake(0, 0, 320, 367);
    [scrollView setContentSize:CGSizeMake(320, 480)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(textChanged:) 
												 name:UITextViewTextDidChangeNotification 
											   object:nil];
}

- (void)viewDidUnload
{
    [scrollView release];
	[name release];
	[phone release];
	[email release];
    [placeholder release];
	[message release];
    [sendButton release];
    [count release];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark UITextFieldDelegate implementation

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    switch (textField.tag) {
        case 1:
            [email becomeFirstResponder];
            break;
            
        case 2:
            [phone becomeFirstResponder];
            break;
            
        case 3:
            [message becomeFirstResponder];
            break;
            
        default:
            [textField resignFirstResponder];
            break;
    }
    
    return YES;
}

#pragma mark UITextViewDelegate implementation

/*
 140자 제한
 case 1. string.length == 0 -> 제한 length 만큼 입력 된 후에 text를 삭제하려 했을 시에 삭제가 되지 않는 문제가
 있어 삭제키 입력(null)의 경우 return YES; 
 case 2. textView.text.length < 5 -> textView.text의 길이가 5 이하일 경우 return NO;
 case 3. [text isEqual:@"\n"] -> text에 입력 된 값이 개행(return)일 경우에 return YES;
*/
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([textView isEqual:message])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >=0)
        {
            [self setViewMovedUp:YES];
        }
    }
    
    if ([text isEqualToString: @"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    if (text.length == 0 || textView.text.length < 140)
        return YES;
    else
        return NO;
    
}

// 키보드 떴을 때 

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView isEqual:message])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >=0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

- (void)textViewDidEndEditing:(UITextView *)sender
{
	if([sender isEqual:message])
    {
		if( self.view.frame.origin.y < 0 )
		{
			[self setViewMovedUp:NO];
		}
	}
}

//method to move the view up/down whenever the keyboard is shown/dismissed
- (void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];// if you want to slide up the view
	
    CGRect rect =self.view.frame;
    if(movedUp)
    {
        // move the view's origin up so that the text field that will be hidden come above the keyboard 
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
	
    [UIView commitAnimations];
}

- (void)textChanged:(NSNotification *)notification{
	
    count.text = [NSString stringWithFormat:@"%d", [[message text] length]];
    
    if ([[message text] length] == 0) {
        
		[placeholder setHidden:NO];     
	
    } else {
        
        [placeholder setHidden:YES];
	
    }
}

@end