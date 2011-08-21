//
//  SafeHomeAppDelegate.h
//  SafeHome
//
//  Created by Lindsey Yoo on 8/21/11.
//  Copyright 2011 ideaMAKR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LPTabBar.h"
#import "StoryViewController.h"
#import "PhotosViewController.h"
#import "CameraViewController.h"
#import "SCViewController.h"
#import "HelpViewController.h"

@interface SafeHomeAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    
    UIWindow *window;
    LPTabBar *tabView;
    StoryViewController *storyViewController;
    PhotosViewController *photosViewController;
    CameraViewController *cameraViewController;
    SCViewController *scViewController;
    HelpViewController *helpViewController;

@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet StoryViewController *storyViewController;
@property (nonatomic, retain) IBOutlet PhotosViewController *photosViewController;
@property (nonatomic, retain) IBOutlet CameraViewController *cameraViewController;
@property (nonatomic, retain) IBOutlet SCViewController *scViewController;
@property (nonatomic, retain) IBOutlet HelpViewController *helpViewController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (IBAction)hideTabBar;
- (IBAction)showTabBar;

- (NSString *)applicationDocumentsDirectory;
- (void)saveContext;

@end
