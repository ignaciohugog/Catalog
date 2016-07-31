//
//  ContentView.m
//  Catalog
//
//  Created by Ignacio H. Gomez on 7/29/16.
//  Copyright © 2016 Ignacio H. Gomez. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView

-  (id)initWithFrame:(CGRect)aRect {
	self = [super initWithFrame:aRect];

	if (self) {
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self && self.subviews.count == 0) {
		NSString *className = NSStringFromClass([self class]);
		UIView*ls = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
		[self addSubview:ls];
	}
	return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
