//
//  PKOClothingCombination+PKORequiredBodyParts.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 18/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOClothingCombination+PKORequiredBodyParts.h"
#import "PKOClothingConstants.h"
#import "PKOClothingItemStore.h"

@implementation PKOClothingCombination (PKORequiredBodyParts)

#pragma mark - Required body parts

+ (NSArray *)requiredBodyPartsSets
{
	static NSArray *requiredBodyPartsSets;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		requiredBodyPartsSets = @[[self requiredTopBodyParts], [self requiredBottomBodyParts], [self requiredFootBodyParts]];
//		requiredBodyPartsSets = @[[self requiredTopBodyParts], [self requiredBottomBodyParts]];
	});
	
	return requiredBodyPartsSets;
}

+ (NSSet *)requiredTopBodyParts
{
	static NSSet *requiredBottomTopParts;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		requiredBottomTopParts = [NSSet setWithObjects:@(PKOBodyPartChest1), @(PKOBodyPartChest2), nil];
	});
	
	return requiredBottomTopParts;
}

+ (NSSet *)requiredBottomBodyParts
{
	static NSSet *requiredBottomBodyParts;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		requiredBottomBodyParts = [NSSet setWithObjects:@(PKOBodyPartHip), @(PKOBodyPartLeg), nil];
	});
	
	return requiredBottomBodyParts;
}

+ (NSSet *)requiredFootBodyParts
{
	static NSSet *requiredFootBodyParts;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		requiredFootBodyParts = [NSSet setWithObjects:@(PKOBodyPartFoot), nil];
	});
	
	return requiredFootBodyParts;
}

#pragma mark - Adding required clothing items

- (void)addRequiredRandomClothingItemsWithAvailableBodyParts:(NSSet *)availableBodyParts
{
	NSArray *requiredBodyPartsSets = [PKOClothingCombination requiredBodyPartsSets];
	for (NSSet *requiredBodyParts in requiredBodyPartsSets) {
		[self addRequiredRandomClothingItemWithAvailableBodyParts:availableBodyParts
												requiredBodyParts:requiredBodyParts];
	}
}

- (void)addRequiredRandomClothingItemWithAvailableBodyParts:(NSSet *)availableBodyParts requiredBodyParts:(NSSet *)requiredBodyParts
{
	NSMutableSet *availableAndRequiredBodyParts = [availableBodyParts mutableCopy];
	[availableAndRequiredBodyParts intersectSet:requiredBodyParts];
	
	if (availableAndRequiredBodyParts.count > 0) {
		PKOClothingItem *requiredRandomClothingItem = [self randomClothingItemFromClothingItems:[self.clothingItemStore allClothingItems]
																				  withBodyParts:availableAndRequiredBodyParts.allObjects];
		[self addClothingItem:requiredRandomClothingItem];
	}
}

#pragma mark - Adding fixed clothing items by gender and dress code

- (void)addSuitableClothingItemsByGenderAndDressCode
{
	NSMutableArray *suitableClothingCategories = [[NSMutableArray alloc] init];
	
	if (self.genderType == PKOGenderTypeMale && self.dressCode == PKODressCodeBusiness)
	{
		[suitableClothingCategories addObject:@(PKOClothingCategoryDressShoes)];
		[suitableClothingCategories addObject:@(PKOClothingCategoryDressPants)];
	}
	
	for (NSNumber *suitableClothingCategoryNumber in suitableClothingCategories) {
		
		PKOClothingCategory suitableClothingCategory = suitableClothingCategoryNumber.unsignedIntegerValue;
		PKOClothingItem *suitableClothingItem = [self randomClothingItemFromClothingItems:[self.clothingItemStore allClothingItems]
																  withClothingCategory:suitableClothingCategory];
		[self addClothingItem:suitableClothingItem];
											  
	}
}

#pragma mark - Removing required clothing items

- (NSArray *)usedBodyPartsAllowedToRemove
{
	NSMutableSet *usedBodyPartsAllowedToRemove = [[self usedBodyParts] mutableCopy];

	NSMutableSet *usedIntersectRequiredBodyParts;
	NSArray *requiredBodyPartsSets = [PKOClothingCombination requiredBodyPartsSets];
	
	for (NSSet *requiredBodyParts in requiredBodyPartsSets)
	{
		usedIntersectRequiredBodyParts = [[self usedBodyParts] mutableCopy];
		[usedIntersectRequiredBodyParts intersectSet:requiredBodyParts];
		//if usedBodyParts contain only 1 from required, remove that from used => cannot remove it from combination
		if (usedIntersectRequiredBodyParts.count == 1) {
			[usedBodyPartsAllowedToRemove minusSet:usedIntersectRequiredBodyParts];
		}
	}
	
	return usedBodyPartsAllowedToRemove.allObjects;
}

@end




















