//
//  PKOClothingItem+PKOClothingCategoryContainers.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 16/04/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOClothingItem.h"
#import "PKOClothingConstants.h"

extern NSString *const PKOClothingCategoryContainerHead;
extern NSString *const PKOClothingCategoryContainerChest;
extern NSString *const PKOClothingCategoryContainerLegs;
extern NSString *const PKOClothingCategoryContainerFeet;
extern NSString *const PKOClothingCategoryContainerAccessories;

@interface PKOClothingItem (PKOClothingCategoryContainers)

+ (NSDictionary *)clothingCategoryContainers;
+ (NSArray *)clothingCategoryContainerKeys;
+ (NSString *)clothingCategoryContainerForClothingCategory:(PKOClothingCategory)clothingCategory;

@end
