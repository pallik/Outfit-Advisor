//
//  PKOColorPaletteRating.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 31/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rateColorPalette.h"

static NSUInteger const PKOColorPaletteColorsCount = 5;

//void paletteFromRGBcolors(real_T palette[15], const uint8_T color1[3], const uint8_T color2[3], const uint8_T color3[3], const uint8_T color4[3], const uint8_T color5[3])
//{
//	palette[0] = (real_T) color1[0] / 255.0;
//	palette[1] = (real_T) color2[0] / 255.0;
//	palette[2] = (real_T) color3[0] / 255.0;
//	palette[3] = (real_T) color4[0] / 255.0;
//	palette[4] = (real_T) color5[0] / 255.0;
//	
//	palette[5] = (real_T) color1[1] / 255.0;
//	palette[6] = (real_T) color2[1] / 255.0;
//	palette[7] = (real_T) color3[1] / 255.0;
//	palette[8] = (real_T) color4[1] / 255.0;
//	palette[9] = (real_T) color5[1] / 255.0;
//	
//	palette[10] = (real_T) color1[2] / 255.0;
//	palette[11] = (real_T) color2[2] / 255.0;
//	palette[12] = (real_T) color3[2] / 255.0;
//	palette[13] = (real_T) color4[2] / 255.0;
//	palette[14] = (real_T) color5[2] / 255.0;
//}

float PKOComputeColorPaletteRating(NSArray *colors)
{
	float rating = 0.0;
	if (colors.count < PKOColorPaletteColorsCount) {
		return rating;
	}
	
	real_T data[15];
	CGFloat r, g, b, a;
	for (int i = 0; i < PKOColorPaletteColorsCount; ++i) {
		[(UIColor *)colors[i] getRed:&r green:&g blue:&b alpha:&a];
		
		data[0*PKOColorPaletteColorsCount + i] = r;
		data[1*PKOColorPaletteColorsCount + i] = g;
		data[2*PKOColorPaletteColorsCount + i] = b;
	}
	
	rating = rateColorPalette(data);
	
	return rating;
}


















