//
//  PKOClothingItem+PKOClothingCategoryContainers.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 16/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOClothingItem+PKOClothingCategoryContainers.h"

NSString *const PKOClothingCategoryContainerHead = @"Head";
NSString *const PKOClothingCategoryContainerChest = @"Chest";
NSString *const PKOClothingCategoryContainerLegs = @"Legs";
NSString *const PKOClothingCategoryContainerFeet = @"Feet";
NSString *const PKOClothingCategoryContainerAccessories = @"Accessories";

@implementation PKOClothingItem (PKOClothingCategoryContainers)

#pragma mark - Clothing category containers

+ (NSDictionary *)clothingCategoryContainers
{
	static NSDictionary *clothingCategoryContainers;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		clothingCategoryContainers = @{
									   PKOClothingCategoryContainerHead:
										   @[@(PKOClothingCategoryScarf),
											 @(PKOClothingCategoryCasualHat),
											 @(PKOClothingCategoryDressHat),
											 @(PKOClothingCategoryHeadWrap)],
									   PKOClothingCategoryContainerChest:
										   @[@(PKOClothingCategoryCasualShirt),
											 @(PKOClothingCategoryDressShirt),
											 @(PKOClothingCategoryTShirt),
											 @(PKOClothingCategorySleeveless),
											 @(PKOClothingCategoryDress),
											 @(PKOClothingCategoryBlouse),
											 @(PKOClothingCategoryLongTShirt),
											 @(PKOClothingCategoryTank),
											 @(PKOClothingCategorySweater),
											 @(PKOClothingCategoryVest),
											 @(PKOClothingCategoryTop),
											 @(PKOClothingCategoryHoodie),
											 @(PKOClothingCategoryJacket),
											 @(PKOClothingCategorySuit),
											 @(PKOClothingCategoryOpenSweater)],
									   PKOClothingCategoryContainerLegs:
										   @[@(PKOClothingCategorySportPants),
											 @(PKOClothingCategoryCasualPants),
											 @(PKOClothingCategoryDressPants),
											 @(PKOClothingCategoryJeans),
											 @(PKOClothingCategoryShorts),
											 @(PKOClothingCategoryDressSkirt),
											 @(PKOClothingCategorySkirt),
											 @(PKOClothingCategoryLegging)],
									   PKOClothingCategoryContainerFeet:
										   @[@(PKOClothingCategoryDressShoes),
											 @(PKOClothingCategorySportShoes),
											 @(PKOClothingCategoryCasualShoes),
											 @(PKOClothingCategorySlippers),
											 @(PKOClothingCategoryBoots),
											 @(PKOClothingCategorySock)],
									   PKOClothingCategoryContainerAccessories:
										   @[@(PKOClothingCategoryTie),
											 @(PKOClothingCategoryBowTie),
											 @(PKOClothingCategoryNecklace),
											 @(PKOClothingCategoryEarRings),
											 @(PKOClothingCategoryWatch),
											 @(PKOClothingCategoryBracelet),
											 @(PKOClothingCategoryBelt),
											 @(PKOClothingCategoryGlasses),
											 @(PKOClothingCategorySunGlasses)]
									   };
	});
	
	return clothingCategoryContainers;
}

+ (NSArray *)clothingCategoryContainerKeys
{
	static NSArray *clothingCategoryContainerKeys;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		clothingCategoryContainerKeys = @[PKOClothingCategoryContainerHead, PKOClothingCategoryContainerChest, PKOClothingCategoryContainerLegs, PKOClothingCategoryContainerFeet, PKOClothingCategoryContainerAccessories];
	});
	
	return clothingCategoryContainerKeys;
}

+ (NSString *)clothingCategoryContainerForClothingCategory:(PKOClothingCategory)clothingCategory
{
	NSDictionary *clothingCategoryContainers = [self clothingCategoryContainers];
	
	for (NSString *clothingCategoryContainerLabel in clothingCategoryContainers) {
		NSArray *clothingCategoryContainer = clothingCategoryContainers[clothingCategoryContainerLabel];
		
		if ([clothingCategoryContainer containsObject:@(clothingCategory)]) {
			return clothingCategoryContainerLabel;
		}
	}
	
	return nil;
}

@end










