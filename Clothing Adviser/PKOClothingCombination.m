//
//  PKOClothingCombination.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 26/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOClothingCombination.h"
#import "PKOClothingItem.h"
#import "PKOClothingItemStore.h"

#import "PKOClothingColorRating.h"
#import "PKOClothingProbabilities.h"

#import "NSArray+PKORandom.h"
#import "PKOClothingCombination+PKORequiredBodyParts.h"

NSUInteger const PKOClothingCombinationMinimumClothingItems = 2;
static NSUInteger const PKOClothingCombinationMaximumClothingItemsInRandomCombination = 6;
static float const PKOClothingCombinationColorRatingWeight = 0.4;
static float const PKOClothingCombinationProbabilityRatingWeight = 0.6;

@interface PKOClothingCombination ()

@property (strong, nonatomic) NSMutableSet *privateClothingItems;
@property (strong, nonatomic) NSMutableSet *privateUsedBodyParts;

@end


@implementation PKOClothingCombination

#pragma mark - Lifecycle

+ (instancetype)randomClothingCombinationWithClothingItemStore:(PKOClothingItemStore *)clothingItemStore withGender:(PKOGenderType)genderType withDressCode:(PKODressCode)dressCode
{
	PKOClothingCombination *clothingCombination = [[PKOClothingCombination alloc] initWithClothingItemStore:clothingItemStore
																								 withGender:genderType
																							  withDressCode:dressCode];
	

	[clothingCombination addSuitableClothingItemsByGenderAndDressCode];
	
	NSSet *availableBodyParts = [clothingCombination.clothingItemStore availableBodyParts];
	[clothingCombination addRequiredRandomClothingItemsWithAvailableBodyParts:availableBodyParts];
	
	uint32_t diff = PKOClothingCombinationMaximumClothingItemsInRandomCombination - PKOClothingCombinationMinimumClothingItems;
	NSInteger randomCount = arc4random_uniform(diff + 1) + PKOClothingCombinationMinimumClothingItems;
	//lower count if combination already contains clothing items
	randomCount -= [clothingCombination clothingItems].count;

	NSArray *unusedBodyParts;
	for (NSInteger i = 0; i < randomCount; i++) {
		unusedBodyParts = [clothingCombination unusedBodyPartsFromAvailableBodyParts:availableBodyParts];
		[clothingCombination addRandomClothingItemWithUnusedBodyParts:unusedBodyParts];
	}
	
	return clothingCombination;
}

- (instancetype)initWithClothingItemStore:(PKOClothingItemStore *)clothingItemStore withGender:(PKOGenderType)genderType withDressCode:(PKODressCode)dressCode
{
	if (self = [super init]) {
		_genderType = genderType;
		_dressCode = dressCode;
		_refused = NO;
		_rating = 0.0;
		
		_clothingItemStore = clothingItemStore;
		_privateClothingItems = [[NSMutableSet alloc] init];
		_privateUsedBodyParts = [[NSMutableSet alloc] init];
	}
	
	return self;
}

- (instancetype)initWithClothingCombination:(PKOClothingCombination *)clothingCombination
{
	if (self = [self initWithClothingItemStore:clothingCombination.clothingItemStore
									withGender:clothingCombination.genderType
								 withDressCode:clothingCombination.dressCode])
	{
		_privateClothingItems = [[clothingCombination clothingItems] mutableCopy];
		_privateUsedBodyParts = [[clothingCombination usedBodyParts] mutableCopy];
	}
	
	return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super init];
	if (self)
	{
		_genderType = [coder decodeIntegerForKey:@"genderType"];
		_dressCode = [coder decodeIntegerForKey:@"dressCode"];
		_refused = [coder decodeBoolForKey:@"refused"];
		_rating = [coder decodeFloatForKey:@"rating"];
		
		_clothingItemStore = [coder decodeObjectForKey:@"clothingItemStore"];
		_privateClothingItems = [coder decodeObjectForKey:@"privateClothingItems"];
		_privateUsedBodyParts = [coder decodeObjectForKey:@"privateUsedBodyParts"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeInteger:self.genderType forKey:@"genderType"];
	[coder encodeInteger:self.dressCode forKey:@"dressCode"];
	[coder encodeBool:self.refused forKey:@"refused"];
	[coder encodeFloat:self.rating forKey:@"rating"];
	
	[coder encodeObject:self.clothingItemStore forKey:@"clothingItemStore"];
	[coder encodeObject:self.privateClothingItems forKey:@"privateClothingItems"];
	[coder encodeObject:self.privateUsedBodyParts forKey:@"privateUsedBodyParts"];
}

