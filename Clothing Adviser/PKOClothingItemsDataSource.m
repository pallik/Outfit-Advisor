//
//  PKOClothingItemsDataSource.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 08/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOClothingItemsDataSource.h"
#import "PKOClothingItemStore.h"
#import "PKOClothingItem.h"

#import "PKOClothingItemCollectionViewCell.h"
#import "PKOClothingItemsHeaderView.h"

#import "UIView+Borders.h"
#import "UIColor+PKODefaultTint.h"

@interface PKOClothingItemsDataSource ()

@property (strong, nonatomic) PKOClothingItemStore *clothingItemStore;
@property (copy, nonatomic) NSString *cellIdentifier;
@property (copy, nonatomic) NSString *headerIdentifier;

@end

@implementation PKOClothingItemsDataSource

#pragma mark - Lifecycle

- (instancetype)initWithClothingItemStore:(PKOClothingItemStore *)clothingItemStore cellIdentifier:(NSString *)cellIdentifier headerIdentifier:(NSString *)headerIdentifier
{
	if (self = [super init])
	{
		_clothingItemStore = clothingItemStore;
		_cellIdentifier = cellIdentifier;
		_headerIdentifier = headerIdentifier;
	}
	
	return self;
}

#pragma mark - PKOClothingItem

- (PKOClothingItem *)clothingItemAtIndexPath:(NSIndexPath *)indexPath
{
	PKOClothingCategory clothingCategory = [self clothingCategoryForSection:indexPath.section];
	
	NSArray *clothingItemsWithClothingCategory = [self.clothingItemStore clothingItemsWithClothingCategory:clothingCategory];
	PKOClothingItem *clothingItem = clothingItemsWithClothingCategory[indexPath.row];
	
	return clothingItem;
}

- (PKOClothingCategory)clothingCategoryForSection:(NSInteger)section
{
	NSArray *sortedClothingCategories = [self.clothingItemStore availableClothingCategoriesSorted:YES];
	PKOClothingCategory clothingCategory = [(NSNumber *)sortedClothingCategories[section] unsignedIntegerValue];
	
	return clothingCategory;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	NSInteger numberOfSections = [self.clothingItemStore availableClothingCategoriesSorted:NO].count;
	return numberOfSections;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	PKOClothingCategory clothingCategory = [self clothingCategoryForSection:section];
	
	NSInteger numberOfItems = [self.clothingItemStore clothingItemsWithClothingCategory:clothingCategory].count;
	
	return numberOfItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	PKOClothingItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];

	PKOClothingItem *clothingItem = [self clothingItemAtIndexPath:indexPath];
	
	cell.backgroundColor = [UIColor clearColor];
	cell.imageView.image = clothingItem.thumbnail;
	
	return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
	if (![kind isEqualToString:UICollectionElementKindSectionHeader]) {
		NSAssert(false, @"Unexpected element of kind");
	}
	
	PKOClothingItemsHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
																				withReuseIdentifier:self.headerIdentifier
																					   forIndexPath:indexPath];

	PKOClothingCategory clothingCategory = [self clothingCategoryForSection:indexPath.section];
	NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:NSStringFromPKOClothingCategory(clothingCategory)];
	[text addAttribute:NSUnderlineStyleAttributeName
				 value:@(NSUnderlineStyleSingle)
				 range:NSMakeRange(0, [text length])];
	headerView.clothingCategoryLabel.attributedText = [text copy];
	
	return headerView;
}

@end


















