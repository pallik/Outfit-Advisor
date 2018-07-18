//
//  PKOUser.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 29/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKOClothingConstants.h"

@class PKOClothingItemStore;
@class PKOClothingImageStore;
@class PKOClothingCombinationStore;
@class PKOClothingItem;
@class PKOClothingCombination;
@class UIImage;

@interface PKOUser : NSObject <NSCoding>

@property (copy, readonly, nonatomic) NSString *userID;
@property (copy, nonatomic) NSString *userName;
@property (assign, nonatomic) PKOGenderType genderType;
@property (strong, nonatomic) PKOClothingItemStore *clothingItemStore;
@property (strong, nonatomic) PKOClothingImageStore *clothingImageStore;
@property (strong, nonatomic) PKOClothingCombinationStore *clothingCombinationStore;

- (instancetype)initWithUserName:(NSString *)userName withGenderType:(PKOGenderType)genderType NS_DESIGNATED_INITIALIZER;
- (id)initWithCoder:(NSCoder *)coder NS_DESIGNATED_INITIALIZER;

- (void)saveNewClothingItem:(PKOClothingItem *)clothingItem withProcessedImage:(UIImage *)processedImage;
- (void)deleteClothingItem:(PKOClothingItem *)clothingItem;

- (void)saveNewClothingCombination:(PKOClothingCombination *)clothingCombination;

@end
