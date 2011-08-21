//
//  SCViewController.m
//  SafeHome
//
//  Created by Lindsey Yoo on 8/21/11.
//  Copyright 2011 ideaMAKR. All rights reserved.
//

#import "SCViewController.h"

@implementation SCViewController

@synthesize scrollView, infoViewController;

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

- (IBAction) playMovie {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.youtube.com/watch?v=jk5E-TpGwnM"]];
}

- (IBAction) contactSite {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://m.sc.or.kr/"]];
}

- (IBAction) contactTwitter {    
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]) {   // 공식 Twitter 앱
		
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=stckorea"]];
        
	} else {    // 사파리
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://mobile.twitter.com/stckorea"]];
        
	}
    
}

- (IBAction) contactEmail {
    
    [self sendMail:@"Body of SMS..." recipientList:[NSArray arrayWithObjects:@"webmaster@sc.or.kr", nil]];

}

- (IBAction) contactPhone {
	UIApplication *application = [UIApplication sharedApplication];
	NSString *stringURL = [[NSString alloc] initWithString:@"tel:02-6900-4400"];
	
	[application openURL:[NSURL URLWithString:stringURL]];
}

- (void) info {
    if(self.infoViewController == nil)
    {
        InfoViewController *infoVC = [[InfoViewController alloc] init];
        self.infoViewController = infoVC;
        [infoVC release];
    }
    [self.navigationController pushViewController:self.infoViewController animated:YES];
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

    self.title = @"세이브더칠드런 소개";
    
    scrollView.frame = CGRectMake(0, 0, 320, 367);
    [scrollView setContentSize:CGSizeMake(320, 900)];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithTitle:@"앱정보" 
                             style:UIBarButtonItemStylePlain 
                             target:self 
                             action:@selector(info)];
    
    self.navigationItem.rightBarButtonItem = item;
    
    [item release];

}

- (void)viewDidUnload
{
    [scrollView release];
    [infoViewController release];
    
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
