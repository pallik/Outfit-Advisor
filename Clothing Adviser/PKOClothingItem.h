//
//  PKOClothingItem.h
//  Clothing Adviser
//
//  Created by Pavol Kominak on 23/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKOClothingConstants.h"

@class UIImage;

extern NSUInteger const PKOThumbnailSizeWidth;
extern NSUInteger const PKOThumbnailSizeHeight;

@interface PKOClothingItem : NSObject <NSCoding>

@property (copy, readonly, nonatomic) NSString *clothingItemKey;
@property (assign, nonatomic) PKOClothingCategory clothingCategory;
@property (assign, nonatomic) PKOBodyPart bodyPart;
@property (assign, nonatomic) PKOGenderType genderType;
@property (strong, readonly, nonatomic) UIImage *thumbnail;
@property (copy, nonatomic) NSArray *dominantColors;

- (instancetype)initWithImage:(UIImage *)image;
- (void)setThumbnailFromImage:(UIImage *)image;

@end
