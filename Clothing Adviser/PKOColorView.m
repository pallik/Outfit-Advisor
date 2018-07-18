//
//  PKOColorView.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 13/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOColorView.h"

static NSUInteger const PKOColorViewSelectedHeightOffset = 20;


@interface PKOColorView ()

@property (assign, nonatomic) CGRect originalFrame;

@end


@implementation PKOColorView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		_originalFrame = self.frame;
	}
	
	return self;
}

#pragma mark - (de)selecting view

- (void)selectView
{
	CGRect newBounds = self.bounds;
	CGFloat newHeight = CGRectGetHeight(newBounds) + PKOColorViewSelectedHeightOffset;
	CGFloat newCenterY = self.center.y - PKOColorViewSelectedHeightOffset / 2.0;
	
	newBounds.size.height = newHeight;
	self.bounds = newBounds;
	self.center = CGPointMake(self.center.x, newCenterY);
	
	CAShapeLayer * maskLayer = [CAShapeLayer layer];
	maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
										   byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
												 cornerRadii:CGSizeMake(15.0, 15.0)].CGPath;
	self.layer.mask = maskLayer;
}

- (void)deselectView
{
	self.frame = self.originalFrame;
	self.layer.mask = nil;
}

@end














