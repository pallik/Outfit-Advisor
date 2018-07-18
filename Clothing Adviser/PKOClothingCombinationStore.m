//
//  PKOClothingCombinationStore.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 28/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOClothingCombinationStore.h"
#import "PKOClothingCombination.h"
#import "PKOClothingItem.h"

@interface PKOClothingCombinationStore ()

@property (strong, nonatomic) NSMutableArray *privateClothingCombinations;
@property (strong, nonatomic) NSMutableSet *privateRefusedClothingCombinations;

@end


@implementation PKOClothingCombinationStore

#pragma mark - Lifecycle

- (instancetype)init
{
	if (self = [super init]) {
		_privateClothingCombinations = [[NSMutableArray alloc] init];
		_privateRefusedClothingCombinations = [[NSMutableSet alloc] init];
	}
	
	return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super init];
	if (self)
	{
		_privateClothingCombinations = [coder decodeObjectForKey:@"privateAllClothingCombinations"];
		_privateRefusedClothingCombinations = [coder decodeObjectForKey:@"privateRefusedClothingCombinations"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:self.privateClothingCombinations forKey:@"privateAllClothingCombinations"];
	[coder encodeObject:self.privateRefusedClothingCombinations forKey:@"privateRefusedClothingCombinations"];
}

#pragma mark - Clothing Combinations Handling

- (void)addClothingCombination:(PKOClothingCombination *)clothingCombination
{
	[self.privateClothingCombinations addObject:clothingCombination];
}

- (void)removeClothingCombination:(PKOClothingCombination *)clothingCombination
{
	[self.privateClothingCombinations removeObject:clothingCombination];
}

#pragma mark - Clothing Combinations Retrieving

- (NSArray *)clothingCombinations
{
	return [self.privateClothingCombinations copy];
}

- (NSArray *)clothingCombinationsWithDressCode:(PKODressCode)dressCode
{
	NSMutableArray *filteredClothingCombinations = [[NSMutableArray alloc] init];
	
	for (PKOClothingCombination *combination in self.privateClothingCombinations) {
		if (combination.dressCode == dressCode) {
			[filteredClothingCombinations addObject:combination];
		}
	}
	
	return [filteredClothingCombinations copy];
}

- (NSArray *)clothingCombinationsWithClothingItem:(PKOClothingItem *)clothingItem
{
	NSMutableArray *filteredClothingCombinations = [[NSMutableArray alloc] init];
	
	for (PKOClothingCombination *combination in self.privateClothingCombinations) {
		
		if ([[combination clothingItems] containsObject:clothingItem]) {
			[filteredClothingCombinations addObject:combination];
		}
	}
	
	return [filteredClothingCombinations copy];
}

#pragma mark - Refused clothing combinations

- (void)addRefusedClothingCombination:(PKOClothingCombination *)refusedClothingCombination
{
	refusedClothingCombination.refused = YES;
	[self.privateRefusedClothingCombinations addObject:refusedClothingCombination];
}

- (void)removeRefusedClothingCombination:(PKOClothingCombination *)refusedClothingCombination
{
	[self.privateRefusedClothingCombinations removeObject:refusedClothingCombination];
}

- (NSSet *)refusedClothingCombinations
{
	return [self.privateRefusedClothingCombinations copy];
}

- (void)resetRefusedClothingCombinations
{
	[self.privateRefusedClothingCombinations removeAllObjects];
}

#pragma mark - Clothing Combinations Checking

- (BOOL)isAlreadyGeneratedClothingCombination:(PKOClothingCombination *)clothingCombination
{
	for (PKOClothingCombination *alreadyGeneratedCombination in self.privateClothingCombinations) {
		if ([clothingCombination.clothingItems isEqualToSet:alreadyGeneratedCombination.clothingItems]) {
			return YES;
		}
	}
	
	return NO;
}

@end
















