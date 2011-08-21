//
//  InfoViewController.m
//  SafeHome
//
//  Created by Lindsey Yoo on 8/22/11.
//  Copyright 2011 ideaMAKR. All rights reserved.
//

#import "InfoViewController.h"

@implementation InfoViewController

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


#pragma mark -
#pragma mark IBActions

- (IBAction) review {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=405772033&onlyLatestVersion=false&type=Purple+Software"]];
}

- (IBAction) contactSite {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://lindseyblog.com/"]];
}

- (IBAction) contactTwitter {    
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]) {   // 공식 Twitter 앱
		
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=sionie"]];
        
	} else {    // 사파리
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://mobile.twitter.com/sioie"]];
        
	}
    
}

- (IBAction) contactFacebook {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://"]]) {   // 공식 Facebook 앱
		
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://profile/lindsey.yoo"]];
        
	} else {    // 사파리
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://facebook.com/lindsey.yoo"]];
        
	}
    
}

- (IBAction) contactEmail {
    
    [self sendMail:@"Body of SMS..." recipientList:[NSArray arrayWithObjects:@"yoojiyeon@gmail.com", nil]];
}

- (void)sendMail:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    MFMailComposeViewController *controller = [[[MFMailComposeViewController alloc] init] autorelease];
    if([MFMailComposeViewController canSendMail])
    {
        [controller setMessageBody:bodyOfMessage isHTML:YES];
        [controller setSubject:@"문의사항이 있습니다: Safe Home 캠페인"];
        [controller setToRecipients:recipients];
        controller.mailComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (result == MessageComposeResultCancelled) {
        NSLog(@"Mail cancelled");
    } else if (result == MessageComposeResultSent) {
        NSLog(@"Mail sent"); 
    } else {
        NSLog(@"Mail failed");
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"어플리케이션 정보";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
