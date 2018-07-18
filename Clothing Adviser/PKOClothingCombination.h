//
//  PKOClothingCombination.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 26/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKOClothingConstants.h"

@class PKOClothingItem;
@class PKOClothingItemStore;
@class PKOClothingProbabilities;


extern NSUInteger const PKOClothingCombinationMinimumClothingItems;

@interface PKOClothingCombination : NSObject <NSCoding>

@property (strong, nonatomic) PKOClothingItemStore *clothingItemStore;
@property (assign, nonatomic) PKOGenderType genderType;
@property (assign, nonatomic) PKODressCode dressCode;
@property (assign, nonatomic) float rating;
@property (assign, nonatomic, getter=isRefused) BOOL refused;

+ (instancetype)randomClothingCombinationWithClothingItemStore:(PKOClothingItemStore *)clothingItemStore withGender:(PKOGenderType)genderType withDressCode:(PKODressCode)dressCode;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithClothingItemStore:(PKOClothingItemStore *)clothingItemStore withGender:(PKOGenderType)genderType withDressCode:(PKODressCode)dressCode NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithClothingCombination:(PKOClothingCombination *)clothingCombination;

- (NSSet *)usedBodyParts;
- (NSSet *)clothingItems;
- (NSArray *)sortedClothingItems;
- (BOOL)addClothingItem:(PKOClothingItem *)clothingItem;
- (BOOL)removeClothingItem:(PKOClothingItem *)clothingItem;

- (float)computeOverallRating:(PKOClothingProbabilities *)clothingProbabilites;
- (float)computeOnlyColorRatingWithShuffleColors:(BOOL)shuffleColors;
- (float)computeOnlyProbabilityRating:(PKOClothingProbabilities *)clothingProbabilities;
- (PKOClothingCombination *)randomVariation;

- (PKOClothingItem *)randomClothingItemFromClothingItems:(NSArray *)clothingItems withBodyParts:(NSArray *)bodyParts;
- (PKOClothingItem *)randomClothingItemFromClothingItems:(NSArray *)clothingItems withClothingCategory:(PKOClothingCategory)clothingCategory;

@end