//
//  LPTabBar.m
//  YFPortal
//
//  Created by Jong Pil Park on 10. 11. 3..
//  Copyright 2010 Lilac Studio. All rights reserved.
//

#import "LPTabBar.h"
#import "LPTabBarItem.h"

#define kSelectedTab @"SelectedTAB"


@implementation LPTabBar

@synthesize initTab;
@synthesize delegate;
@synthesize tabBarHolder;
@synthesize tabViewControllers;
@synthesize tabItemsArray;


- (void)dealloc {
	[tabBarHolder release];
	[tabViewControllers release];
	[tabItemsArray release];
	[super dealloc];
}


// 윈도우가 같은 크기의 뷰 생성하고 UIViewControllers와 TabBarItems의 배열 초기화.
- (id)initWithTabViewControllers:(NSMutableArray *)tbControllers tabItems:(NSMutableArray *)tbItems initialTab:(int)iTab {
	if ((self = [super init])) {
		self.view.frame = [UIScreen mainScreen].bounds;
		initTab = iTab;
		
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		if ([defaults integerForKey:kSelectedTab]) {
			initTab = [defaults integerForKey:kSelectedTab];
		}
		NSLog(@"%d", initTab);
		tabViewControllers = [[NSMutableArray alloc] initWithCapacity:[tbControllers count]];
		tabViewControllers = tbControllers;
		
		tabItemsArray = [[NSMutableArray alloc] initWithCapacity:[tbItems count]];
		tabItemsArray = tbItems;
	}
    return self;
}


- (void)initialTab:(int)tabIndex {
	[self activateController:tabIndex];
	[self activateTabItem:tabIndex];
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

	// 탭바 아이템을 담을 뷰 홀더 생성.
	tabBarHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 431, 320, 480)];
	tabBarHolder.backgroundColor = [UIColor clearColor];
	
	// 탭바 백그라운드 이미지.
	UIImage *tabBg = [UIImage imageNamed:@"tab_bg.png"];
	UIImageView *tabImageView = [[UIImageView alloc] initWithImage:tabBg];
	[tabBarHolder addSubview:tabImageView];
	[tabImageView release];
	
	//add it as a subview
	[self.view addSubview:tabBarHolder];
	// 루프를 돌며 모든 뷰 컨트롤러들에게 뷰를 추가.
	for (int i = [tabViewControllers count]-1; i >= 0; i--) {
		[self.view addSubview:[[tabViewControllers objectAtIndex:i] view]];
	}

	// 루프를 돌며 모든 탭바 아이템을 tabBarHolder에 추가.
	for (int i = [tabItemsArray count] - 1; i >= 0; i--) {
		[[tabItemsArray objectAtIndex:i] setDelegate:self];
		[self.tabBarHolder addSubview:[tabItemsArray objectAtIndex:i]];
		// 초기화활 탭 확인.
		if (i == initTab) {
			[[tabItemsArray objectAtIndex:i] toggleOn:YES];
		}
	}
	[self.view bringSubviewToFront:tabBarHolder];
	// 탭바를 감추거나 보여주고 초기화할 탭을 결정.
	[self initialTab:initTab];
}


// 루프를 돌며 모튼 탭바 아이템의  상태 설정: YES/NO.
- (void)activateTabItem:(int)index {
	for (int i = [tabItemsArray count]; i < [tabItemsArray count]; i++) {
		if (i == index) {
			[[tabItemsArray objectAtIndex:i] toggleOn:YES];
		} 
		else {
			[[tabItemsArray objectAtIndex:i] toggleOn:NO];
		}
	}
}


// 루프를 돌며 모든 UIViewControllers 아이템의 상태 설정: YES/NO.
- (void)activateController:(int)index {
	for (int i = 0; i < [tabViewControllers count]; i++) {
		if (i == index) {
			[[tabViewControllers objectAtIndex:i] view].hidden = NO;
		} 
		else {
			[[tabViewControllers objectAtIndex:i] view].hidden = YES;
		}
	}
}


// 프로토콜은 버튼과 탭바 사의의 통신을 담당한다.
#pragma mark -
#pragma mark LPTabTabItemDelegate action

- (void)selectedItem:(LPTabBarItem *)button {
	int indexC = 0;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSUInteger tabIndex;
	for (LPTabBarItem *tb in tabItemsArray) {		
		if (tb == button) {
			[tb toggleOn:YES];
			[self activateController:indexC];
			tabIndex = indexC;
			[defaults setInteger:tabIndex forKey:kSelectedTab];
		} 
		else {
			[tb toggleOn:NO];
		}
		indexC++;
	}	 
}

@end
