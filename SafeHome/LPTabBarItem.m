//
//  LPTabBarItem.m
//  YFPortal
//
//  Created by Jong Pil Park on 10. 11. 3..
//  Copyright 2010 Lilac Studio. All rights reserved.
//

#import "LPTabBarItem.h"


@implementation LPTabBarItem

@synthesize delegate;
@synthesize _on;


- (id)initWithFrame:(CGRect)frame normalState:(NSString*)n toggledState:(NSString *)t {
	if (self = [super initWithFrame:frame]) {
		[self setBackgroundImage:[UIImage imageNamed:n] forState:UIControlStateNormal];
		[self setBackgroundImage:[UIImage imageNamed:t] forState:UIControlStateSelected];
		_on = NO;
		[self addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
		
    }
    return self;
}


- (BOOL)isOn {
	return _on;
}	


- (void)toggleOn:(BOOL)state {
	_on = state;
	[self setSelected:_on];
}


-(void)toggle {
	[self setSelected:_on];
}


- (void)buttonPressed:(id)target {
	// 현재 눌려진 버튼의 노티피케이션 전달.
	[self.delegate selectedItem:target];
}


- (void)dealloc {
    [super dealloc];
}

@end
