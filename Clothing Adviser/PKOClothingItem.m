//
//  PKOClothingItem.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 23/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKOClothingItem.h"
#import "UIImage+ResizeMagick.h"
#import "UIImage+PKOClothingImage.h"

NSUInteger const PKOThumbnailSizeWidth = 70;
NSUInteger const PKOThumbnailSizeHeight = PKOThumbnailSizeWidth;

static NSUInteger const PKOThumbnailRadius = 10.0;
static NSUInteger const PKOThumbnailBorderWidth = 1.0;

@interface PKOClothingItem ()

@property (strong, nonatomic) UIImage *thumbnail;

@end


@implementation PKOClothingItem

#pragma mark - Lifecycle

- (instancetype)init
{
	self = [super init];
	if (self) {
		_clothingItemKey = [NSUUID UUID].UUIDString;
	}
	return self;
}

- (instancetype)initWithImage:(UIImage *)image
{
	if (self = [self init])
	{
		[self setThumbnailFromImage:image];
	}
	
	return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super init];
	if (self)
	{
		_clothingItemKey = [coder decodeObjectForKey:@"clothingItemKey"];
		_thumbnail = [coder decodeObjectForKey:@"thumbnail"];
		_dominantColors = [coder decodeObjectForKey:@"dominantColors"];
		
		_clothingCategory = [coder decodeIntegerForKey:@"clothingCategory"];
		_bodyPart = [coder decodeIntegerForKey:@"bodyPart"];
		_genderType = [coder decodeIntegerForKey:@"genderType"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:self.clothingItemKey forKey:@"clothingItemKey"];
	[coder encodeObject:self.thumbnail forKey:@"thumbnail"];
	[coder encodeObject:self.dominantColors forKey:@"dominantColors"];
	
	[coder encodeInteger:self.clothingCategory forKey:@"clothingCategory"];
	[coder encodeInteger:self.bodyPart forKey:@"bodyPart"];
	[coder encodeInteger:self.genderType forKey:@"genderType"];
}

#pragma mark - isEqual:

- (BOOL)isEqualToClothingItem:(PKOClothingItem *)clothingItem
{
	if (!clothingItem) {
		return NO;
	}
	
	return [self.clothingItemKey isEqualToString:clothingItem.clothingItemKey];
}

- (BOOL)isEqual:(id)other
{
	if (other == self) {
		return YES;
	} else if ([super isEqual:other]) {
		return YES;
	} else {
		return [self isEqualToClothingItem:(PKOClothingItem *)other];
	}
}

- (NSUInteger)hash
{
	return [self.clothingItemKey hash];
}

#pragma mark - Thumbnail handling

- (void)setThumbnailFromImage:(UIImage *)image
{
	UIImage *imageWithTransparentBackground = [image pko_imageBlackToTransparentBackground];
	UIImage *resizedImage = [imageWithTransparentBackground resizedImageByMagick:[NSString stringWithFormat:@"%lux%lu#", (unsigned long)PKOThumbnailSizeWidth, (unsigned long)PKOThumbnailSizeHeight]];
	
	self.thumbnail = [resizedImage pko_roundedImageWithRadius:PKOThumbnailRadius withBorderWidth:PKOThumbnailBorderWidth];
}

@end
