#pragma mark - isEqual:

- (BOOL)isEqualToClothingCombination:(PKOClothingCombination *)combination
{
	if (!combination) {
		return NO;
	}
	
	return [self.privateClothingItems isEqualToSet:[combination clothingItems]];
}

- (BOOL)isEqual:(id)other
{
	if (other == self) {
		return YES;
	} else if ([super isEqual:other]) {
		return YES;
	} else {
		return [self isEqualToClothingCombination:(PKOClothingCombination *)other];
	}
}

- (NSUInteger)hash
{
	return [self.privateClothingItems hash];
}

#pragma mark - Properties

- (NSSet *)usedBodyParts
{
	return [self.privateUsedBodyParts copy];
}

- (NSSet *)clothingItems
{
	return [self.privateClothingItems copy];
}

- (BOOL)addClothingItem:(PKOClothingItem *)clothingItem
{
	if (!clothingItem || [self.privateUsedBodyParts containsObject:@(clothingItem.bodyPart)]) {
		return NO;
	}
	
	[self.privateClothingItems addObject:clothingItem];
	[self.privateUsedBodyParts addObject:@(clothingItem.bodyPart)];
	return YES;
}

- (BOOL)removeClothingItem:(PKOClothingItem *)clothingItem
{
	if ([self.privateClothingItems containsObject:clothingItem])
	{
		[self.privateClothingItems removeObject:clothingItem];
		[self.privateUsedBodyParts removeObject:@(clothingItem.bodyPart)];
		return YES;
	}
	
	return NO;
}

#pragma mark - Computing rating

- (float)computeOverallRating:(PKOClothingProbabilities *)clothingProbabilites
{
	float rating = 0.0;
	
	rating += [self computeOnlyColorRatingWithShuffleColors:NO] * PKOClothingCombinationColorRatingWeight;
	rating += [self computeOnlyProbabilityRating:clothingProbabilites] * PKOClothingCombinationProbabilityRatingWeight;
	
	self.rating = rating;
	return rating;
}

- (float)computeOnlyColorRatingWithShuffleColors:(BOOL)shuffleColors
{
	NSArray *sortedClothingItems = [self sortedClothingItems];
	PKOClothingColorRating *colorPaletteRating = [[PKOClothingColorRating alloc] initWithSortedClothingItems:sortedClothingItems];
	float rating = [colorPaletteRating computeRatingWithShuffleColors:shuffleColors];
	
	self.rating = rating;
	return rating;
}

- (float)computeOnlyProbabilityRating:(PKOClothingProbabilities *)clothingProbabilities
{
	float rating = [clothingProbabilities probabilityForClothingCombination:self];
	
	self.rating = rating;
	return rating;
}

#pragma mark - Variating combination

- (PKOClothingCombination *)randomVariation
{
	PKOClothingCombination *newClothingCombination = [[PKOClothingCombination alloc] initWithClothingCombination:self];

	NSArray *unusedBodyParts = [self unusedBodyPartsFromAvailableBodyParts:[self.clothingItemStore availableBodyParts]];
	BOOL combinationDidChange = NO;
	
	NSUInteger random = arc4random_uniform(3);
	switch (random) {
		case 0:
			combinationDidChange = [newClothingCombination addRandomClothingItemWithUnusedBodyParts:unusedBodyParts];
			break;
		case 1:
			combinationDidChange = [newClothingCombination removeRandomClothingItemWithUnusedBodyParts:unusedBodyParts];
			break;
		case 2:
			combinationDidChange = [newClothingCombination swapRandomClothingItemWithUnusedBodyParts:unusedBodyParts
//																						keepBodyPart:NO];
																						keepBodyPart:YES];
			break;
	}
	
	if (combinationDidChange) {
//		NSLog(@"combination did change");
		return newClothingCombination;
	}
	
	return nil;
}

- (BOOL)addRandomClothingItemWithUnusedBodyParts:(NSArray *)unusedBodyParts
{
//	NSLog(@"adding");
	if (unusedBodyParts.count == 0) {
		return [self swapRandomClothingItemWithUnusedBodyParts:unusedBodyParts
												  keepBodyPart:YES];
	}

	PKOClothingItem *randomClothingItem = [self randomClothingItemFromClothingItems:[self.clothingItemStore allClothingItems]
																	  withBodyParts:unusedBodyParts];
	
	return [self addClothingItem:randomClothingItem];
}

