//
//  InfoViewController.h
//  SafeHome
//
//  Created by Lindsey Yoo on 8/22/11.
//  Copyright 2011 ideaMAKR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface InfoViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    
}

- (IBAction) review;
- (IBAction) contactSite;
- (IBAction) contactTwitter;
- (IBAction) contactFacebook;
- (IBAction) contactEmail;

- (void)sendMail:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients;

@end
