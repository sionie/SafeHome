//
//  StoryViewController.h
//  SafeHome
//
//  Created by Lindsey Yoo on 8/21/11.
//  Copyright 2011 ideaMAKR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageViewController.h"

@interface StoryViewController : UIViewController {
    
    MessageViewController *messageViewController;
}

@property (nonatomic, retain) MessageViewController *messageViewController;

- (IBAction)pushMessageViewController;

@end
