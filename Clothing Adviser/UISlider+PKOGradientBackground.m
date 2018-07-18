//
//  UISlider+PKOGradientBackground.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 13/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "UISlider+PKOGradientBackground.h"
#import "UIImage+PKOClothingImage.h"

@implementation UISlider (PKOGradientBackground)


- (void)pko_setGradientBackgroundWithColors:(NSArray *)colors
{
	CAGradientLayer *trackGradientLayer = [CAGradientLayer layer];
	CGRect frame = self.frame;
	frame.size.height = 5.0;
	trackGradientLayer.frame = frame;
	trackGradientLayer.colors = colors;
	trackGradientLayer.startPoint = CGPointMake(0.0, 0.5);
	trackGradientLayer.endPoint = CGPointMake(1.0, 0.5);
	
	UIImage *trackImage = [[UIImage pko_imageFromLayer:trackGradientLayer] resizableImageWithCapInsets:UIEdgeInsetsZero];
	[self setMinimumTrackImage:trackImage forState:UIControlStateNormal];
	[self setMaximumTrackImage:trackImage forState:UIControlStateNormal];
}

- (void)pko_setGradientBackgroundForSaturationWithColor:(UIColor *)color
{
	CGFloat hue, saturation, brightness, alpha;
	[color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
	
	UIColor *minColor = [UIColor colorWithHue:hue saturation:0.0 brightness:brightness alpha:alpha];
	UIColor *maxColor = [UIColor colorWithHue:hue saturation:1.0 brightness:brightness alpha:alpha];
	
	NSArray *colors = [NSArray arrayWithObjects:(id)minColor.CGColor, (id)maxColor.CGColor, nil];
	[self pko_setGradientBackgroundWithColors:colors];
}

- (void)pko_setGradientBackgroundForBrightnessWithColor:(UIColor *)color
{
	CGFloat hue, saturation, brightness, alpha;
	[color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
	
	UIColor *minColor = [UIColor colorWithHue:hue saturation:saturation brightness:0.0 alpha:alpha];
	UIColor *maxColor = [UIColor colorWithHue:hue saturation:saturation brightness:1.0 alpha:alpha];
	
	NSArray *colors = [NSArray arrayWithObjects:(id)minColor.CGColor, (id)maxColor.CGColor, nil];
	[self pko_setGradientBackgroundWithColors:colors];
}

@end
