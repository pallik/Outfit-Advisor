//
//  PKOClothingItemStore.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 26/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOClothingItemStore.h"
#import "PKOClothingItem.h"

@interface PKOClothingItemStore ()

@property (strong, nonatomic) NSMutableArray *privateAllClothingItems;
//@property (strong, nonatomic) NSMutableDictionary *cacheForClothingItemsWithBodyPart;
//@property (strong, nonatomic) NSMutableDictionary *cacheForClothingItemsWithClothingCategory;
//@property (strong, nonatomic) NSMutableSet *cacheForAvailableBodyParts;
//@property (strong, nonatomic) NSMutableSet *cacheForAvailableSortedClothingCategories;

@end


@implementation PKOClothingItemStore

#pragma mark - Lifecycle

- (instancetype)init
{
	if (self = [super init]) {
		_privateAllClothingItems = [[NSMutableArray alloc] init];
	}
	
	return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super init];
	if (self)
	{
		_privateAllClothingItems = [coder decodeObjectForKey:@"privateAllClothingItems"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:self.privateAllClothingItems forKey:@"privateAllClothingItems"];
}

#pragma mark - Clothing Items Handling

- (void)addClothingItem:(PKOClothingItem *)clothingItem
{
	[self.privateAllClothingItems addObject:clothingItem];
}

- (void)removeClothingItem:(PKOClothingItem *)clothingItem
{
	[self.privateAllClothingItems removeObjectIdenticalTo:clothingItem];
}

#pragma mark - Clothing Items Retrieving

- (NSArray *)allClothingItems
{
	return [self.privateAllClothingItems copy];
}

- (NSArray *)clothingItemsWithBodyPart:(PKOBodyPart)bodyPart
{
	return [self clothingItemsFromItems:[self allClothingItems]
						   withBodyPart:bodyPart];
}

- (NSArray *)clothingItemsFromItems:(NSArray *)clothingItems withBodyPart:(PKOBodyPart)bodyPart
{
	NSMutableArray *filteredClothingItems = [[NSMutableArray alloc] init];
	
	for (PKOClothingItem *item in clothingItems) {
		if (item.bodyPart == bodyPart) {
			[filteredClothingItems addObject:item];
		}
	}
	
	return [filteredClothingItems copy];
}

- (NSArray *)clothingItemsWithClothingCategory:(PKOClothingCategory)clothingCategory
{
	return [self clothingItemsFromItems:[self allClothingItems]
				   withClothingCategory:clothingCategory];
}

- (NSArray *)clothingItemsFromItems:(NSArray *)clothingItems withClothingCategory:(PKOClothingCategory)clothingCategory
{
	NSMutableArray *filteredClothingItems = [[NSMutableArray alloc] init];
	
	for (PKOClothingItem *item in clothingItems) {
		if (item.clothingCategory == clothingCategory) {
			[filteredClothingItems addObject:item];
		}
	}
	
	return [filteredClothingItems copy];
}

#pragma mark - Body Parts handling

- (NSSet *)availableBodyParts
{
	NSMutableSet *bodyParts = [[NSMutableSet alloc] init];
	
	for (PKOClothingItem *clothingItem in self.privateAllClothingItems) {
		[bodyParts addObject:@(clothingItem.bodyPart)];
	}
	
	return [bodyParts copy];
}

#pragma mark - Clothing Categories handling

- (NSArray *)availableClothingCategoriesSorted:(BOOL)shouldSort
{
	NSMutableSet *clothingCategories = [[NSMutableSet alloc] init];
	
	for (PKOClothingItem *clothingItem in self.privateAllClothingItems) {
		[clothingCategories addObject:@(clothingItem.clothingCategory)];
	}

	if (!shouldSort) {
		return clothingCategories.allObjects;
	}
	
	NSArray *sortedClothingCategories = [clothingCategories.allObjects sortedArrayUsingSelector:@selector(compare:)];
	return sortedClothingCategories;
}

@end












