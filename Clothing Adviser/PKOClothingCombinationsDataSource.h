//
//  PKOClothingCombinationsDataSource.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 16/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKOClothingConstants.h"

@class PKOClothingCombinationStore;
@class PKOClothingCombination;

typedef void(^CollectionViewCellConfigureBlock)(id cell, id item);

@interface PKOClothingCombinationsDataSource : NSObject <UICollectionViewDataSource>

@property (copy, nonatomic) NSArray *clothingCombinations;
@property (copy, nonatomic) NSString *cellIdentifier;
@property (copy, nonatomic) CollectionViewCellConfigureBlock configureCellBlock;

- (PKOClothingCombination *)clothingCombinationInSection:(NSUInteger)section;

@end
