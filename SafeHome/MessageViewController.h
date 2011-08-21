//
//  MessageViewController.h
//  SafeHome
//
//  Created by Lindsey Yoo on 8/21/11.
//  Copyright 2011 ideaMAKR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate> {
    
    UIScrollView *scrollView;
    UITextField *name;
    UITextField *phone;
    UITextField *email;
    UILabel *placeholder;
    UITextView *message;
    UIButton *sendButton;
    UILabel *count;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *phone;
@property (nonatomic, retain) IBOutlet UITextField *email;
@property (nonatomic, retain) IBOutlet UILabel *placeholder;
@property (nonatomic, retain) IBOutlet UITextView *message;
@property (nonatomic, retain) IBOutlet UIButton *sendButton;
@property (nonatomic, retain) IBOutlet UILabel *count;

- (IBAction) sendMessage;

- (void)setViewMovedUp:(BOOL)movedUp;
- (void)textViewDidBeginEditing:(UITextView *)textView;
- (void)textViewDidEndEditing:(UITextView *)textView;

@end
