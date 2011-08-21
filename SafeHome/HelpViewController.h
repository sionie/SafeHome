//
//  HelpViewController.h
//  SafeHome
//
//  Created by Lindsey Yoo on 8/21/11.
//  Copyright 2011 ideaMAKR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface HelpViewController : UIViewController <UIAlertViewDelegate, UIActionSheetDelegate, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate> {
    
}

- (IBAction)donateSMS;
- (IBAction)donateCall;
- (IBAction)donateWeb;
- (IBAction)donateShop;
- (IBAction)shareCampaign;

- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients;
- (void)sendMail:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients;

@end
