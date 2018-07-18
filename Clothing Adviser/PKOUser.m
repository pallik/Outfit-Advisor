//
//  PKOUser.m
//  Clothing Adviser
//
//  Created by Pavol Kominak on 29/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

#import "PKOUser.h"
#import "PKOClothingItemStore.h"
#import "PKOClothingImageStore.h"
#import "PKOClothingCombinationStore.h"

#import "PKOClothingItem.h"
#import "PKOClothingCombination.h"
#import "PKOClothingProbabilities.h"

static NSString *const PKOUserDefaultName = @"User";
static PKOGenderType PKOUserDefaultGenderType = PKOGenderTypeFemale;

@implementation PKOUser

#pragma mark - Lifecycle

- (instancetype)initWithUserName:(NSString *)userName withGenderType:(PKOGenderType)genderType
{
	if (self = [super init])
	{
		_userID = [NSUUID UUID].UUIDString;
		_userName = userName;
		_genderType = genderType;
		
		_clothingItemStore = [[PKOClothingItemStore alloc] init];
		_clothingImageStore = [[PKOClothingImageStore alloc] init];
		_clothingCombinationStore = [[PKOClothingCombinationStore alloc] init];
	}
	
	return self;
}

- (instancetype)init
{
	return [self initWithUserName:PKOUserDefaultName
				   withGenderType:PKOUserDefaultGenderType];
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super init];
	if (self)
	{
		//FIXME: maybe call designated init and then override properties
		_userID = [coder decodeObjectForKey:@"userID"];
		_userName = [coder decodeObjectForKey:@"userName"];
		_clothingItemStore = [coder decodeObjectForKey:@"clothingItemStore"];
//		_clothingImageStore = [coder decodeObjectForKey:@"clothingImageStore"]; //DO NOT decode, contains only big images, use only for backup
		_clothingImageStore = [[PKOClothingImageStore alloc] init];
		_clothingCombinationStore = [coder decodeObjectForKey:@"clothingCombinationStore"];
		
		_genderType = [coder decodeIntegerForKey:@"genderType"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:self.userID forKey:@"userID"];
	[coder encodeObject:self.userName forKey:@"userName"];
	[coder encodeObject:self.clothingItemStore forKey:@"clothingItemStore"];
//	[coder encodeObject:self.clothingImageStore forKey:@"clothingImageStore"]; //DO NOT encode, contains only big image, use only for backup
	[coder encodeObject:self.clothingCombinationStore forKey:@"clothingCombinationStore"];
	
	[coder encodeInteger:self.genderType forKey:@"genderType"];
}

#pragma mark - PKOClothingItem handling

- (void)saveNewClothingItem:(PKOClothingItem *)clothingItem withProcessedImage:(UIImage *)processedImage
{
	[self.clothingItemStore addClothingItem:clothingItem];
	[self.clothingImageStore setImage:processedImage forKey:clothingItem.clothingItemKey];
}

- (void)deleteClothingItem:(PKOClothingItem *)clothingItem
{
	[self.clothingImageStore deleteImageForKey:clothingItem.clothingItemKey];
	[self.clothingItemStore removeClothingItem:clothingItem];
	
	NSArray *clothingCombinationsWithClothingItem = [self.clothingCombinationStore clothingCombinationsWithClothingItem:clothingItem];
	for (PKOClothingCombination *combination in clothingCombinationsWithClothingItem)
	{
		[combination removeClothingItem:clothingItem];
		if ([combination clothingItems].count < PKOClothingCombinationMinimumClothingItems) {
			[self.clothingCombinationStore removeClothingCombination:combination];
		}
	}
}

#pragma mark - PKOClothingCombination handling

- (void)saveNewClothingCombination:(PKOClothingCombination *)clothingCombination
{
	[self.clothingCombinationStore addClothingCombination:clothingCombination];

	PKOClothingProbabilities *probabilities = [[PKOClothingProbabilities alloc] initWithUser:self
																			   withDressCode:clothingCombination.dressCode];
	
	[probabilities addNewClothingCombination:clothingCombination];
	[probabilities saveChanges];
}

@end












