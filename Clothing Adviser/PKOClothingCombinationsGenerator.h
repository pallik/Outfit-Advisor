//
//  PKOClothingCombinationsGenerator.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 17/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKOClothingConstants.h"

@class PKOUser;

@interface PKOClothingCombinationsGenerator : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithUser:(PKOUser *)user withDressCode:(PKODressCode)dressCode NS_DESIGNATED_INITIALIZER;

- (NSArray *)generateCombinations;

@end
