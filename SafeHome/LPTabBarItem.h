//
//  LPTabBarItem.h
//  YFPortal
//
//  Created by Jong Pil Park on 10. 11. 3..
//  Copyright 2010 Lilac Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LPTabBarItemDelegate;

@interface LPTabBarItem : UIButton {
	id <LPTabBarItemDelegate> delegate;
	BOOL _on;
}

@property (nonatomic, assign) id <LPTabBarItemDelegate> delegate;
@property (nonatomic) BOOL _on;

// 컨트로의 사이즈를 강제로 적절하게 조절한다. 프레임 사이즈는 무시됨!
- (id)initWithFrame:(CGRect)frame normalState:(NSString*)n toggledState:(NSString *)t;             
- (BOOL)isOn;
- (void)toggleOn:(BOOL)state;

@end

@protocol LPTabBarItemDelegate
- (void)selectedItem:(LPTabBarItem *)button;
@end
