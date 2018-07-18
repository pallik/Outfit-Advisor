//
//  PKOClothingCombination+PKORequiredBodyParts.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 18/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOClothingCombination.h"

@interface PKOClothingCombination (PKORequiredBodyParts)

- (void)addRequiredRandomClothingItemsWithAvailableBodyParts:(NSSet *)availableBodyParts;
- (void)addSuitableClothingItemsByGenderAndDressCode;
- (NSArray *)usedBodyPartsAllowedToRemove;

@end
