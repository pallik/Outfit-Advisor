//
//  UIColor+PKODefaultTint.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 30/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "UIColor+PKODefaultTint.h"

@implementation UIColor (PKODefaultTint)

#pragma mark - Default tint color

+ (UIColor *)customDefaultTintColor
{
	static UIColor *defaultTintColor;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		defaultTintColor = [UIColor colorWithRed:1.000 green:0.361 blue:0.325 alpha:1.000];
	});

	return defaultTintColor;
}

@end
