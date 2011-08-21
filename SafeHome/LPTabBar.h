//
//  LPTabBar.h
//  YFPortal
//
//  Created by Jong Pil Park on 10. 11. 3..
//  Copyright 2010 Lilac Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPTabBarItem.h"


@protocol LPTabBarViewDelegate;

@interface LPTabBar : UIViewController <LPTabBarItemDelegate> {
	int initTab;
	id <LPTabBarViewDelegate> delegate;
	UIView *tabBarHolder;
	NSMutableArray *tabViewControllers;
	NSMutableArray *tabItemsArray;
}

@property int initTab;
@property (nonatomic, retain) UIView *tabBarHolder;
@property (nonatomic, assign) id <LPTabBarViewDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *tabViewControllers;
@property (nonatomic, retain) NSMutableArray *tabItemsArray;

- (id)initWithTabViewControllers:(NSMutableArray *)tbControllers tabItems:(NSMutableArray *)tbItems initialTab:(int)iTab;
- (void)initialTab:(int)tabIndex;
- (void)activateController:(int)index;
- (void)activateTabItem:(int)index;

@end

@protocol LPTabBarViewDelegate
- (void)addController:(id)controller;
@end