- (BOOL)removeRandomClothingItemWithUnusedBodyParts:(NSArray *)unusedBodyParts
{
//	NSLog(@"removing");
	if (self.privateClothingItems.count <= PKOClothingCombinationMinimumClothingItems) {
		return [self swapRandomClothingItemWithUnusedBodyParts:unusedBodyParts keepBodyPart:YES];
	}
	
	NSArray *usedBodyPartsAllowedToRemove = [self usedBodyPartsAllowedToRemove];
	if (usedBodyPartsAllowedToRemove.count == 0) {
		return [self swapRandomClothingItemWithUnusedBodyParts:unusedBodyParts keepBodyPart:YES];
	}
	
	PKOClothingItem *removingClothingItem = [self randomClothingItemFromClothingItems:self.privateClothingItems.allObjects
																		withBodyParts:usedBodyPartsAllowedToRemove];
	
	return [self removeClothingItem:removingClothingItem];
}

- (BOOL)swapRandomClothingItemWithUnusedBodyParts:(NSArray *)unusedBodyParts keepBodyPart:(BOOL)keepBodyPart
{
//	NSLog(@"swapping, keep: %d", keepBodyPart);
	PKOClothingItem *removingClothingItem = [self.privateClothingItems.allObjects pko_randomObject];
	if (!removingClothingItem) {
		return NO;
	}
	
	if (!keepBodyPart && removingClothingItem.bodyPart == PKOBodyPartHip) {
		NSLog(@"ERROR: SWAPPING REQUIRED PKOBodyPartHip, keep: %d", keepBodyPart);
	}

	PKOBodyPart newBodyPart;
	if (keepBodyPart || unusedBodyParts.count == 0) {
		newBodyPart = removingClothingItem.bodyPart;
	} else {
		newBodyPart = [(NSNumber *)[unusedBodyParts pko_randomObject] unsignedIntegerValue];
	}
	
	[self removeClothingItem:removingClothingItem];
	PKOClothingItem *addingClothingItem = [[self.clothingItemStore clothingItemsWithBodyPart:newBodyPart] pko_randomObject];
	
	return [self addClothingItem:addingClothingItem];
}

- (NSArray *)unusedBodyPartsFromAvailableBodyParts:(NSSet *)availableBodyParts
{
	NSMutableSet *unusedBodyParts = [NSMutableSet setWithSet:availableBodyParts];
	[unusedBodyParts minusSet:self.privateUsedBodyParts];
	
	return unusedBodyParts.allObjects;
}

#pragma mark - Sort clothing items

- (NSArray *)sortedClothingItems
{
	NSArray *sorted = [self.clothingItems.allObjects sortedArrayUsingComparator:^NSComparisonResult(PKOClothingItem *item1, PKOClothingItem *item2) {
		if (item1.bodyPart < item2.bodyPart) {
			return NSOrderedAscending;
		} else if (item1.bodyPart > item2.bodyPart) {
			return NSOrderedDescending;
		}
		return NSOrderedSame;
	}];
	
	return sorted;
}

#pragma mark - Random clothing item

- (PKOClothingItem *)randomClothingItemFromClothingItems:(NSArray *)clothingItems withBodyParts:(NSArray *)bodyParts
{
	PKOBodyPart randomBodyPart = [(NSNumber *)[bodyParts pko_randomObject] unsignedIntegerValue];
	
	NSArray *filteredClothingItems = [self.clothingItemStore clothingItemsFromItems:clothingItems
																	   withBodyPart:randomBodyPart];

	PKOClothingItem *randomClothingItem = [filteredClothingItems pko_randomObject];
	return randomClothingItem;
}

- (PKOClothingItem *)randomClothingItemFromClothingItems:(NSArray *)clothingItems withClothingCategory:(PKOClothingCategory)clothingCategory
{
	NSArray *filteredClothingItems = [self.clothingItemStore clothingItemsFromItems:clothingItems
															   withClothingCategory:clothingCategory];
	
	PKOClothingItem *randomClothingItem = [filteredClothingItems pko_randomObject];
	return randomClothingItem;
}

@end



















