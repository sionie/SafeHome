//
//  SafeHomeAppDelegate.m
//  SafeHome
//
//  Created by Lindsey Yoo on 8/21/11.
//  Copyright 2011 ideaMAKR. All rights reserved.
//

#import "SafeHomeAppDelegate.h"

@implementation SafeHomeAppDelegate

@synthesize window;
@synthesize storyViewController, photosViewController, cameraViewController, scViewController, helpViewController;

#pragma mark -
#pragma mark 탭바 보이기 감추기

- (IBAction)hideTabBar {
	tabView.tabBarHolder.hidden = YES;
}

- (IBAction)showTabBar {
	tabView.tabBarHolder.hidden = NO;
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    LPTabBarItem *tabItem1 = [[LPTabBarItem alloc] initWithFrame:CGRectMake(0, 0, 64, 49) normalState:@"tabbar_1.png" toggledState:@"tabbar_1_over.png"];
	LPTabBarItem *tabItem2 = [[LPTabBarItem alloc] initWithFrame:CGRectMake(64, 0, 64, 49) normalState:@"tabbar_2.png" toggledState:@"tabbar_2_over.png"];
	LPTabBarItem *tabItem3 = [[LPTabBarItem alloc] initWithFrame:CGRectMake(128, 0, 64, 49) normalState:@"tabbar_3.png" toggledState:@"tabbar_3_over.png"];
	LPTabBarItem *tabItem4 = [[LPTabBarItem alloc] initWithFrame:CGRectMake(192, 0, 64, 49) normalState:@"tabbar_4.png" toggledState:@"tabbar_4_over.png"];
	LPTabBarItem *tabItem5 = [[LPTabBarItem alloc] initWithFrame:CGRectMake(256, 0, 64, 49) normalState:@"tabbar_5.png" toggledState:@"tabbar_5_over.png"];
    
    storyViewController = [[StoryViewController alloc] initWithNibName:@"StoryViewController" bundle:nil];
    photosViewController = [[PhotosViewController alloc] initWithNibName:@"PhotosViewController" bundle:nil];
    cameraViewController = [[CameraViewController alloc] initWithNibName:@"CameraViewController" bundle:nil];
    scViewController = [[SCViewController alloc] initWithNibName:@"SCViewController" bundle:nil];
    helpViewController = [[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
    
    UINavigationController *tabViewController1 = [[UINavigationController alloc] initWithRootViewController:storyViewController];
    UINavigationController *tabViewController2 = [[UINavigationController alloc] initWithRootViewController:photosViewController];
    UINavigationController *tabViewController3 = [[UINavigationController alloc] initWithRootViewController:cameraViewController];
    UINavigationController *tabViewController4 = [[UINavigationController alloc] initWithRootViewController:scViewController];
    UINavigationController *tabViewController5 = [[UINavigationController alloc] initWithRootViewController:helpViewController];
    
    
    
	NSMutableArray *viewControllersArray = [[NSMutableArray alloc] init];
	[viewControllersArray addObject:tabViewController1];
	[viewControllersArray addObject:tabViewController2];
	[viewControllersArray addObject:tabViewController3];
	[viewControllersArray addObject:tabViewController4];
	[viewControllersArray addObject:tabViewController5];
    
	NSMutableArray *tabItemsArray = [[NSMutableArray alloc] init];
	[tabItemsArray addObject:tabItem1];
	[tabItemsArray addObject:tabItem2];
	[tabItemsArray addObject:tabItem3];
	[tabItemsArray addObject:tabItem4];
	[tabItemsArray addObject:tabItem5];
    
	tabView = [[LPTabBar alloc] initWithTabViewControllers:viewControllersArray tabItems:tabItemsArray initialTab:0];
	[window addSubview:tabView.view];
    
    [window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    
    [self saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    
    [self saveContext];
}


- (void)saveContext {
    
    NSError *error = nil;
    if (managedObjectContext_ != nil) {
        if ([managedObjectContext_ hasChanges] && ![managedObjectContext_ save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
} 


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"LPTabBar" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"LPTabBar.sqlite"]];
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

- (void)dealloc
{
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    
	[storyViewController release];
    [photosViewController release];
    [cameraViewController release];
    [scViewController release];
    [helpViewController release];
	[tabView release];
    [window release];
    [super dealloc];
}

@end
