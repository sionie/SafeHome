//
//  SafeHomeAppDelegate.h
//  SafeHome
//
//  Created by Lindsey Yoo on 8/21/11.
//  Copyright 2011 ideaMAKR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SafeHomeViewController;

@interface SafeHomeAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet SafeHomeViewController *viewController;

@end
