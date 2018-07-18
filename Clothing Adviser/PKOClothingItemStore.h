//
//  PKOClothingItemStore.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 26/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKOClothingConstants.h"

@class PKOClothingItem;

@interface PKOClothingItemStore : NSObject <NSCoding>

- (NSArray *)allClothingItems;
- (void)addClothingItem:(PKOClothingItem *)clothingItem;
- (void)removeClothingItem:(PKOClothingItem *)clothingItem;
- (NSArray *)clothingItemsWithBodyPart:(PKOBodyPart)bodyPart;
- (NSArray *)clothingItemsFromItems:(NSArray *)clothingItems withBodyPart:(PKOBodyPart)bodyPart;

- (NSArray *)clothingItemsWithClothingCategory:(PKOClothingCategory)clothingCategory;
- (NSArray *)clothingItemsFromItems:(NSArray *)clothingItems withClothingCategory:(PKOClothingCategory)clothingCategory;

- (NSSet *)availableBodyParts;

- (NSArray *)availableClothingCategoriesSorted:(BOOL)shouldSort;
//TODO: cache
//- (void)clearCache;

@end
