//
//  PKOClothesProbabilities.h
//  ClothesProbabilities
//
//  Created by Pavol Kominak on 13/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKOClothingConstants.h"

@class PKOClothingCombination;
@class PKOUser;

@interface PKOClothingProbabilities : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithUser:(PKOUser *)user withDressCode:(PKODressCode)dressCode NS_DESIGNATED_INITIALIZER;

- (void)saveChanges;
- (void)addNewClothingCombination:(PKOClothingCombination *)clothingCombination;

- (float)probabilityForClothingCombination:(PKOClothingCombination *)clothingCombination;

@end












