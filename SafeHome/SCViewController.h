//
//  SCViewController.h
//  SafeHome
//
//  Created by Lindsey Yoo on 8/21/11.
//  Copyright 2011 ideaMAKR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "InfoViewController.h"

@interface SCViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    
    UIScrollView *scrollView;
    
    InfoViewController *infoViewController;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) InfoViewController *infoViewController;

- (IBAction) playMovie;
- (IBAction) contactSite;
- (IBAction) contactTwitter;
- (IBAction) contactEmail;
- (IBAction) contactPhone;
- (void) info;

- (void)sendMail:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients;

@end
