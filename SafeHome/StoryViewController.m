//
//  StoryViewController.m
//  SafeHome
//
//  Created by Lindsey Yoo on 8/21/11.
//  Copyright 2011 ideaMAKR. All rights reserved.
//

#import "StoryViewController.h"

@implementation StoryViewController

@synthesize messageViewController;

#pragma mark -
#pragma mark IBAction

- (IBAction)pushMessageViewController {
    
    if(self.messageViewController == nil)
    {
        MessageViewController *messageVC = [[MessageViewController alloc] init];
        self.messageViewController = messageVC;
        [messageVC release];
    }
    [self.navigationController pushViewController:self.messageViewController animated:YES];
}

#pragma mark -
#pragma mark Init View

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

    self.title = @"아니사 이야기";
}

- (void)viewDidUnload
{
    [messageViewController release];
    
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
