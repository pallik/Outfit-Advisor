//
//  PKOClothingColorRating.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 30/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKOClothingColorRating : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSortedClothingItems:(NSArray *)clothingItems NS_DESIGNATED_INITIALIZER;

- (float)computeRatingWithShuffleColors:(BOOL)shuffleColors;

@end
