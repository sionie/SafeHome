//
//  HelpViewController.m
//  SafeHome
//
//  Created by Lindsey Yoo on 8/21/11.
//  Copyright 2011 ideaMAKR. All rights reserved.
//

#import "HelpViewController.h"

@implementation HelpViewController

enum
{
	ALERT_TYPE_DEFAULT = 0,
	ALERT_TYPE_DONATE_SMS,
	ALERT_TYPE_DONATE_CALL
    
} AlertViewType;

enum
{
	ACTIONSHEET_TYPE_DEFAULT = 0,
	ACTIONSHEET_TYPE_SHERE
    
} ActionSheetType;

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

- (IBAction)donateSMS {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"문자 1건당 5천원을 일시후원 하실 수 있습니다. 후원하시겠습니까?"
                                                   delegate:nil
                                          cancelButtonTitle:@"아니오"
                                          otherButtonTitles:@"후원할께요", nil];
    [alert setTag:ALERT_TYPE_DONATE_SMS];
    [alert show];
    [alert release];
}

- (IBAction)donateCall {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"ARS 한 통화 당 2천원을 일시후원 하실 수 있습니다. 후원하시겠습니까?"
                                                   delegate:nil
                                          cancelButtonTitle:@"아니오"
                                          otherButtonTitles:@"후원할께요", nil];
    [alert setTag:ALERT_TYPE_DONATE_SMS];
    [alert show];
    [alert release];
    
}

- (IBAction)donateWeb {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://m.sc.or.kr/business_support.php"]];
}

- (IBAction)donateShop {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://m.sc.or.kr/wishlist.php"]];
}

- (IBAction)shareCampaign {
    
    UIActionSheet *ask = [[UIActionSheet alloc] initWithTitle:@"캠페인 알리기" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"취소" otherButtonTitles:@"트위터", @"페이스북", @"미투데이", @"이메일", nil];

	ask.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [ask setTag:ACTIONSHEET_TYPE_SHERE];
	[ask showInView:self.view];
	[ask release];
}

#pragma mark -
#pragma mark Event Handling Methods (Common)


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"AlertView clickedButtonAtIndex:");
	NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
	
	if([title isEqualToString:@"후원할께요"])
	{
		switch (alertView.tag)
		{
			case ALERT_TYPE_DONATE_SMS:
                [self sendSMS:@"Body of SMS..." recipientList:[NSArray arrayWithObjects:@"#9595", nil]];
				break;
            case ALERT_TYPE_DONATE_CALL:
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0607001233"]];
				break;
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSLog(@"ActionSheet clickedButtonAtIndex:");
	NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if (actionSheet.tag == ACTIONSHEET_TYPE_SHERE) {
        
        NSString *shareMessage = [NSString stringWithFormat:@"공유메시지 채우기!!!"];
        if ([title isEqualToString:@"트위터"]) {
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]) {   // 공식 Twitter 앱
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"twitter://post?message=%@", shareMessage]]];
                
            } else {    // 사파리
                
                NSString *escapedUrlString = [shareMessage stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
                NSString *finalURL = [[NSString stringWithString:@"http://twitter.com/share?text="] stringByAppendingString:escapedUrlString];	
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:finalURL]];
                
            }
            
        } else if ([title isEqualToString:@"페이스북"]) {
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://"]]) {   // 공식 Facebook 앱
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"fb://post/%@", shareMessage]]];
                
            } else {    // 사파리
                
                NSString *escapedUrlString = [shareMessage stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
                NSString *finalURL = [[NSString stringWithString:@"http://m.facebook.com/sharer.php?t="] stringByAppendingString:escapedUrlString];	
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:finalURL]];
                
            }
            
        } else if ([title isEqualToString:@"미투데이"]) {
            
            NSString *escapedUrlString = [shareMessage stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
            NSString *finalURL = [[NSString stringWithString:@"http://me2day.net/p/portable_post_writer/new?new_post[body]="] stringByAppendingString:escapedUrlString];	
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:finalURL]];
  
        } else if ([title isEqualToString:@"이메일"]) {
            [self sendMail:@"Body of SMS..." recipientList:[NSArray arrayWithObjects:nil]];
        }
    }
}

- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = bodyOfMessage;    
        controller.recipients = recipients;
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (result == MessageComposeResultCancelled) {
        NSLog(@"Message cancelled");
    } else if (result == MessageComposeResultSent) {
        NSLog(@"Message sent"); 
    } else {
        NSLog(@"Message failed");
    }
}

- (void)sendMail:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    MFMailComposeViewController *controller = [[[MFMailComposeViewController alloc] init] autorelease];
    if([MFMailComposeViewController canSendMail])
    {
        [controller setMessageBody:bodyOfMessage isHTML:YES];
        [controller setSubject:@"꿈꾸는 소녀들에게 Safe Home을 지원해 주세요."];
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

    self.title = @"참여하기";
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
