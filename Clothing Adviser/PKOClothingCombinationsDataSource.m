//
//  PKOClothingCombinationsDataSource.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 16/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOClothingCombinationsDataSource.h"
#import "PKOClothingCombinationStore.h"
#import "PKOClothingCombination.h"
#import "PKOClothingItem.h"

#import "PKOClothingItemCollectionViewCell.h"
#import "PKOClothingCombinationHeaderView.h"

#import "UIView+Borders.h"
#import "UIColor+PKODefaultTint.h"


@implementation PKOClothingCombinationsDataSource

#pragma mark - Lifecycle

- (instancetype)init
{
	self = [super init];
	if (self)
	{
		_cellIdentifier = NSStringFromClass([PKOClothingItemCollectionViewCell class]);
	}
	
	return self;
}

#pragma mark - PKOClothingCombination & PKOClothingItem

- (PKOClothingCombination *)clothingCombinationInSection:(NSUInteger)section
{
	NSArray *clothingCombinations = self.clothingCombinations;
	if (clothingCombinations.count == 0) {
		return nil;
	}
	PKOClothingCombination *clothingCombination = clothingCombinations[section];
	
	return clothingCombination;
}

- (PKOClothingItem *)clothingItemAtIndexPath:(NSIndexPath *)indexPath
{
	PKOClothingCombination *clothingCombination = [self clothingCombinationInSection:indexPath.section];
	if (!clothingCombination) {
		return nil;
	}
	NSArray *clothingItems = [clothingCombination sortedClothingItems];
	PKOClothingItem *clothingItem = clothingItems[indexPath.row];
	
	return clothingItem;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	NSUInteger numberOfCombinations = self.clothingCombinations.count;
	NSUInteger numberOfSections = MAX(numberOfCombinations, 1);
	return numberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	PKOClothingCombination *clothingCombination = [self clothingCombinationInSection:section];
	if (!clothingCombination) {
		return 0;
	}
	
	NSUInteger numberOfClothingItems = [clothingCombination clothingItems].count;
	return numberOfClothingItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	PKOClothingItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier
																						forIndexPath:indexPath];
	
	PKOClothingItem *clothingItem = [self clothingItemAtIndexPath:indexPath];
	
	self.configureCellBlock(cell, clothingItem);
	
	return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
	if (![kind isEqualToString:UICollectionElementKindSectionHeader]) {
		NSAssert(false, @"Unexpected element of kind");
	}
	
	if (indexPath.section == 0) {
		NSString *reusableIdentifier = NSStringFromClass([PKOClothingCombinationHeaderView class]);
		PKOClothingCombinationHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
																						  withReuseIdentifier:reusableIdentifier
																								 forIndexPath:indexPath];
		[self addBottomBorderToView:headerView];
		return headerView;
	}
	
	NSString *separatorViewReusableIdentifier = NSStringFromClass([UICollectionReusableView class]);
	UICollectionReusableView *separatorView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
																				 withReuseIdentifier:separatorViewReusableIdentifier
																						forIndexPath:indexPath];
	[self addBottomBorderToView:separatorView];
	return separatorView;
}

- (void)addBottomBorderToView:(UIView *)view
{
	[view addBottomBorderWithHeight:1.0
							color:[UIColor colorWithWhite:0.9 alpha:1.0]
						 leftOffset:8.0
						rightOffset:8.0
					andBottomOffset:0.0];
}

@end










