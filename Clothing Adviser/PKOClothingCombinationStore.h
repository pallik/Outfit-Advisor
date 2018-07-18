//
//  PKOClothingCombinationStore.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 28/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKOClothingConstants.h"

@class PKOClothingCombination;
@class PKOClothingItem;

@interface PKOClothingCombinationStore : NSObject

- (void)addClothingCombination:(PKOClothingCombination *)clothingCombination;
- (void)removeClothingCombination:(PKOClothingCombination *)clothingCombination;
- (NSArray *)clothingCombinations;

- (void)addRefusedClothingCombination:(PKOClothingCombination *)refusedClothingCombination;
- (void)removeRefusedClothingCombination:(PKOClothingCombination *)refusedClothingCombination;
- (NSSet *)refusedClothingCombinations;
- (void)resetRefusedClothingCombinations;

- (NSArray *)clothingCombinationsWithDressCode:(PKODressCode)dressCode;
- (NSArray *)clothingCombinationsWithClothingItem:(PKOClothingItem *)clothingItem;
- (BOOL)isAlreadyGeneratedClothingCombination:(PKOClothingCombination *)clothingCombination;

@end
