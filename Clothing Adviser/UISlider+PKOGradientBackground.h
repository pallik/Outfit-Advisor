//
//  UISlider+PKOGradientBackground.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 13/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISlider (PKOGradientBackground)

- (void)pko_setGradientBackgroundWithColors:(NSArray *)colors;
- (void)pko_setGradientBackgroundForSaturationWithColor:(UIColor *)color;
- (void)pko_setGradientBackgroundForBrightnessWithColor:(UIColor *)color;

@end
