//
//  PKOClothingColorRating.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 30/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKOClothingColorRating.h"
#import "PKOClothingItem.h"
#import "PKOColorPaletteRating.h"

#import "NSArray+PKORandom.h"

static NSUInteger const PKOComputeColorRatingRepeatCount = 10;
static float const PKOComputeColorRatingNormalizationConstant = 3.0;
static float const PKOComputeColorRatingMaximumColorRating = 3.0;

@interface PKOClothingColorRating ()

@property (strong, nonatomic) NSMutableArray *colors;
@property (copy, nonatomic) NSArray *clothingItems;

@end

@implementation PKOClothingColorRating

#pragma mark - Lifecycle

- (instancetype)initWithSortedClothingItems:(NSArray *)clothingItems
{
	if (self = [super init])
	{
		_clothingItems = clothingItems;
		_colors = [[NSMutableArray alloc] init];
	}
	
	return self;
}

#pragma mark - Computing rating

- (float)computeRatingWithShuffleColors:(BOOL)shuffleColors
{
	float rating = 0.0;
	if (![self fillColorsFromClothingItems]) {
		return rating;
	}

	if (shuffleColors) {
		for (NSUInteger i = 0; i < PKOComputeColorRatingRepeatCount; ++i) {
			rating += PKOComputeColorPaletteRating([self.colors pko_shuffle]);
		}
		rating /= PKOComputeColorRatingRepeatCount;
	} else {
		rating = PKOComputeColorPaletteRating([self.colors copy]);
	}
	
	//if rating is too high, cut to PKOComputeColorRatingMaximumColorRating
	if (rating > PKOComputeColorRatingMaximumColorRating) {
		rating = PKOComputeColorRatingMaximumColorRating;
	}
	
	rating /= PKOComputeColorRatingNormalizationConstant;
	return rating;
}

#pragma mark - Colors handling

- (BOOL)fillColorsFromClothingItems
{
	if (self.colors.count >= PKOColorPaletteColorsCount) {
		return YES;
	}
	[self.colors removeAllObjects];

	//Fill colors with dominant colors
	for (NSUInteger dominantColorIndex = 0; dominantColorIndex < PKOColorPaletteColorsCount; ++dominantColorIndex) {
		for (PKOClothingItem *item in self.clothingItems) {
			if (item.dominantColors.count > dominantColorIndex) {
				[self.colors addObject:item.dominantColors[dominantColorIndex]];
			}
		}
		if (self.colors.count >= PKOColorPaletteColorsCount) {
			break;
		}
	}
	
	NSUInteger count = self.colors.count;
	//If no dominant colors at all, return NO
	if (count == 0) {
		return NO;
	}
	
	//If more than PKOColorPaletteColorsCount, take only first PKOColorPaletteColorsCount
	if (count > PKOColorPaletteColorsCount) {
		[self.colors removeObjectsInRange:NSMakeRange(PKOColorPaletteColorsCount, count - PKOColorPaletteColorsCount)];
		return YES;
	}
	
	//If not enough, duplicate the first ones
	NSUInteger i = 0;
	while (self.colors.count < PKOColorPaletteColorsCount) {
		[self.colors addObject:self.colors[i]];
		i++;
	}
	
	return YES;
}

@end























